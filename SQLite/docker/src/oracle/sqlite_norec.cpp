#include "./sqlite_norec.h"
#include "../include/mutator.h"
#include <iostream>

#include <fstream> // Debug purpose. 

#include <regex>
#include <string>

int SQL_NOREC::count_valid_stmts(const string &input) {
  int norec_select_count = 0;
  vector<string> queries_vector = string_splitter(input, ';');
  for (string &query : queries_vector)
    if (this->is_oracle_valid_stmt(query))
      norec_select_count++;
  return norec_select_count;
}

bool SQL_NOREC::is_oracle_valid_stmt(const string &query) {
  if (
      /* By enforcing SELECT COUNT(*) FROM ... WHERE ... seems to lose some
         performance. */
      // regex_match(query,
      // regex("^\\s*SELECT\\s*COUNT\\s*\\(\\s*\\*\\s*\\)\\s*FROM(.*?)WHERE(.*?)$",
      // regex::icase | regex::optimize)) && !regex_match(query,
      // regex("^(.*?)GROUP\\s*BY(.*?)$", regex::icase | regex::optimize))

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
  string select_stmt;
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

  // if (select_stmt.find('*') != string::npos)
  //   select_stmt = "";

  /* Ignore the select_stmt. The select_stmt should always be SELECT COUNT ( *
   * ). Otherwise, there will be errors. */
  string rewrited_string =
      before_select_stmt + " SELECT TOTAL(CAST((" + where_stmt;
  // if (select_stmt != "" && select_stmt != " ")
  // {
  //   rewrited_string += "  AND  " + select_stmt;
  // }
  rewrited_string += ") AS BOOL)!=0) ";
  if (from_stmt != "") {
    rewrited_string += " FROM " + from_stmt;
  }

  if (extra_stmt != "") {
    rewrited_string += extra_stmt;
  }

  // The ";" symbol should be taken cared of by the caller function.
  rew_1 = rewrited_string;
  rew_2 = "";
  rew_3 = "";
}

string SQL_NOREC::remove_valid_stmts_from_str(string query) {
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
      res.res_int_1 = stoi(res.res_str_1);
    } catch (std::invalid_argument &e) {
      res.comp_res = ORA_COMP_RES::Error;
      continue;
    } catch (std::out_of_range &e) {
      res.comp_res = ORA_COMP_RES::Error;
      continue;
    } catch (const std::exception& e) {
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

bool SQL_NOREC::is_oracle_select_stmt(IR* cur_IR) {

  // Remove GROUP BY and HAVING stmts. 
  if (ir_wrapper.is_exist_group_by(cur_IR) || ir_wrapper.is_exist_having(cur_IR)) {
    return false;
  }

  // Remove UNION ALL, UNION, EXCEPT and INTERCEPT
  int num_selectcore = ir_wrapper.get_num_selectcore(cur_IR);
  if (num_selectcore > 1 || num_selectcore == 0) {
    // if (cur_IR->type_ == kSelectStatement) {
    //   cerr << "Getting num_selectcore is: " << num_selectcore << ". In func: SQL_NOREC::is_oracle_select_stmt; \n";
    // } else {
    //   cerr << "Getting statement type_: " << cur_IR->type_ << ". In func: SQL_NOREC::is_oracle_select_stmt; \n";
    // }
    return false;
  }

  if (
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_IR, kSelectStatement, false) &&
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_IR, kFromClause, false) &&
    ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_IR, kWhereExpr, false) &&
    ir_wrapper.get_num_result_column_in_select_clause(cur_IR) == 1
  ) {
    vector<IR*> function_name_vec = ir_wrapper.get_ir_node_in_stmt_with_type(cur_IR, kFunctionName, false);
    for (IR* func_name_ir : function_name_vec){
      if (
        ir_wrapper.get_parent_type(func_name_ir, 1) == kNewExpr &&
        ir_wrapper.get_parent_type(func_name_ir, 2) == kResultColumn  &&
        ir_wrapper.get_parent_type(func_name_ir, 3) == kResultColumnList  &&
        ir_wrapper.get_parent_type(func_name_ir, 4) == kSelectCore &&
        findStringIn(func_name_ir->left_->str_val_, "count") &&  // enforce COUNT()
        // kFuncNane->kNewExpr->kUnknown->kUnknown->kFuncArgs->str_val_. 
        ir_wrapper.get_parent_with_a_type(func_name_ir, 1)->left_->left_->right_->str_val_ == "*"  // enforce COUNT(*). 
        ) {
          return true;
          }
    }
  }
  return false;
}

