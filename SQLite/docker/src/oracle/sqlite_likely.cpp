#include "./sqlite_likely.h"
#include "../include/mutator.h"
#include <iostream>

#include <algorithm>
#include <regex>
#include <string>

int SQL_LIKELY::count_valid_stmts(const string &input) {
  int norec_select_count = 0;
  vector<string> queries_vector = string_splitter(input, ';');
  for (string &query : queries_vector)
    if (this->is_oracle_valid_stmt(query))
      norec_select_count++;
  return norec_select_count;
}

bool SQL_LIKELY::is_oracle_valid_stmt(const string &query) {
  if (
      /* By enforcing SELECT COUNT(*) FROM ... WHERE ... seems to lose some
         performance. */
      regex_match(query, regex("^\\s*SELECT\\s*COUNT\\s*\\(\\s*\\*\\s*\\)\\s*"
                               "FROM(.*?)WHERE(.*?)$",
                               regex::icase)) &&
      !regex_match(query, regex("^(.*?)GROUP\\s*BY(.*?)$", regex::icase)))
    return true;
  return false;
}

bool SQL_LIKELY::mark_all_valid_node(vector<IR *> &v_ir_collector) {
  bool is_mark_successfully = false;

  IR *root = v_ir_collector[v_ir_collector.size() - 1];
  IR *par_ir = nullptr;
  IR *par_par_ir = nullptr;
  IR *par_par_par_ir = nullptr; // If we find the correct selectnoparen, this
                                // should be the statementlist.
  for (auto ir : v_ir_collector) {
    if (ir != nullptr)
      ir->is_node_struct_fixed = false;
  }
  for (auto ir : v_ir_collector) {
    if (ir != nullptr && ir->type_ == kSelectCore) {
      par_ir = root->locate_parent(ir);
      if (par_ir != nullptr && par_ir->type_ == kSelectStatement) {
        par_par_ir = root->locate_parent(par_ir);
        if (par_par_ir != nullptr && par_par_ir->type_ == kStatement) {
          par_par_par_ir = root->locate_parent(par_par_ir);
          if (par_par_par_ir != nullptr &&
              par_par_par_ir->type_ == kStatementList) {
            string query = g_mutator->extract_struct(ir);
            if (!(this->is_oracle_valid_stmt(query)))
              continue; // Not norec compatible. Jump to the next ir.
            query.clear();
            is_mark_successfully = this->mark_node_valid(ir);
            // cerr << "\n\n\nThe marked norec ir is: " <<
            // this->extract_struct(ir) << " \n\n\n";
            par_ir->is_node_struct_fixed = true;
            par_par_ir->is_node_struct_fixed = true;
            par_par_par_ir->is_node_struct_fixed = true;
          }
        }
      }
    }
  }

  return is_mark_successfully;
}

