#ifndef __SQLITE_ROWID_H__
#define __SQLITE_ROWID_H__

#include "../include/ast.h"
#include "../include/define.h"
#include "../include/utils.h"
#include "./sqlite_oracle.h"

#include <string>
#include <vector>

using namespace std;

enum class VALID_STMT_TYPE_ROWID { NORM, UNIQ };

class SQL_ROWID : public SQL_ORACLE {
public:
  int count_valid_stmts(const string &input) override;
  bool is_oracle_valid_stmt(const string &query) override;
  bool is_oracle_valid_stmt_2(const string &query) override;
  bool mark_all_valid_node(vector<IR *> &v_ir_collector) override;
  string remove_valid_stmts_from_str(string query) override;
  void compare_results(ALL_COMP_RES &res_out) override;
  void rewrite_valid_stmt_from_ori(string &ori, string &rew_1, string &rew_2,
                                   string &rew_3,
                                   unsigned multi_run_id) override;
  void rewrite_valid_stmt_from_ori_2(string &query,
                                     const unsigned multi_run_id) override;

  string get_temp_valid_stmts() override { return temp_valid_stmts; }

  bool is_oracle_normal_stmt(IR* cur_IR) override;
  IR* pre_fix_transform_normal_stmt(IR* cur_stmt) override;
  vector<IR*> post_fix_transform_normal_stmt(IR* cur_stmt, unsigned multi_run_id) override;

  /* Execute SQLite3 two times. Add or remove WITHOUT ROWID. Compare the
   * results. */
  unsigned get_mul_run_num() override { return 2; }
  string get_oracle_type() override { return this->oracle_type; }

private:
  string temp_valid_stmts = "SELECT * FROM x WHERE x;";

  void get_v_valid_type(const string &cmd_str,
                        vector<VALID_STMT_TYPE_ROWID> &v_valid_type);

  bool compare_norm(COMP_RES &res); /* Handle normal valid stmt: SELECT * FROM
                                       ...; Return is_err */
  bool compare_uniq(COMP_RES &res);

  /* If string empty or contains error keyword,
   * then set final result to ALL_Error and skip it.
   */
  bool is_str_error(const string &input_str);

  string oracle_type = "ROWID";
};

#endif