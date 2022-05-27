#include "./postgre_norec.h"
#include "../include/mutate.h"
#include <iostream>

#include <regex>
#include <string>

int SQL_NOREC::count_valid_stmts(const string &input) {
  int norec_select_count = 0;
  vector<string> queries_vector = string_splitter(input, ";");
  for (string &query : queries_vector)
    if (this->is_oracle_valid_stmt(query))
      norec_select_count++;
  return norec_select_count;
}

bool SQL_NOREC::is_oracle_valid_stmt(const string &query) {
  /* By enforcing SELECT COUNT(*) FROM ... WHERE ... seems to lose some
    performance. */
  // regex_match(query,
  // regex("^\\s*SELECT\\s*COUNT\\s*\\(\\s*\\*\\s*\\)\\s*FROM(.*?)WHERE(.*?)$",
  // regex::icase | regex::optimize)) && !regex_match(query,
  // regex("^(.*?)GROUP\\s*BY(.*?)$", regex::icase | regex::optimize))
  
  if (
      ((query.find("SELECT COUNT ( * ) FROM")) != std::string::npos ||
       (query.find("select count ( * ) from")) !=
           std::string::npos) && // This is a SELECT stmt. Not INSERT or UPDATE
                                 // stmts.
      ((query.find("SELECT COUNT ( * ) FROM")) <= 5 ||
       (query.find("select count ( * ) from")) <= 5) &&
      ((query.find("INSERT")) == std::string::npos &&
       (query.find("insert")) == std::string::npos) &&
      ((query.find("UPDATE")) == std::string::npos &&
       (query.find("update")) == std::string::npos) &&
      ((query.find("WHERE")) != std::string::npos ||
       (query.find("where")) !=
           std::string::npos) && // This is a SELECT stmt that matching the
                                 // requirments of NoREC.
      ((query.find("FROM")) != std::string::npos ||
       (query.find("from")) != std::string::npos) &&
      ((query.find("GROUP BY")) == std::string::npos &&
       (query.find("group by")) ==
           std::string::npos) // TODO:: Should support group by a bit later.
  )
    return true;
  return false;
}

bool SQL_NOREC::is_oracle_select_stmt(IR* cur_stmt) {
  if (ir_wrapper.is_exist_group_by(cur_stmt) || ir_wrapper.is_exist_having(cur_stmt) || ir_wrapper.is_exist_limit(cur_stmt)) {
    return false;
  }

  // Remove UNION ALL, UNION, EXCEPT and INTERCEPT
  int num_selectclause = ir_wrapper.get_num_selectclause(cur_stmt);
  if (num_selectclause > 1 || num_selectclause == 0) {
    // cerr << "In func: SQL_NOREC::is_oracle_select_stmt(IR*), not a oracle_select because multiple selectclause detected. \n\n\n";
    return false;
  }

  if (
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_stmt, kSelectStmt, false) &&
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_stmt, kFromClause, false) &&
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_stmt, kWhereClause, false) &&
    ir_wrapper.get_num_expr_list_in_select_clause(cur_stmt) == 1
  ) {
    // cerr << "Current stmt is selectstmt, has kFromClause and kWhereClause. \n\n\n";
    vector<IR*> count_func_vec = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kFuncExpr, false);
    for (IR* count_func_ir : count_func_vec){
      // cerr << "Found count_func_ir, to_string(): " << count_func_ir->to_string() << " \n\n\n";
      if (
        ir_wrapper.get_parent_type(count_func_ir, 1) == kExpr &&
        ir_wrapper.get_parent_type(count_func_ir, 2) == kExprList  &&
        ir_wrapper.get_parent_type(count_func_ir, 3) == kSelectTarget  &&
        ir_wrapper.get_parent_type(count_func_ir, 4) == kSelectClause
      ) {
        // cerr << "count_func_ir parent structures corrected. \n\n\n";
        if (
        /* enforce COUNT(*) now */
        findStringIn(count_func_ir->left_->op_->prefix_, "COUNT") &&    // kFuncExpr -> kFuncName
        count_func_ir->right_->op_ &&   // kFuncExpr -> kFuncArgs
        count_func_ir->right_->op_->prefix_ == "*"     // Enforce * in COUNT()
        ) {
          // cerr << "count_func_ir enforce COUNT(*) succeed. \n\n\n";
          return true;
          }
      }
    }
  }
  return false;

}