void SQL_LIKELY::rewrite_valid_stmt_from_ori(string &query, string &rew_1,
                                             string &rew_2, string &rew_3,
                                             unsigned multi_run_id) {
  // vector<string> stmt_vector = string_splitter(query,
  // "where|WHERE|SELECT|select|FROM|from");

  while (query[0] == ' ' || query[0] == '\n' ||
         query[0] == '\t') { // Delete duplicated whitespace at the beginning.
    query = query.substr(1, query.size() - 1);
  }

  size_t select_position = 0;
  size_t from_position = -1;
  size_t where_position = -1;
  size_t group_by_position = -1;
  size_t order_by_position = -1;

  vector<size_t> op_lp_v;
  vector<size_t> op_rp_v;

  size_t tmp1 = 0, tmp2 = 0;
  while ((tmp1 = query.find("(", tmp1)) && tmp1 != string::npos) {
    op_lp_v.push_back(tmp1);
    tmp1++;
    if (tmp1 == query.size()) {
      break;
    }
  }
  while ((tmp2 = query.find(")", tmp2)) && tmp2 != string::npos) {
    op_rp_v.push_back(tmp2);
    tmp2++;
    if (tmp2 == query.size()) {
      break;
    }
  }

  if (op_lp_v.size() !=
      op_rp_v.size()) { // The symbol of '(' and ')' is not matched. Ignore all
                        // the '()' symbol.
    op_lp_v.clear();
    op_rp_v.clear();
  }

  for (int i = 0; i < op_lp_v.size();
       i++) { // The symbol of '(' and ')' is not matched. Ignore all the '()'
              // symbol.
    if (op_lp_v[i] > op_rp_v[i]) {
      op_lp_v.clear();
      op_rp_v.clear();
    }
  }

  tmp1 = -1;
  tmp2 = -1;

  tmp1 = query.find("SELECT",
                    0); // The first SELECT statement will always be the correct
                        // outter most SELECT statement. Pick its pos.
  tmp2 = query.find("select", 0);
  if (tmp1 != string::npos) {
    select_position = tmp1;
  }
  if (tmp2 != string::npos && tmp2 < tmp1) {
    select_position = tmp2;
  }

  tmp1 = 0;
  tmp2 = 0;
  from_position = -1;

  do {
    if (tmp1 != string::npos)
      tmp1 = query.find("FROM", tmp1 + 4);
    if (tmp2 != string::npos)
      tmp2 = query.find("from", tmp2 + 4);

    if (tmp1 != string::npos) {
      bool is_ignore = false;
      for (int i = 0; i < op_lp_v.size(); i++) {
        if (tmp1 > op_lp_v[i] && tmp1 < op_rp_v[i]) {
          is_ignore = true;
          break;
        }
      }
      if (!is_ignore) {
        from_position = tmp1;
        break; // from_position is found. Break the outter do...while loop.
      }
    }

    if (tmp2 != string::npos) {
      bool is_ignore = false;
      for (int i = 0; i < op_lp_v.size(); i++) {
        if (tmp2 > op_lp_v[i] && tmp2 < op_rp_v[i]) {
          is_ignore = true;
          break;
        }
      }
      if (!is_ignore) {
        from_position = tmp2;
        break; // from_position is found. Break the outter do...while loop.
      }
    }

  } while (tmp1 != string::npos || tmp2 != string::npos);

  tmp1 = 0;
  tmp2 = 0;
  where_position = -1;

  do {
    if (tmp1 != string::npos)
      tmp1 = query.find("WHERE", tmp1 + 5);
    if (tmp2 != string::npos)
      tmp2 = query.find("where", tmp2 + 5);

    if (tmp1 != string::npos) {
      bool is_ignore = false;
      for (int i = 0; i < op_lp_v.size(); i++) {
        if (tmp1 > op_lp_v[i] && tmp1 < op_rp_v[i]) {
          is_ignore = true;
          break;
        }
      }
      if (!is_ignore) {
        where_position = tmp1;
        break; // where_position is found. Break the outter do...while loop.
      }
    }

    if (tmp2 != string::npos) {
      bool is_ignore = false;
      for (int i = 0; i < op_lp_v.size(); i++) {
        if (tmp2 > op_lp_v[i] && tmp2 < op_rp_v[i]) {
          is_ignore = true;
          break;
        }
      }
      if (!is_ignore) {
        where_position = tmp2;
        break; // where_position is found. Break the outter do...while loop.
      }
    }

  } while (tmp1 != string::npos || tmp2 != string::npos);

  /*** Taking care of GROUP BY stmt.   ***/
  tmp1 = -1, tmp2 = -1;
  size_t tmp = 0;
  while ((tmp = query.find("GROUP BY", tmp + 8)) && (tmp != string::npos)) {
    bool is_ignore = false;
    for (int i = 0; i < op_lp_v.size(); i++) {
      if (tmp > op_lp_v[i] && tmp < op_rp_v[i]) {
        is_ignore = true;
        break;
      }
    }
    if (!is_ignore) {
      tmp1 = tmp;
    }
  } // The last GROUP BY statement outside the bracket will always be the
    // correct outter most GROUP BY statement. Pick its pos.

  tmp = -8;
  while ((tmp = query.find("group by", tmp + 8)) && (tmp != string::npos)) {
    bool is_ignore = false;
    for (int i = 0; i < op_lp_v.size(); i++) {
      if (tmp > op_lp_v[i] && tmp < op_rp_v[i]) {
        is_ignore = true;
        break;
      }
    }
    if (!is_ignore) {
      tmp2 = tmp;
    }
  } // The last GROUP BY statement outside the bracket will always be the
    // correct outter most GROUP BY statement. Pick its pos.
  if (tmp1 != string::npos) {
    group_by_position = tmp1;
  }
  if (tmp2 != string::npos && tmp2 > tmp1) {
    group_by_position = tmp2;
  }

  /*** Taking care of ORDER BY stmt.   ***/
  tmp1 = -1, tmp2 = -1;
  tmp = -8;
  while ((tmp = query.find("ORDER BY", tmp + 8)) && (tmp != string::npos)) {
    bool is_ignore = false;
    for (int i = 0; i < op_lp_v.size(); i++) {
      if (tmp > op_lp_v[i] && tmp < op_rp_v[i]) {
        is_ignore = true;
        break;
      }
    }
    if (!is_ignore) {
      tmp1 = tmp;
    }
  } // The last ORDER BY statement outside the bracket will always be the
    // correct outter most GROUP BY statement. Pick its pos.
  tmp = -8;
  while ((tmp = query.find("order by", tmp + 8)) && (tmp != string::npos)) {
    bool is_ignore = false;
    for (int i = 0; i < op_lp_v.size(); i++) {
      if (tmp > op_lp_v[i] && tmp < op_rp_v[i]) {
        is_ignore = true;
        break;
      }
    }
    if (!is_ignore) {
      tmp2 = tmp;
    }
  } // The last order by statement outside the bracket will always be the
    // correct outter most GROUP BY statement. Pick its pos.
  if (tmp1 != string::npos) {
    order_by_position = tmp1;
  }
  if (tmp2 != string::npos && tmp2 > tmp1) {
    order_by_position = tmp2;
  }

  size_t extra_stmt_position = -1;
  if (group_by_position != string::npos && order_by_position != string::npos)
    extra_stmt_position =
        ((group_by_position < order_by_position) ? group_by_position
                                                 : order_by_position);
  else if (group_by_position != string::npos)
    extra_stmt_position = group_by_position;
  else if (order_by_position != string::npos)
    extra_stmt_position = order_by_position;

  string before_select_stmt;
  string select_stmt;
  string from_stmt;
  string where_stmt;
  string extra_stmt;

  before_select_stmt = query.substr(0, select_position - 0);

  select_stmt =
      query.substr(select_position + 6, from_position - select_position - 6);

  if (from_position == -1)
    from_stmt = "";
  else
    from_stmt =
        query.substr(from_position + 4, where_position - from_position - 4);

  if (where_position == -1)
    where_stmt = "";
  else if (extra_stmt_position == -1)
    where_stmt =
        query.substr(where_position + 5, query.size() - where_position - 5);
  else
    where_stmt = query.substr(where_position + 5,
                              extra_stmt_position - where_position - 5);

  if (extra_stmt_position == -1)
    extra_stmt = "";
  else
    extra_stmt =
        query.substr(extra_stmt_position, query.size() - extra_stmt_position);

  // if (select_stmt.find('*') != string::npos)
  //   select_stmt = "";

  rew_1 = before_select_stmt + " SELECT COUNT ( * ) FROM " + from_stmt +
          " WHERE LIKELY ( " + where_stmt + " )";
  rew_2 = before_select_stmt + " SELECT COUNT ( * ) FROM " + from_stmt +
          " WHERE UNLIKELY ( " + where_stmt + " )";
  rew_3 = "";
}

