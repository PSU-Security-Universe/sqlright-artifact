#include "../include/sqlite_index.h"
#include "../include/mutator.h"
#include <iostream>

#include <regex>
#include <string>

int SQL_INDEX::count_valid_stmts(const string &input) {
  int norec_select_count = 0;
  vector<string> queries_vector = string_splitter(input, ";");
  for (string &query : queries_vector)
    if (this->is_oracle_valid_stmt(query) ||
        this->is_oracle_valid_stmt_2(query))
      norec_select_count++;
  return norec_select_count;
}

bool SQL_INDEX::is_oracle_valid_stmt(const string &query) {
  if (((findStringIter(query, "SELECT") - query.begin()) < 5) &&
      findStringIn(query, "FROM"))
    return true;
  return false;
}

bool SQL_INDEX::is_oracle_valid_stmt_2(const string &query) {
  if (((findStringIter(query, "CREATE INDEX") - query.begin()) < 5) ||
      ((findStringIter(query, "CREATE UNIQUE INDEX") - query.begin()) < 5))
    return true;
  return false;
}

/* TODO:: Should we change this function in the not NOREC oracle? */
bool SQL_INDEX::mark_all_valid_node(vector<IR *> &v_ir_collector) {
  return true;
}

/* Select statements untouched. */
void SQL_INDEX::rewrite_valid_stmt_from_ori(string &query, string &rew_1,
                                            string &rew_2, string &rew_3,
                                            unsigned multi_run_id) {
  rew_1 = "";
  rew_2 = "";
  rew_3 = "";
  return;
}

/* If we found CREATE INDEX stmt, delete it. */
void SQL_INDEX::rewrite_valid_stmt_from_ori_2(string &query,
                                              unsigned multi_run_id) {
  /* If the query contains CREATE UNIQUE INDEX, delete no matter what. */
  if (((findStringIter(query, "CREATE UNIQUE INDEX") - query.begin()) < 5)) {
    query = "";
    return;
  }
  if (multi_run_id < 1)
    return; // First run, do not modify anything.
  query = "";
  return;
}

string SQL_INDEX::remove_valid_stmts_from_str(string query) {
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

void SQL_INDEX::get_v_valid_type(const string &cmd_str,
                                 vector<VALID_STMT_TYPE_INDEX> &v_valid_type) {
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
        v_valid_type.push_back(VALID_STMT_TYPE_INDEX::UNIQ);
        // cerr << "query: " << cur_cmd_str << " \nMIN. \n";
      } else {
        v_valid_type.push_back(VALID_STMT_TYPE_INDEX::NORM);
        // cerr << "query: " << cur_cmd_str << " \nNORM. \n";
      }
    } else {
      break; // For the current begin_idx, we cannot find the end_idx. Ignore
             // the current output.
    }
  }
  return;
}

void SQL_INDEX::compare_results(ALL_COMP_RES &res_out) {
  if ((res_out.v_cmd_str.size() < 1) || (res_out.v_res_str.size() < 1)) {
    cerr << "Error: Getting empty v_cmd_str or v_res_str from the res_out. "
            "Possibly processing only the seed files. \n";
    res_out.final_res = ALL_Error;
    return;
  }

  res_out.final_res = Pass;

  vector<VALID_STMT_TYPE_INDEX> v_valid_type;
  get_v_valid_type(res_out.v_cmd_str[0], v_valid_type);

  bool is_all_errors = true;
  int i = 0;
  for (COMP_RES &res : res_out.v_res) {
    switch (v_valid_type[i++]) {
    case VALID_STMT_TYPE_INDEX::NORM:
      if (!this->compare_norm(res))
        is_all_errors = false;
      break;

    case VALID_STMT_TYPE_INDEX::UNIQ:
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

bool SQL_INDEX::compare_norm(
    COMP_RES
        &res) { /* Handle normal valid stmt: SELECT * FROM ...; Return is_err */
  if (res.v_res_str.size() <= 1) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }
  vector<string> &v_res_str = res.v_res_str;
  vector<int> &v_res_int = res.v_res_int;

  for (const string &res_str : v_res_str) {
    if (res_str.find("Error") != string::npos) {
      res.comp_res = ORA_COMP_RES::Error;
      return true;
    }
    int cur_res_int = 0;
    vector<string> v_res_split = string_splitter(res_str, "\n");
    /* Remove NULL results */
    for (const string &r : v_res_split) {
      if (is_str_empty(r))
        --cur_res_int;
    }
    v_res_split.clear();

    cur_res_int += std::count(res_str.begin(), res_str.end(), '\n');
    v_res_int.push_back(cur_res_int);
  }

  for (int i = 1; i < v_res_int.size(); i++) {
    if (v_res_int[0] != v_res_int[i]) {
      res.comp_res = ORA_COMP_RES::Fail;
      return false;
    }
  }

  res.comp_res = ORA_COMP_RES::Pass;
  return false;
}

bool SQL_INDEX::compare_uniq(COMP_RES &res) {
  if (res.v_res_str.size() <= 1) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }
  vector<string> &v_res_str = res.v_res_str;
  // vector<int>& v_res_int = res.v_res_int;

  // for (const string& res_str : v_res_str) {
  //     if (res_str.find("Error") != string::npos){
  //         res.comp_res = ORA_COMP_RES::Error;
  //         return true;
  //     }

  //     int cur_res_int = 0;
  //     try {
  //         cur_res_int = stoi(res_str);
  //     }
  //     catch (std::invalid_argument &e) {
  //         continue;
  //     }
  //     catch (std::out_of_range &e) {
  //         res.comp_res = ORA_COMP_RES::Error;
  //         return true;
  //     }

  //     v_res_int.push_back(cur_res_int);
  // }
  for (int i = 0; i < v_res_str.size(); i++) {
    if (v_res_str[i].find("Error") != string::npos) {
      res.comp_res = ORA_COMP_RES::Error;
      return true;
    }
    if (v_res_str[0] != v_res_str[i]) {
      res.comp_res = ORA_COMP_RES::Fail;
      return false;
    }
  }

  res.comp_res = ORA_COMP_RES::Pass;
  return false;
}