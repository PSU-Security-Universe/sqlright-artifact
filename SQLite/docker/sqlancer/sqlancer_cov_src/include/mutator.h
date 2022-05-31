#ifndef __MUTATOR_H__
#define __MUTATOR_H__

#include "ast.h"
#include "define.h"
#include "utils.h"

#include <vector>

#define LUCKY_NUMBER 500

using namespace std;

class SQL_ORACLE;

class Mutator {

public:
  Mutator() { srand(time(nullptr)); }

  typedef map<IR *, pair<int, IR *>> TmpRecord;

  void set_dump_library(bool);

  IR *deep_copy_with_record(const IR *root, const IR *record);
  unsigned long hash(IR *);
  unsigned long hash(string);

  vector<string *> mutate_all(vector<IR *> &v_ir_collector);

  vector<IR *> mutate(IR *input);
  IR *strategy_delete(IR *cur);
  IR *strategy_insert(IR *cur);
  IR *strategy_replace(IR *cur);

  string validate(string query);
  string validate(IR *root);

  void minimize(vector<IR *> &);
  bool lucky_enough_to_be_mutated(unsigned int mutated_times);

  int get_ir_libary_2D_hash_kStatement_size();
  int get_valid_collection_size();
  int get_cri_valid_collection_size();

  vector<IR *> parse_query_str_get_ir_set(string &query_str);

  void add_all_to_library(IR *, const vector<int> &);
  void add_all_to_library(IR *ir) {
    vector<int> dummy_vec;
    add_all_to_library(ir, dummy_vec);
  }
  void add_all_to_library(string, const vector<int> &);
  void add_all_to_library(string whole_query_str) {
    vector<int> dummy_vec;
    add_all_to_library(whole_query_str, dummy_vec);
  }
  IR *get_from_libary_with_type(IRTYPE);
  IR *get_from_libary_with_left_type(IRTYPE);
  IR *get_from_libary_with_right_type(IRTYPE);

  bool get_valid_str_from_lib(string &);

  bool is_stripped_str_in_lib(string stripped_str);

  void init(string f_testcase, string f_common_string = "", string pragma = "");
  string fix(IR *root);
  void _fix(IR *root, string &);
  string extract_struct(IR *root);
  void _extract_struct(IR *root, string &);
  string extract_struct(string);
  void add_new_table(IR *root, string &table_name);
  void reset_database();

  bool check_node_num(IR *root, unsigned int limit);
  vector<IR *> extract_statement(IR *root);
  unsigned int calc_node(IR *root);

  map<IR *, set<IR *>> build_dependency_graph(IR *root,
                                              map<IDTYPE, IDTYPE> &relationmap,
                                              map<IDTYPE, IDTYPE> &crssmap,
                                              vector<IR *> &ordered_ir);
  vector<IR *> cut_subquery(IR *program, TmpRecord &m_save);
  bool add_back(TmpRecord &m_save);
  void fix_one(map<IR *, set<IR *>> &graph, IR *fixed_key, set<IR *> &visited);
  void fix_graph(map<IR *, set<IR *>> &graph, IR *root,
                 vector<IR *> &ordered_ir);

  static vector<string> value_libary;
  static map<string, vector<string>> m_tables;
  static map<string, vector<string>> m_table2index;
  static map<string, vector<string>> m_table2alias;
  static vector<string> v_table_names;
  ~Mutator();

  void debug(IR *root, unsigned level);
  unsigned long get_library_size();
  void get_memory_usage();
  int try_fix(char *buf, int len, char *&new_buf, int &new_len);

  void set_p_oracle(SQL_ORACLE *oracle) { this->p_oracle = oracle; }

  void set_use_cri_val(const bool is_use) { this->use_cri_val = is_use; }
  bool get_is_use_cri_val() { return this->use_cri_val; }

  void set_disable_coverage_feedback(const bool f) {
    this->disable_coverage_feedback = f;
  }

private:
  void add_to_valid_lib(IR *, string &, const bool);
  void add_to_library(IR *, string &);
  void add_to_library_core(IR *, string *);

  bool dump_library = false;
  bool use_cri_val = false;
  bool disable_coverage_feedback = false;

  IR *record_ = NULL;
  // map<NODETYPE, map<NODETYPE, vector<IR*>> > ir_libary_3D_;
  // map<NODETYPE, map<NODETYPE, set<unsigned long>> > ir_libary_3D_hash_;
  map<NODETYPE, set<unsigned long>> ir_libary_2D_hash_;
  set<unsigned long> stripped_string_hash_;
  // map<NODETYPE, vector<IR*> > ir_libary_2D_;
  // map<NODETYPE, vector<IR *>> left_lib;
  // map<NODETYPE, vector<IR *>> right_lib;
  vector<string> string_libary;
  map<IDTYPE, IDTYPE> relationmap;
  map<IDTYPE, IDTYPE> relationmap_alternate;
  map<IDTYPE, IDTYPE> cross_map;
  set<unsigned long> string_libary_hash_;
  set<unsigned long> value_library_hash_;

  vector<string> cmds_;
  map<string, vector<string>> m_cmd_value_lib_;

  string s_table_name;

  map<NODETYPE, int> type_counter_;

  /* The interface of saving the required context for the mutator. Giving the
     NODETYPE, we should be able to extract all the related IR nodes from this
     library. The string* points to the string of the complete query stmt where
     the current NODE is from. And the int is the unique ID for the specific
     node, can be used to identify and extract the specific node from the IR
     tree when the tree is being reconstructed.
  */
  map<NODETYPE, vector<pair<string *, int>>> real_ir_set;
  map<NODETYPE, vector<pair<string *, int>>> left_lib_set;
  map<NODETYPE, vector<pair<string *, int>>> right_lib_set;

  map<unsigned long, bool> norec_hash;

  set<string *> all_query_pstr_set;
  vector<string *> all_valid_pstr_vec;

  vector<string *> all_cri_valid_pstr_vec;

  SQL_ORACLE *p_oracle;

  Program *parser(const char *sql);
};

#endif