string SQL_LIKELY::remove_valid_stmts_from_str(string query) {
  string output_query = "";
  vector<string> queries_vector = string_splitter(query, ';');

  for (auto current_stmt : queries_vector) {
    if (is_str_empty(current_stmt))
      continue;
    if (!is_oracle_valid_stmt(current_stmt))
      output_query += current_stmt + "; ";
  }

  return output_query;
}

void SQL_LIKELY::get_v_valid_type(
    const string &cmd_str, vector<VALID_STMT_TYPE_LIKELY> &v_valid_type) {
  size_t begin_idx = cmd_str.find("SELECT 'BEGIN VERI 0';", 0);
  size_t end_idx = cmd_str.find("SELECT 'END VERI 0';", 0);

  while (begin_idx != string::npos) {
    if (end_idx != string::npos) {
      string cur_cmd_str =
          cmd_str.substr(begin_idx + 21, (end_idx - begin_idx - 21));
      begin_idx = cmd_str.find("SELECT 'BEGIN VERI", begin_idx + 21);
      end_idx = cmd_str.find("SELECT 'END VERI", end_idx + 21);

      if (((findStringIter(cur_cmd_str, "SELECT DISTINCT MIN") -
            cur_cmd_str.begin()) < 5) ||
          ((findStringIter(cur_cmd_str, "SELECT MIN") - cur_cmd_str.begin()) <
           5) ||
          ((findStringIter(cur_cmd_str, "SELECT DISTINCT MAX") -
            cur_cmd_str.begin()) < 5) ||
          ((findStringIter(cur_cmd_str, "SELECT MAX") - cur_cmd_str.begin()) <
           5) ||
          ((findStringIter(cur_cmd_str, "SELECT DISTINCT SUM") -
            cur_cmd_str.begin()) < 5) ||
          ((findStringIter(cur_cmd_str, "SELECT SUM") - cur_cmd_str.begin()) <
           5) ||
          ((findStringIter(cur_cmd_str, "SELECT DISTINCT COUNT") -
            cur_cmd_str.begin()) < 5) ||
          ((findStringIter(cur_cmd_str, "SELECT COUNT") - cur_cmd_str.begin()) <
           5)) {
        v_valid_type.push_back(VALID_STMT_TYPE_LIKELY::UNIQ);
        // cerr << "query: " << cur_cmd_str << " \nMIN. \n";
      } else {
        v_valid_type.push_back(VALID_STMT_TYPE_LIKELY::NORM);
        // cerr << "query: " << cur_cmd_str << " \nNORM. \n";
      }
    } else {
      break; // For the current begin_idx, we cannot find the end_idx. Ignore
             // the current output.
    }
  }
  return;
}

