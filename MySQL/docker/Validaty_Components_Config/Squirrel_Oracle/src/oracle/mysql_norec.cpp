#include "mysql_norec.h"
#include "../include/mutate.h"
#include <iostream>
#include <chrono>

#include <regex>
#include <string>

bool SQL_NOREC::is_oracle_select_stmt(IR* cur_stmt) {

  // auto single_is_oracle_select_func_start_time = std::chrono::system_clock::now();

  if (cur_stmt == NULL) {
    // cerr << "Return false because cur_stmt is NULL; \n";
    return false;
  }

  if (cur_stmt->get_ir_type() != kSelectStmt) {
    // cerr << "Return false because this is not a SELECT stmt: " << get_string_by_ir_type(cur_stmt->get_ir_type()) <<  " \n";
    return false;
  }

  // g_mutator->debug(cur_stmt, 0);

  /* Remove cases that contains kGroupClause, kHavingClause and kLimitClause */
  if (
      ir_wrapper.is_exist_group_clause(cur_stmt) ||
      ir_wrapper.is_exist_having_clause(cur_stmt) ||
      ir_wrapper.is_exist_limit_clause(cur_stmt) ||
      ir_wrapper.is_exist_window_func_call(cur_stmt)
  ) {
      return false;
  }

  // Ignore statements with UNION, EXCEPT and INTERCEPT
  if (ir_wrapper.is_exist_set_operator(cur_stmt)) {
    // cerr << "Return false because of set operator \n";
    return false;
  }

  /* If it is an NOREC compatible select statment,
   * there would be only one kSelectItem.
   * */
  vector<IR*> v_select_item_ir = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kFunctionNameMark, false);
  if (v_select_item_ir.size() != 1) {return false;}

  IR* select_item_ir = v_select_item_ir.front();

  // auto single_is_ir_in_start_time = std::chrono::system_clock::now();

  /* Next, check whether there are COUNT(*) func */
  IR* count_iden = select_item_ir->get_left();
  if (!count_iden) {
    return false;
  }

  if (select_item_ir->to_string() != "SELECT COUNT ( * ") {
    cerr << "count_id str_val_\n|" << select_item_ir->to_string() << "|\n\n\n";
    return false;
  }

  if (
    !ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_stmt, kFromClause, false) ||
    !ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_stmt, kWhereClause, false)
  ) {
      // cerr << "Return false because FROM clause or WHERE clause is not found. \n\n\n";
      return false;
  }

  return true;

}

