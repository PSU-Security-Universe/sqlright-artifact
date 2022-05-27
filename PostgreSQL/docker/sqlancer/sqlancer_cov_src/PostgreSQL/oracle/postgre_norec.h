#ifndef __POSTGRE_NOREC_H__
#define __POSTGRE_NOREC_H__

#include "../include/ast.h"
#include "../include/define.h"
#include "./postgre_oracle.h"

#include <string>
#include <vector>

using namespace std;

class SQL_NOREC : public SQL_ORACLE {
public:
  int count_valid_stmts(const string &input) override;
  bool is_oracle_valid_stmt(const string &query) override;
  bool mark_all_valid_node(vector<IR *> &v_ir_collector) override;
  string remove_valid_stmts_from_str(string query) override;
  void compare_results(ALL_COMP_RES &res_out) override;
  void rewrite_valid_stmt_from_ori(string &ori, string &rew_1, string &rew_2,
                                   string &rew_3,
                                   unsigned multi_run_id) override;

  bool is_oracle_select_stmt(IR* cur_IR) override;

  vector<IR*> post_fix_transform_select_stmt(IR* cur_stmt, unsigned multi_run_id) override;

  string get_temp_valid_stmts() override { return temp_valid_stmts; };

  string get_oracle_type() override { return this->oracle_type; }

private:

//   string temp_valid_stmts = "SELECT COUNT ( * ) FROM x WHERE x;";
// Postgres need to generate 
  string temp_valid_stmts = "SELECT COUNT ( * ) FROM x WHERE x;";

  string oracle_type = "NOREC";
  string post_fix_temp = "SELECT COALESCE( SUM(countt), 0) FROM ( SELECT ALL( true ) :: INT as countt FROM v2 ORDER BY ( v1 ) ) as ress;" ;
  // string post_fix_temp = "SELECT SUM(countt) FROM ( SELECT ALL( true ) :: INT as countt FROM v2 ORDER BY ( v1 ) ) as ress;" ;
};

#endif