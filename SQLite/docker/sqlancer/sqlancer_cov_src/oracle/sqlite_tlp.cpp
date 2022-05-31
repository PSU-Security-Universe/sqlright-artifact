#include "./sqlite_tlp.h"
#include "../include/mutator.h"
#include <iostream>

#include <algorithm>
#include <regex>
#include <string>

int SQL_TLP::count_valid_stmts(const string &input) {
  int norec_select_count = 0;
  vector<string> queries_vector = string_splitter(input, ";");
  for (string &query : queries_vector)
    if (this->is_oracle_valid_stmt(query))
      norec_select_count++;
  return norec_select_count;
}

bool SQL_TLP::is_oracle_valid_stmt(const string &query) {

  if ((((findStringIter(query, "SELECT") - query.begin()) < 5)) &&
      findStringIn(query, "FROM") && findStringIn(query, "WHERE") &&
      !findStringIn(query, "INSERT") && !findStringIn(query, "UPDATE"))
    return true;

  return false;
}

bool SQL_TLP::mark_all_valid_node(vector<IR *> &v_ir_collector) {
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

void SQL_TLP::rewrite_valid_stmt_from_ori(string &query, string &rew_1,
                                          string &rew_2, string &rew_3,
                                          unsigned multi_run_id) {
  // vector<string> stmt_vector = string_splitter(query,
  // "where|WHERE|SELECT|select|FROM|from");

  string ori_query = query;

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

  size_t order_by_len = 0, group_by_len = 0;
  if (group_by_position != string::npos && order_by_position != string::npos) {
    if (group_by_position < order_by_position) {
      group_by_len = order_by_position - group_by_position;
      order_by_len = ori_query.size() - order_by_position;
    } else {
      order_by_len = group_by_position - order_by_position;
      group_by_len = ori_query.size() - group_by_position;
    }
  } else if (group_by_position != string::npos) {
    group_by_len = ori_query.size() - group_by_position;
  } else if (order_by_position != string::npos) {
    order_by_len = ori_query.size() - order_by_position;
  }

  size_t extra_stmt_position =
      min((size_t)(group_by_position), (size_t)(order_by_position));
  // size_t extra_stmt_position = -1;
  // if (group_by_position != string::npos && order_by_position != string::npos)
  //   extra_stmt_position = ((group_by_position < order_by_position) ?
  //   group_by_position : order_by_position);
  // else if (group_by_position != string::npos)
  //   extra_stmt_position = group_by_position;
  // else if (order_by_position != string::npos)
  //   extra_stmt_position = order_by_position;

  string before_select_stmt;
  string select_stmt;
  string from_stmt;
  string where_stmt;
  // string extra_stmt;
  string order_by_stmt;

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

  if (order_by_position == string::npos)
    order_by_stmt = "";
  else
    order_by_stmt = query.substr(order_by_position, order_by_len);

  /* Muted GROUP BY */
  // if (group_by_position == string::npos)
  //   group_by_stmt = "";
  // else
  //   group_by_stmt = query.substr(group_by_position, group_by_len);

  // if (extra_stmt_position == -1)
  //   extra_stmt = "";
  // else
  //   extra_stmt = query.substr(extra_stmt_position, query.size() -
  //   extra_stmt_position);

  if (!findStringIn(
          ori_query,
          "HAVING")) { // This is not a having stmts. Handle with where stmt.
    if (
        /* Do not use UNION ALL, if we have SELECT DISTINCT. */
        !((findStringIter(ori_query, "SELECT DISTINCT") - ori_query.begin()) < 5)
      ) {

      rewrite_where(query, rew_1, before_select_stmt, select_stmt, from_stmt,
                    where_stmt, "", order_by_stmt, true);

    } else {

      rewrite_where(query, rew_1, before_select_stmt, select_stmt, from_stmt,
                    where_stmt, "", order_by_stmt, false);
    }

    // if (group_by_stmt != "")
    //   cerr << "GROUP BY stmt is: " << group_by_stmt << endl;
    // if (order_by_stmt != "")
    //   cerr << "ORDER BY stmt is: " << order_by_stmt << endl;

  } else {
    // TODO:: Handling HAVING stmt.
    query = "";
    rew_1 = "";
  }

  /* For now, do not process the stmt with the following contents. . */
  if (((findStringIter(ori_query, "SELECT DISTINCT AVG") - ori_query.begin()) <
       5) ||
      ((findStringIter(ori_query, "SELECT AVG") - ori_query.begin()) < 5) ||
      findStringIn(ori_query, "UNION") || findStringIn(ori_query, "EXCEPT") ||
      findStringIn(ori_query, "OVER") || findStringIn(ori_query, "INTERSECT")) {
    query = "";
    rew_1 = "";
  }

  rew_2 = "";
  rew_3 = "";
}

void SQL_TLP::rewrite_where(string &ori, string &rew_1,
                            const string &bef_sel_stmt, const string &sel_stmt,
                            const string &from_stmt, const string &where_stmt,
                            const string &group_by_stmt,
                            const string &order_by_stmt,
                            const bool is_union_all) {
  /* Taking care of TLP select stmt: SELECT x FROM x [joins] */
  if (where_stmt == "") {
    rew_1 = bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
            " WHERE TRUE " + group_by_stmt;
    if (is_union_all)
      rew_1 += " UNION ALL ";
    else
      rew_1 += " UNION ";
    rew_1 += bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
             " WHERE NOT TRUE " + group_by_stmt;
    if (is_union_all)
      rew_1 += " UNION ALL ";
    else
      rew_1 += " UNION ";
    rew_1 += bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
             " WHERE TRUE IS NULL " + group_by_stmt + " " + order_by_stmt;

  } else {

    rew_1 = bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
            " WHERE (" + where_stmt + ") " + group_by_stmt;
    if (is_union_all)
      rew_1 += " UNION ALL ";
    else
      rew_1 += " UNION ";
    rew_1 += bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
             " WHERE NOT (" + where_stmt + ") " + group_by_stmt;
    if (is_union_all)
      rew_1 += " UNION ALL ";
    else
      rew_1 += " UNION ";
    rew_1 += bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
             " WHERE (" + where_stmt + ") IS NULL " + group_by_stmt + " " +
             order_by_stmt;

    ori = bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt + " " +
          group_by_stmt + " " + order_by_stmt;
  }
}

string SQL_TLP::rewrite_having(string &ori, string &rew_1,
                               const string &before_select_stmt,
                               const string &select_stmt,
                               const string &from_stmt,
                               const string &where_stmt,
                               const string &extra_stmt) {
  // TODO:: Implement having stmts.
  return "";
}

string SQL_TLP::remove_valid_stmts_from_str(string query) {
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

bool SQL_TLP::compare_norm(COMP_RES &res) {

  string &res_a = res.res_str_0;
  string &res_b = res.res_str_1;
  int &res_a_int = res.res_int_0;
  int &res_b_int = res.res_int_1;

  if (res_a.find("Error") != string::npos ||
      res_b.find("Error") != string::npos) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  res_a_int = 0;
  res_b_int = 0;

  vector<string> v_res_a = string_splitter(res_a, "\n");
  vector<string> v_res_b = string_splitter(res_b, "\n");

  /* Remove NULL results */
  for (string &r : v_res_a) {
    if (is_str_empty(r))
      res_a_int--;
  }

  for (string &r : v_res_b) {
    if (is_str_empty(r))
      res_b_int--;
  }

  v_res_a.clear();
  v_res_b.clear();

  res_a_int += std::count(res_a.begin(), res_a.end(), '\n');
  res_b_int += std::count(res_b.begin(), res_b.end(), '\n');

  if (res_a_int != res_b_int) { // Found inconsistent.
    // cerr << "NORMAL Found mismatched: " << "res_a: " << res_a << "res_b: " <<
    // res_b << " res_a_int: " << res_a_int << "res_b_int: " << res_b_int <<
    // endl;
    res.comp_res = ORA_COMP_RES::Fail;
    return false;
  }
  res.comp_res = ORA_COMP_RES::Pass;
  return false;
}

/* Handle MIN valid stmt: SELECT MIN(*) FROM ...; and MAX valid stmt: SELECT
 * MAX(*) FROM ...;  */
bool SQL_TLP::compare_sum_count_minmax(COMP_RES &res,
                                       VALID_STMT_TYPE_TLP valid_type) {

  res.comp_res = ORA_COMP_RES::IGNORE;
  return true;
}

void SQL_TLP::compare_results(ALL_COMP_RES &res_out) {

  res_out.final_res = ORA_COMP_RES::Pass;
  bool is_all_err = true;

  vector<VALID_STMT_TYPE_TLP> v_valid_type;
  get_v_valid_type(res_out.cmd_str, v_valid_type);

  int i = 0;
  for (COMP_RES &res : res_out.v_res) {

    switch (v_valid_type[i++]) {
    case VALID_STMT_TYPE_TLP::NORM:
      /* Handle normal valid stmt: SELECT * FROM ...; */
      if (!compare_norm(res))
        is_all_err = false;
      break; // Break the switch

    case VALID_STMT_TYPE_TLP::UNIQ:
      /* Handle MIN valid stmt: SELECT MIN(*) FROM ...; */
      if (!compare_sum_count_minmax(res, VALID_STMT_TYPE_TLP::UNIQ))
        is_all_err = false;
      break; // Break the switch

    default:
      cerr << "SQL_TLP::compare_results Error: Unknown VALID_STMT_TYPE_TLP. \n";
      break;
    } // Switch stmt.
    if (res.comp_res == ORA_COMP_RES::Fail)
      res_out.final_res = ORA_COMP_RES::Fail;
  } // Result outer loop.

  if (is_all_err && res_out.final_res != ORA_COMP_RES::Fail)
    res_out.final_res = ORA_COMP_RES::ALL_Error;

  return;
}

void SQL_TLP::get_v_valid_type(const string &cmd_str,
                               vector<VALID_STMT_TYPE_TLP> &v_valid_type) {
  /* Look throught first validation stmt's result_1 first */
  size_t begin_idx = cmd_str.find("SELECT 'BEGIN VERI 0';", 0);
  size_t end_idx = cmd_str.find("SELECT 'END VERI 0';", 0);

  while (begin_idx != string::npos) {
    if (end_idx != string::npos) {
      string cur_cmd_str =
          cmd_str.substr(begin_idx + 23, (end_idx - begin_idx - 23));
      begin_idx = cmd_str.find("SELECT 'BEGIN VERI 0';", begin_idx + 23);
      end_idx = cmd_str.find("SELECT 'END VERI 0';", end_idx + 21);

      if (findStringIn(cur_cmd_str, "MIN") ||
          findStringIn(cur_cmd_str, "MAX") ||
          findStringIn(cur_cmd_str, "SUM") ||
          findStringIn(cur_cmd_str, "COUNT") ||
          findStringIn(cur_cmd_str, "GROUP BY") ||
          findStringIn(cur_cmd_str, "AVG")) {
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::UNIQ);
      } else {
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::NORM);
        // cerr << "query: " << cur_cmd_str << " \nNORM. \n";
      }

    } else {
      break; // For the current begin_idx, we cannot find the end_idx. Ignore
             // the current output.
    }
  }
}

bool SQL_TLP::is_str_contains_group(const string &input_str) {
  // check whether if 'input_str' contains 'GROUP BY' keyword.
  if ((input_str.find("GROUP BY") != string::npos) ||
      (input_str.find("GROUP") != string::npos)) {
    return true;
  }

  return false;
}

bool SQL_TLP::is_str_contains_aggregate(const string &input_str) {
  // check whether if 'input_str' contains aggregate function.
  if ((input_str.find("MIN") != string::npos) ||
      (input_str.find("MAX") != string::npos) ||
      (input_str.find("SUM") != string::npos) ||
      (input_str.find("COUNT") != string::npos)) {
    return true;
  }

  return false;
}