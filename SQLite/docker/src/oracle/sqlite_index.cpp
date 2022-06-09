#include "./sqlite_index.h"
#include "../include/mutator.h"
#include <iostream>

#include <regex>
#include <string>

int SQL_INDEX::count_valid_stmts(const string &input) {
  int norec_select_count = 0;
  vector<string> queries_vector = string_splitter(input, ';');
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
  vector<string> queries_vector = string_splitter(query, ';');

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
    cerr << "Error: Getting empty v_cmd_str or v_res_str from the res_out. Actual size for v_res_str is: " \
         << to_string(res_out.v_res_str.size()) << \
            ". Possibly processing only the seed files. \n";
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
    vector<string> v_res_split = string_splitter(res_str, '\n');
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

bool SQL_INDEX::is_oracle_normal_stmt(IR* cur_IR) {
  if (ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_IR, kCreateIndexStatement, false)) {
    return true;
  }
  return false;
}

IR* SQL_INDEX::pre_fix_transform_normal_stmt(IR* cur_stmt) {
  if (!this->is_oracle_normal_stmt(cur_stmt)){
    cerr << "Error: Pre_fix_transform_normal_stmt not receiving kCreateIndexStatement. Func: SQL_INDEX::pre_fix_transform_normal_stmt(IR* cur_stmt). \n";
    return nullptr;
  }
  cur_stmt = cur_stmt->deep_copy();
  vector<IR*> opt_unique_vec = ir_wrapper.get_ir_node_in_stmt_with_type(cur_stmt, kOptUnique, false);
  if (opt_unique_vec.size() != 0) {
    for (auto opt_unique_ir : opt_unique_vec) {
      opt_unique_ir->str_val_ = ""; // Remove UNIQUE constraints in the deep_copied cur_stmt. 
    }
    return cur_stmt;
  }
  cur_stmt->deep_drop();
  return nullptr;
}

vector<IR*> SQL_INDEX::post_fix_transform_normal_stmt(IR* cur_stmt, unsigned multi_run_id){
  if (multi_run_id == 0) {
    vector<IR*> tmp; return tmp;
  }
  // multi_run_id == 1: return an empty statement. 
  IR* new_empty_stmt = new IR(kStatement, "");
  vector<IR*> output_stmt_vec;
  output_stmt_vec.push_back(new_empty_stmt);
  return output_stmt_vec;
}

IR* SQL_INDEX::get_random_append_stmts_ir() {
  string temp_append_str = this->temp_append_stmts[get_rand_int(this->temp_append_stmts.size())];
  vector<IR*> app_ir_set = g_mutator->parse_query_str_get_ir_set(temp_append_str);
  if (app_ir_set.size() == 0) { 
    cerr << "FATAL ERROR: SQL_INDEX::get_random_append_stmts_ir() parse string failed. \n"; 
    return nullptr;
  }
  IR* cur_root = app_ir_set.back();
  vector<IR*> stmt_list_vec = ir_wrapper.get_stmt_ir_vec(cur_root);
  if (stmt_list_vec.size() == 0) {
    cerr << "FATAL ERROR: SQL_INDEX::get_random_append_stmts_ir() getting stmt failed. \n"; 
    cur_root->deep_drop();
    return nullptr;
  }
  IR* first_stmt = stmt_list_vec[0]->deep_copy();
  cur_root->deep_drop();
  return first_stmt;
}