void SQL_LIKELY::compare_results(ALL_COMP_RES &res_out) {

  res_out.final_res = Pass;

  vector<VALID_STMT_TYPE_LIKELY> v_valid_type;
  this->get_v_valid_type(res_out.cmd_str, v_valid_type);

  bool is_all_errors = true;
  int i = 0;
  for (COMP_RES &res : res_out.v_res) {
    switch (v_valid_type[i++]) {
    case VALID_STMT_TYPE_LIKELY::NORM:
      if (!this->compare_norm(res))
        is_all_errors = false;
      break;
    case VALID_STMT_TYPE_LIKELY::UNIQ:
      if (!this->compare_uniq(res))
        is_all_errors = false;
      break;
    }
    if (res.comp_res == ORA_COMP_RES::Fail)
      res_out.final_res = ORA_COMP_RES::Fail;
  }

  if (is_all_errors && res_out.final_res != ORA_COMP_RES::Fail)
    res_out.final_res = ORA_COMP_RES::ALL_Error;

  return;
}

bool SQL_LIKELY::compare_norm(
    COMP_RES
        &res) { /* Handle normal valid stmt: SELECT * FROM ...; Return is_err */

  const string &res_str_0 = res.res_str_0;
  const string &res_str_1 = res.res_str_1;
  const string &res_str_2 = res.res_str_2;
  int &res_int_0 = res.res_int_0;
  int &res_int_1 = res.res_int_1;
  int &res_int_2 = res.res_int_2;

  res_int_0 = 0;
  res_int_1 = 0;
  res_int_2 = 0;

  if (res_str_0.find("Error") != string::npos ||
      res_str_1.find("Error") != string::npos ||
      res_str_2.find("Error") != string::npos) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  vector<string> v_res_0 = string_splitter(res_str_0, '\n');
  vector<string> v_res_1 = string_splitter(res_str_1, '\n');
  vector<string> v_res_2 = string_splitter(res_str_2, '\n');

  for (const string &r : v_res_0) {
    if (is_str_empty(r))
      --res_int_0;
  }
  for (const string &r : v_res_1) {
    if (is_str_empty(r))
      --res_int_1;
  }
  for (const string &r : v_res_2) {
    if (is_str_empty(r))
      --res_int_2;
  }

  res_int_0 += std::count(res_str_0.begin(), res_str_0.end(), "\n");
  res_int_1 += std::count(res_str_1.begin(), res_str_1.end(), "\n");
  res_int_2 += std::count(res_str_2.begin(), res_str_2.end(), "\n");

  if (res_int_0 != res_int_1 || res_int_0 != res_int_2) {
    res.comp_res = ORA_COMP_RES::Fail;
    return false;
  }

  res.comp_res = ORA_COMP_RES::Pass;
  return false;
}

