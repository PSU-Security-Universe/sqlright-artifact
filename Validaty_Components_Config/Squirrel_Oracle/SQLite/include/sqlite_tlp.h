#ifndef __SQLITE_TLP_H__
#define __SQLITE_TLP_H__

#include "../include/ast.h"
#include "../include/define.h"
#include "../include/utils.h"
#include "./sqlite_oracle.h"

#include <string>
#include <vector>

using namespace std;

enum class VALID_STMT_TYPE_TLP { 
  AGGR_MIN,  
  AGGR_MAX,
  AGGR_COUNT,
  AGGR_SUM,
  AGGR_AVG,
  DISTINCT,
  GROUP_BY,
  HAVING,
  NORMAL,
  TLP_UNKNOWN,
  // For results
  // UNIQ,
  // NORM
};

class SQL_TLP : public SQL_ORACLE {
public:
  int count_valid_stmts(const string &input) override;
  bool is_oracle_valid_stmt(const string &query) override;
  bool mark_all_valid_node(vector<IR *> &v_ir_collector) override;
  string remove_valid_stmts_from_str(string query) override;
  void compare_results(ALL_COMP_RES &res_out) override;
  void rewrite_valid_stmt_from_ori(string &ori, string &rew_1, string &rew_2,
                                   string &rew_3,
                                   unsigned multi_run_id) override;

  string get_temp_valid_stmts() override {
    return temp_valid_stmts[get_rand_int(temp_valid_stmts.size())];
  }
  string get_oracle_type() override { return this->oracle_type; }

private:
  vector<string> temp_valid_stmts = {
      /* Complete set */
      // "SELECT x FROM x;",
      "SELECT * FROM v0 WHERE v1;",
      "SELECT x FROM x WHERE x GROUP BY x;",
      // "SELECT x FROM x WHERE x HAVING x;", // TODO:: Implement HAVING.
      "SELECT DISTINCT x FROM x WHERE x;",
      "SELECT MIN(x) FROM x WHERE x;", 
      "SELECT MAX(x) FROM x WHERE x;",
      "SELECT SUM(x) FROM x WHERE x;", 
      // "SELECT COUNT(x) FROM x WHERE x;"
      "SELECT AVG(x) FROM x WHERE x;"
  };

  void rewrite_where(string &ori, string &rew_1, const string &bef_sel_stmt,
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &group_by_stmt,
                     const string &order_by_stmt, const bool is_union_all);

  void rewrite_avg(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &order_by_stmt,
                     const bool is_union_all);
  // void rewrite_count(string &ori, string &rew_1,
  //                    const string &sel_stmt, const string &from_stmt,
  //                    const string &where_stmt, const string &order_by_stmt,
  //                    const bool is_union_all);
  void rewrite_min(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &order_by_stmt,
                     const bool is_union_all);
  void rewrite_max(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &order_by_stmt,
                     const bool is_union_all);
  void rewrite_sum(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &order_by_stmt,
                     const bool is_union_all);

  void rewrite_distinct(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, 
                     const string &order_by_stmt);
  void rewrite_groupby(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, 
                     const string &group_by_stmt,
                     const string &order_by_stmt);

  // TODO: Implement HAVING stmts.
  string rewrite_having(string &ori, string &rew_1,
                        const string &before_select_stmt,
                        const string &select_stmt, const string &from_stmt,
                        const string &where_stmt, const string &extra_stmt);
  

  void get_v_valid_type(const string &cmd_str,
                        vector<VALID_STMT_TYPE_TLP> &v_valid_type);

  /* Compare helper function */
  bool compare_norm(COMP_RES &res); /* Handle normal valid stmt: SELECT * FROM
                                       ...; Return is_err */
  bool compare_uniq(COMP_RES &res); /* Handle results that is unique. Count row numbers, but results from the first stmt need to be unique. */
  bool compare_aggr(COMP_RES &res); /* Handle MIN valid stmt: SELECT MIN(*) FROM ...; */
  bool compare_sum_count_minmax(
      COMP_RES &res,
      VALID_STMT_TYPE_TLP
          valid_type); /* Handle MIN valid stmt: SELECT MIN(*) FROM ...; */

  /* If string contains 'GROUP BY' statement,
   * then set final result to ALL_Error and skip it.
   */
  bool is_str_contains_group(const string &input_str);

  /* If string contains aggregate function,
   * then set final result to ALL_Error and skip it.
   */
  bool is_str_contains_aggregate(const string &input_str);

  string oracle_type = "TLP";

  string trans_outer_MIN_tmp_str = "SELECT MIN(aggr) FROM (v0);";
  string trans_outer_MAX_tmp_str = "SELECT MAX(aggr) FROM (v0);";
  string trans_outer_SUM_tmp_str = "SELECT SUM(aggr) FROM (v0);";
  string trans_outer_COUNT_tmp_str = "SELECT COUNT(aggr) FROM (v0);";
  string trans_outer_AVG_tmp_str = "SELECT SUM(s)/SUM(c) FROM (v0);";
};

#endif