vector<IR*> SQL_NOREC::post_fix_transform_select_stmt(IR* cur_stmt, unsigned multi_run_id){
  vector<IR*> trans_IR_vec;

  cur_stmt->parent_ = NULL;

  /* Double check whether the stmt is norec compatible */
  if (!is_oracle_select_stmt(cur_stmt)) {
    return trans_IR_vec;
  }

  // cerr << "Debug: in SQL_NOREC::post_fix_transform_select_stmt(), getting: \n";
  // g_mutator->debug(cur_stmt);
  // cerr << "Is parent? " << cur_stmt->parent_ << "\n";
  // cerr << "End \n\n\n";

  IR* first_stmt = cur_stmt->deep_copy();

  // cerr << "Debug: in SQL_NOREC::post_fix_transform_select_stmt(), getting: \n";
  // g_mutator->debug(first_stmt);
  // cerr << "Is parent? " << first_stmt->parent_ << "\n";
  // cerr << "End \n\n\n";

  /* Remove the kWindowingClause, if exists.
   * These kWindowingClause are parented by kOptWindowingClause, and
   * can be removed without causing syntactic errors.
   * kWindowingClause inside kWindowFuncCall are excluded by is_oracle_select_stmt() already
   * Doesn't need to worry about double free, because all overclause that we remove
   * are not in subqueries.
   * */
  vector<IR* > v_over_clause = ir_wrapper.get_ir_node_in_stmt_with_type(first_stmt, kOptOverClause, false);

  if (v_over_clause.size() > 0) {
    IR* over_clause = v_over_clause.front();
    IR* new_over_clause = new IR(kOptOverClause, OP0());
    first_stmt->swap_node(over_clause, new_over_clause);
    over_clause->deep_drop();
  }

  trans_IR_vec.push_back(first_stmt); // Save the original version.

  // cerr << "DEBUG: Getting post_fix cur_stmt: " << cur_stmt->to_string() << " \n\n\n";

  // cerr << "DEBUG: Getting where_clause " <<  ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kWhereClause, false).size() << "\n\n\n";

  /* Take care of WHERE and FROM clauses. */
  // cerr << "Printing post_fix tree: ";
  // g_mutator->debug(cur_stmt, 0);
  // cerr << "\n\n\n\n\n\n\n";

  vector<IR*> transformed_temp_vec = run_parser(this->post_fix_temp);
  if (transformed_temp_vec.size() == 0 ) {
    cerr << "Error: parsing the post_fix_temp from SQL_NOREC::post_fix_transform_select_stmt returns empty IR vector. \n";
    first_stmt->deep_drop();
    trans_IR_vec.clear();
    return trans_IR_vec;
  }

  IR* transformed_temp_ir = transformed_temp_vec.back();
  IR* trans_stmt_ir = ir_wrapper.get_first_stmt_from_root(transformed_temp_ir)->deep_copy();
  trans_stmt_ir->parent_ = NULL;
  transformed_temp_ir->deep_drop();


  vector<IR*> src_order_vec = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kOptOrderClause, false);
  if (src_order_vec.size() > 0 ) {
    IR* src_order_clause = src_order_vec[0]->deep_copy();
    IR* dest_order_clause = ir_wrapper.get_ir_node_in_stmt_with_type(trans_stmt_ir, kOptOrderClause, true)[0];
    if (!trans_stmt_ir->swap_node(dest_order_clause, src_order_clause)){
      trans_stmt_ir->deep_drop();
      src_order_clause->deep_drop();
      cerr << "Error: swap_node failed for sort_clause. In function SQL_NOREC::post_fix_transform_select_stmt. \n";
      vector<IR*> tmp; return tmp;
    }
    dest_order_clause->deep_drop();
  } else {
    IR* dest_order_clause = ir_wrapper.get_ir_node_in_stmt_with_type(trans_stmt_ir, kOptOrderClause, true)[0];
    trans_stmt_ir->detatch_node(dest_order_clause);
    dest_order_clause->deep_drop();
  }

  IR* src_where_expr = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kWhereClause, false)[0]->get_left()->deep_copy();
  IR* dest_where_expr = ir_wrapper.get_ir_node_in_stmt_with_type(trans_stmt_ir, kExpr, true)[0];


  IR* src_from_expr = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kFromClause, false)[0]->deep_copy();
  IR* dest_from_expr = ir_wrapper.get_ir_node_in_stmt_with_type(trans_stmt_ir, kFromClause, true)[0];

  // cerr << "DEBUG: getting dest_where_expr: " << dest_where_expr->to_string() << "\n from stmt" << trans_stmt_ir->to_string() << "\n\n";

  if (!trans_stmt_ir->swap_node(dest_where_expr, src_where_expr)){
    trans_stmt_ir->deep_drop();
    src_where_expr->deep_drop();
    src_from_expr->deep_drop();
    // cerr << "Error: swap_node failed for where_clause. In function SQL_NOREC::post_fix_transform_select_stmt. \n";
    vector<IR*> tmp; return tmp;
  }
  dest_where_expr->deep_drop();
  if (!trans_stmt_ir->swap_node(dest_from_expr, src_from_expr)) {
    trans_stmt_ir->deep_drop();
    src_from_expr->deep_drop();
    // cerr << "Error: swap_node failed for from_clause. In function SQL_NOREC::post_fix_transform_select_stmt. \n";
    vector<IR*> tmp; return tmp;
  }
  dest_from_expr->deep_drop();

  trans_IR_vec.push_back(trans_stmt_ir);

  return trans_IR_vec;

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