bool SQL_LIKELY::compare_uniq(COMP_RES &res) {

  const string &res_str_0 = res.res_str_0;
  const string &res_str_1 = res.res_str_1;
  const string &res_str_2 = res.res_str_2;

  if (res_str_0.find("Error") != string::npos ||
      res_str_1.find("Error") != string::npos ||
      res_str_2.find("Error") != string::npos) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  if (res_str_0 != res_str_1 || res_str_0 != res_str_2) {
    res.comp_res = ORA_COMP_RES::Fail;
    return false;
  }

  res.comp_res = ORA_COMP_RES::Pass;
  return false;
}

bool SQL_LIKELY::is_oracle_select_stmt(IR* cur_IR) {

  // // Remove GROUP BY and HAVING stmts. 
  // if (ir_wrapper.is_exist_group_by(cur_IR) || ir_wrapper.is_exist_having(cur_IR)) {
  //   return false;
  // }

  if (
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_IR, kSelectStatement, false) &&
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_IR, kFromClause, false) &&
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_IR, kWhereExpr, false)
    // ir_wrapper.get_num_result_column_in_select_clause(cur_IR) == 1
  ) {
    return true;
  }
  return false;
}

vector<IR*> SQL_LIKELY::post_fix_transform_select_stmt(IR* cur_stmt, unsigned multi_run_id) {

  vector<IR*> trans_IR_vec;
  IR* ori_ir_root = cur_stmt;
  trans_IR_vec.push_back(ori_ir_root->deep_copy());

  // ADDED LIKELY.
  cur_stmt = ori_ir_root->deep_copy();
  IR* expr_in_where = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kWhereExpr, false)[0]->left_;
  // Add LIKELY functions. 
  IR* cur_where_expr = expr_in_where;
  cur_where_expr = this->ir_wrapper.add_func(cur_where_expr, "LIKELY");
  if (cur_where_expr == nullptr) {
    cerr << "Error: ir_wrapper>add_func() failed. Func: SQL_LIKELY::post_fix_transform_select_stmt(). Return empty vector. \n";
    trans_IR_vec[0]->deep_drop();
    cur_stmt->deep_drop();
    vector<IR*> tmp;
    return tmp;
  }
  trans_IR_vec.push_back(cur_stmt);

  // Added UNLIKELY
  cur_stmt = ori_ir_root->deep_copy();
  expr_in_where = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kWhereExpr, false)[0]->left_;
  // Add UNLIKELY functions. 
  cur_where_expr = expr_in_where;
  cur_where_expr = this->ir_wrapper.add_func(cur_where_expr, "UNLIKELY");
  if (cur_where_expr == nullptr) {
    cerr << "Error: ir_wrapper>add_func() failed. Func: SQL_LIKELY::post_fix_transform_select_stmt(). Return empty vector. \n";
    trans_IR_vec[0]->deep_drop();
    cur_stmt->deep_drop();
    vector<IR*> tmp;
    return tmp;
  }
  trans_IR_vec.push_back(cur_stmt);

  return trans_IR_vec;

}