bool SQL_NOREC::mark_all_valid_node(vector<IR *> &v_ir_collector) {
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
    if (ir != nullptr && ir->type_ == kSelectClause) {
      par_ir = root->locate_parent(ir);
      if (par_ir != nullptr && par_ir->type_ == kSelectStmt) {
        par_par_ir = root->locate_parent(par_ir);
        if (par_par_ir != nullptr && par_par_ir->type_ == kStmt) {
          par_par_par_ir = root->locate_parent(par_par_ir);
          if (par_par_par_ir != nullptr &&
              par_par_par_ir->type_ == kStmt) {
            g_mutator->extract_struct(ir);
            string query = ir->to_string();
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

vector<IR*> SQL_NOREC::post_fix_transform_select_stmt(IR* cur_stmt, unsigned multi_run_id){
  vector<IR*> trans_IR_vec;
  cur_stmt->parent_ = NULL;
  trans_IR_vec.push_back(cur_stmt->deep_copy()); // Save the original version. 

  vector<IR*> transformed_temp_vec = g_mutator->parse_query_str_get_ir_set(this->post_fix_temp);
  if (transformed_temp_vec.size() == 0) {
    cerr << "Error: parsing the post_fix_temp from SQL_NOREC::post_fix_transform_select_stmt returns empty IR vector. \n";
    vector<IR*> tmp; return tmp;
  }

  // cerr << "The post_fix_temp is: " << post_fix_temp << "\n\n\n";
  // cerr << "The parsed transformed_temp_vec string is: " << transformed_temp_vec.back()->to_string() << "\n\n\n";

  IR* transformed_temp_ir = transformed_temp_vec.back();
  IR* trans_stmt_ir = transformed_temp_ir->left_->left_->left_->deep_copy();      // Program -> stmtlist -> stmt -> transformed_stmt;
  trans_stmt_ir->parent_ = NULL;
  transformed_temp_ir->deep_drop();

  vector<IR*> src_order_vec = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kOptOrderClause, false);
  if (src_order_vec.size() > 0) {
    IR* src_order_clause = src_order_vec[0]->deep_copy();
    IR* dest_order_clause = ir_wrapper.get_ir_node_in_stmt_with_type(trans_stmt_ir, kOptOrderClause, true)[0];
    if (!trans_stmt_ir->swap_node(dest_order_clause, src_order_clause)){
      trans_stmt_ir->deep_drop();
      src_order_clause->deep_drop();
      cerr << "Error: swap_node failed for order_clause. In function SQL_NOREC::post_fix_transform_select_stmt. \n";
      vector<IR*> tmp; return tmp;
    }
    dest_order_clause->deep_drop();
  }

  IR* src_where_expr = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kWhereClause, false)[0]->left_->deep_copy();
  vector<IR*> dest_where_vec = ir_wrapper.get_ir_node_in_stmt_with_type(trans_stmt_ir, kFuncExpr, true);
  // cerr << "Getting from the trans_stmt_ir, the first kFuncExpr subquery is: " << dest_where_vec[0] -> to_string() << "\n";
  IR* dest_where_expr = dest_where_vec[0]->right_->left_;  // kFuncExpr -> kFuncArgs -> kExpr

  IR* src_from_expr = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kFromClause, false)[0]->left_->deep_copy();
  vector<IR*> dest_from_vec = ir_wrapper.get_ir_node_in_stmt_with_type(trans_stmt_ir, kFromClause, true);
  // cerr << "Getting from the trans_stmt_ir, the first kFromClause subquery is: " << dest_from_vec[0] -> to_string() << "\n";
  IR* dest_from_expr = dest_from_vec[0]->left_;

  if (!trans_stmt_ir->swap_node(dest_where_expr, src_where_expr)){
    trans_stmt_ir->deep_drop();
    src_where_expr->deep_drop();
    src_from_expr->deep_drop();
    cerr << "Error: swap_node failed for where_clause. In function SQL_NOREC::post_fix_transform_select_stmt. \n";
    vector<IR*> tmp; return tmp;
  }
  dest_where_expr->deep_drop();
  if (!trans_stmt_ir->swap_node(dest_from_expr, src_from_expr)) {
    trans_stmt_ir->deep_drop();
    src_from_expr->deep_drop();
    cerr << "Error: swap_node failed for from_clause. In function SQL_NOREC::post_fix_transform_select_stmt. \n";
    vector<IR*> tmp; return tmp;  
  }
  dest_from_expr->deep_drop();

  trans_IR_vec.push_back(trans_stmt_ir);

  return trans_IR_vec;

}

void SQL_NOREC::rewrite_valid_stmt_from_ori(string &query, string &rew_1,
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
  // string select_stmt;
  string from_stmt;
  string where_stmt;
  string extra_stmt;

  before_select_stmt = query.substr(0, select_position - 0);

  // select_stmt =
  //     query.substr(select_position + 6, from_position - select_position - 6);

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

  // cout << "before_select_stmt: " << before_select_stmt << endl;
  // cout << "select_stmt: " << select_stmt << endl;
  // cout << "from_stmt: " << from_stmt << endl;
  // cout << "where_stmt: " << where_stmt << endl;
  // cout << "extra_stmt: " << extra_stmt << endl;

  // if (select_stmt.find('*') != string::npos)
  //   select_stmt = "";

  /* Ignore the select_stmt. The select_stmt should always be SELECT COUNT ( *
   * ). Otherwise, there will be errors. */
  string rewrited_string =
      before_select_stmt + " SELECT ALL(" + where_stmt + ")::INT as count";
  // if (select_stmt != "" && select_stmt != " ")
  // {
  //   rewrited_string += "  AND  " + select_stmt;
  // }
  if (from_stmt != "") {
    rewrited_string += " FROM " + from_stmt;
  }

  if (extra_stmt != "") {
    rewrited_string += extra_stmt;
  }

  // cout << "rewrited_string: " << rewrited_string << endl;

  // The ";" symbol should be taken cared of by the caller function.
  rew_1 = "SELECT COALESCE(SUM(count),0) FROM (" + rewrited_string + ") as res;";
  rew_2 = "";
  rew_3 = "";
}

string SQL_NOREC::remove_valid_stmts_from_str(string query) {
  string output_query = "";
  vector<string> queries_vector = string_splitter(query, ";");

  for (auto current_stmt : queries_vector) {
    if (is_str_empty(current_stmt))
      continue;
    if (!is_oracle_valid_stmt(current_stmt))
      output_query += current_stmt + "; ";
  }

  return output_query;
}

void SQL_NOREC::compare_results(ALL_COMP_RES &res_out) {

  res_out.final_res = ORA_COMP_RES::Pass;
  bool is_all_err = true;

  for (COMP_RES &res : res_out.v_res) {
    if (findStringIn(res.res_str_0, "Error") ||
        findStringIn(res.res_str_1, "Error")) {
      res.comp_res = ORA_COMP_RES::Error;
      res.res_int_0 = -1;
      res.res_int_1 = -1;
      continue;
    }
    try {
      res.res_int_0 = stoi(res.res_str_0);
      // cout << "res_int_0: " << res.res_int_0 << endl;
      res.res_int_1 = stoi(res.res_str_1);
      // cout << "res_int_1: " << res.res_int_1 << endl;
    } catch (std::invalid_argument &e) {
      res.comp_res = ORA_COMP_RES::Error;
      continue;
    } catch (std::out_of_range &e) {
      continue;
    }
    is_all_err = false;
    if (res.res_int_0 != res.res_int_1) { // Found mismatched.
      res.comp_res = ORA_COMP_RES::Fail;
      res_out.final_res = ORA_COMP_RES::Fail;
    } else {
      res.comp_res = ORA_COMP_RES::Pass;
    }
  }

  if (is_all_err && res_out.final_res != ORA_COMP_RES::Fail)
    res_out.final_res = ORA_COMP_RES::ALL_Error;
  return;
}
