#ifndef __SQLITE_ORACLE_H__
#define __SQLITE_ORACLE_H__

#include "../include/ast.h"
#include "../include/define.h"
#include "../include/mutator.h"
#include "../include/utils.h"

#include <string>
#include <vector>

using namespace std;

class Mutator;

class SQL_ORACLE {
public:
  /* Functions to check and count how many query validation statements are in
   * the string. */
  virtual int count_valid_stmts(const string &input) = 0;
  virtual bool is_oracle_valid_stmt(const string &query) = 0;

  /* Used to detect non-select query that needs some rewrite. */
  virtual bool is_oracle_valid_stmt_2(const string &query) { return false; }

  /* Randomly add some statements into the query sets. Will append to the query
   * in a pretty early stage. Can be used to append some non-select verification
   * statements into the query set, and rewrite using
   * rewrite_valid_stmt_from_ori_2() later.
   */
  virtual string get_random_append_stmts() { return ""; }

  /* Mark all the IR node in the IR tree, that is related to teh validation
   * statement, that you do not want to mutate. */
  virtual bool mark_all_valid_node(vector<IR *> &v_ir_collector) = 0;

  virtual string remove_valid_stmts_from_str(string query) = 0;

  /* Given the validation SELECT statement ori, rewrite the ori to validation
   * statement to rewrite_1 and rewrite_2. */
  virtual void rewrite_valid_stmt_from_ori(string &ori, string &rew_1,
                                           string &rew_2, string &rew_3,
                                           unsigned multi_run_id) = 0;
  virtual void rewrite_valid_stmt_from_ori(string &ori, string &rew_1,
                                           string &rew_2, string &rew_3) {
    this->rewrite_valid_stmt_from_ori(ori, rew_1, rew_2, rew_3, 0);
  }

  /* Given the validation NON-SELECT statement ori, rewrite the ori to
   * validation statement to rewrite_1 and rewrite_2. */
  virtual void rewrite_valid_stmt_from_ori_2(string &query,
                                             const unsigned multi_run_id) {
    return;
  }
  virtual void rewrite_valid_stmt_from_ori_2(string &query) {
    this->rewrite_valid_stmt_from_ori_2(query, 0);
  }

  /* Compare the results from validation statements ori, rewrite_1 and
     rewrite_2.
      If the results are all errors, return -1, all consistent, return 1, found
     inconsistent, return 0. */
  virtual void compare_results(ALL_COMP_RES &res_out) = 0;

  virtual string get_random_mutated_valid_stmt();

  /* Helper function. */
  void set_mutator(Mutator *mutator);

  virtual string get_temp_valid_stmts() = 0;

  virtual unsigned get_mul_run_num() { return 1; }

  virtual string get_oracle_type() = 0;

  /* Debug */
  unsigned long total_rand_valid = 0;
  unsigned long total_temp = 0;

protected:
  Mutator *g_mutator;

  virtual bool mark_node_valid(IR *root);
};

#endif