vector<IR*> SQL_NOREC::post_fix_transform_select_stmt(IR* cur_stmt, unsigned multi_run_id) {

  vector<IR*> trans_IR_vec;

  cur_stmt = cur_stmt->deep_copy();

  vector<IR*> opt_over_clause_vec = this->ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kOptOverClause, false);

  vector<IR*> ori_opt_over_clause_vec;
  for (auto opt_over_clause_ir : opt_over_clause_vec) {
    // Replace the opt_over_clause to an empty ir. 
    IR* new_opt_over_clause_ir = new IR(kOptOverClause, string(""));
    /* If the current opt_over_clause_ir has been removed from the tree by previous iterations, swap_node() will fail. */
    if (!cur_stmt->swap_node(opt_over_clause_ir, new_opt_over_clause_ir)) { 
      new_opt_over_clause_ir->deep_drop();
      // cerr << "Error: swap_node failure. Seems to be expected. In func: SQL_NOREC::post_fix_transform_select_stmt(). \n";
      continue;
    }
    // Delayed deep_drop(). Possible child opt_over_clause inside the current node, which would be iterated later. 
    ori_opt_over_clause_vec.push_back(opt_over_clause_ir);
  }
  for (auto ori_opt_over_clause_ir : ori_opt_over_clause_vec) {
    ori_opt_over_clause_ir->deep_drop();
  }


  trans_IR_vec.push_back(cur_stmt);

  cur_stmt = cur_stmt->deep_copy(); // Already applied changes in the previous lines. 

  IR* expr_in_where = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kWhereExpr, false)[0]->left_;

  /* Take care of WHERE statement. */
  IR* opt_where_clause = expr_in_where->get_parent()->get_parent();  // ->kWhereExpr->kOptWhere
  IR* new_opt_where = new IR(kOptWhere, string(""));
  if (!cur_stmt->swap_node(opt_where_clause, new_opt_where)) {
    cerr << "\n\n\n\nError: Swap node failed in SQL_NOREC::post_fix_transform_select_stmt. \n ";
    trans_IR_vec[0]->deep_drop();
    cur_stmt->deep_drop();
    vector<IR*> tmp;
    return tmp;
  }

  IR* expr_in_where_copy = expr_in_where->deep_copy();
  expr_in_where_copy->parent_ = nullptr;
  opt_where_clause->deep_drop(); // expr_in_where won't be affected. 

  /* Take care of SELECT statement. */
  IR* first_result_column = ir_wrapper.get_result_column_in_select_clause_in_select_stmt(cur_stmt, 0);
  if (first_result_column == nullptr) {
    ofstream output;
    cerr << "\n\n\n\nError: Failed to retrive first_result_column\n ";
    trans_IR_vec[0]->deep_drop();
    cur_stmt->deep_drop();
    vector<IR*> tmp;
    return tmp;
  } 
  IR* select_ori_expr = first_result_column->left_;
  
  if (select_ori_expr == nullptr || first_result_column->right_ == nullptr) {
    cerr << "\n\n\n\nError: Cannot find cur_select_expr from the ir_root. Logical error in code. \n \
    In func: SQL_NOREC::post_fix_transform_select_stmt. Return empty vector. \n";
    trans_IR_vec[0]->deep_drop();
    cur_stmt->deep_drop();
    vector<IR*> tmp;
    return tmp;
  }

  cur_stmt->swap_node(select_ori_expr, expr_in_where_copy);
  select_ori_expr->deep_drop();

  // Add cast and COUNT functions. 
  IR* cur_select_expr = expr_in_where_copy;
  cur_select_expr = this->ir_wrapper.add_cast_expr(cur_select_expr, string("BOOL"));
  if (cur_select_expr == nullptr) {
    cerr << "Error: ir_wrapper>add_cast_expr() failed. Func: SQL_NOREC::post_fix_transform_select_stmt(). Return empty vector. \n";
    trans_IR_vec[0]->deep_drop();
    cur_stmt->deep_drop();
    vector<IR*> tmp;
    return tmp;
  }
  auto num_literal_zero_ir = new IR(kNumericLiteral, string("0"));
  auto num_literal_expr = new IR(kNewExpr, OP0(), num_literal_zero_ir);
  cur_select_expr = this->ir_wrapper.add_binary_op(cur_select_expr, cur_select_expr, num_literal_expr, "!=", false, true);
  if (cur_select_expr == nullptr) {
    cerr << "Error: ir_wrapper>add_binary_op() failed. Func: SQL_NOREC::post_fix_transform_select_stmt(). Return empty vector. \n";
    trans_IR_vec[0]->deep_drop();
    cur_stmt->deep_drop();
    vector<IR*> tmp;
    return tmp;
  }
  cur_select_expr = this->ir_wrapper.add_func(cur_select_expr, "TOTAL");
  if (cur_select_expr == nullptr) {
    cerr << "Error: ir_wrapper>add_func() failed. Func: SQL_NOREC::post_fix_transform_select_stmt(). Return empty vector. \n";
    trans_IR_vec[0]->deep_drop();
    cur_stmt->deep_drop();
    vector<IR*> tmp;
    return tmp;
  }

  trans_IR_vec.push_back(cur_stmt);

  return trans_IR_vec;

}