#include "../include/mutate.h"
#include "../include/ast.h"
#include "../include/define.h"
#include "../include/utils.h"

#include "../parser/bison_parser.h"
#include "../parser/flex_lexer.h"

#include "../oracle/postgre_norec.h"
#include "../oracle/postgre_oracle.h"

#include "../AFL/debug.h"

#include <sys/resource.h>
#include <sys/time.h>

#include <algorithm>
#include <assert.h>
#include <cfloat>
#include <climits>
#include <cstdio>
#include <deque>
#include <fstream>
#include <algorithm>
#define _NON_REPLACE_

using namespace std;

//#define GRAPHLOG

IR *Mutator::deep_copy_with_record(const IR *root, const IR *record) {
  IR *left = NULL, *right = NULL, *copy_res;

  if (root->left_)
    left = deep_copy_with_record(root->left_, record);
  if (root->right_)
    right = deep_copy_with_record(root->right_, record);

  if (root->op_ != NULL)
    copy_res =
        new IR(root->type_,
               OP3(root->op_->prefix_, root->op_->middle_, root->op_->suffix_),
               left, right, root->float_val_, root->str_val_, root->name_,
               root->mutated_times_, root->scope_, root->data_flag_);
  else
    copy_res = new IR(root->type_, NULL, left, right, root->float_val_,
                      root->str_val_, root->name_, root->mutated_times_,
                      root->scope_, root->data_flag_);

  copy_res->data_type_ = root->data_type_;

  if (root == record && record != NULL) {
    this->record_ = copy_res;
  }

  return copy_res;
}

vector<IR *> Mutator::mutate_all(vector<IR *> &v_ir_collector, u64& total_mutate_failed, u64& total_mutate_num) {
  vector<IR *> res;
  IR *root = v_ir_collector.back();

  mutated_root_ = root;

  for (auto old_ir : v_ir_collector) {
    if (not_mutatable_types_.find(old_ir->type_) != not_mutatable_types_.end())
      {continue;}

    vector<IR *> v_mutated_ir = mutate(old_ir);

    for (auto new_ir : v_mutated_ir) {
      total_mutate_num++;
      if (!root->swap_node(old_ir, new_ir)) {
        new_ir->deep_drop();
        // cerr << "Aboard old_ir because swap_node failure. "
        //      << "In func: Mutator::mutate_all(); \n";
        total_mutate_failed++;
        continue;
      }

      if (!check_node_num(root, 300)) {
        root->swap_node(new_ir, old_ir);
        new_ir->deep_drop();
        // cerr << "Aboard old_ir because check_node_num() failed. "
        //      << "In func: Mutator::mutate_all(); \n";
        total_mutate_failed++;
        continue;
      }

      string tmp = root->to_string();
      unsigned tmp_hash = hash(tmp);
      if (global_hash_.find(tmp_hash) != global_hash_.end()) {
        root->swap_node(new_ir, old_ir);
        new_ir->deep_drop();
        total_mutate_failed++;
        continue;
      }

      global_hash_.insert(tmp_hash);
      res.push_back(root->deep_copy());
      root->swap_node(new_ir, old_ir);
      new_ir->deep_drop();
    }
  }
  // cerr << "cur mutated_tree size: " << res.size() << "\n\n\n";
  return res;
}

void Mutator::add_ir_to_library(IR *cur) {
  extract_struct(cur);
  cur = deep_copy(cur);
  add_ir_to_library_no_deepcopy(cur);
  return;
}

void Mutator::add_ir_to_library_no_deepcopy(IR *cur) {
  if (cur->left_)
    add_ir_to_library_no_deepcopy(cur->left_);
  if (cur->right_)
    add_ir_to_library_no_deepcopy(cur->right_);

  auto type = cur->type_;
  auto h = hash(cur);
  if (find(ir_library_hash_[type].begin(), ir_library_hash_[type].end(), h) !=
      ir_library_hash_[type].end())
    return;

  ir_library_hash_[type].insert(h);
  ir_library_[type].push_back(cur);

  return;
}

void Mutator::init_common_string(string filename) {
  common_string_library_.push_back("DO_NOT_BE_EMPTY");
  if (filename != "") {
    ifstream input_string(filename);
    string s;

    while (getline(input_string, s)) {
      common_string_library_.push_back(s);
    }
  }
}

void Mutator::init_data_library_2d(string filename) {
  ifstream input_file(filename);
  string s;

  cout << "[*] init data_library_2d: " << filename << endl;
  while (getline(input_file, s)) {
    vector<string> v_strbuf;
    auto prev_pos = -1;
    for (int i = 0; i < 3; i++) {
      auto pos = s.find(" ", prev_pos + 1);
      v_strbuf.push_back(s.substr(prev_pos + 1, pos - prev_pos - 1));
      prev_pos = pos;
    }
    v_strbuf.push_back(s.substr(prev_pos + 1, s.size() - prev_pos - 1));

    auto data_type1 = get_datatype_by_string(v_strbuf[0]);
    auto data_type2 = get_datatype_by_string(v_strbuf[2]);
    g_data_library_2d_[data_type1][v_strbuf[1]][data_type2].push_back(
        v_strbuf[3]);
  }

  return;
}

void Mutator::init_data_library(string filename) {
  ifstream input_file(filename);
  string s;

  cout << "[*] init data_library: " << filename << endl;
  while (getline(input_file, s)) {
    auto pos = s.find(" ");
    if (pos == string::npos)
      continue;
    auto data_type = get_datatype_by_string(s.substr(0, pos));
    auto v = s.substr(pos + 1, s.size() - pos - 1);
    g_data_library_[data_type].push_back(v);
  }

  return;
}

inline void Mutator::init_value_library() {
  if (value_library_.size() != 0) {
    return;
  }
  vector<unsigned long> value_lib_init = {0,
                                          (unsigned long)LONG_MAX,
                                          (unsigned long)ULONG_MAX,
                                          (unsigned long)CHAR_BIT,
                                          (unsigned long)SCHAR_MIN,
                                          (unsigned long)SCHAR_MAX,
                                          (unsigned long)UCHAR_MAX,
                                          (unsigned long)CHAR_MIN,
                                          (unsigned long)CHAR_MAX,
                                          (unsigned long)MB_LEN_MAX,
                                          (unsigned long)SHRT_MIN,
                                          (unsigned long)INT_MIN,
                                          (unsigned long)INT_MAX,
                                          (unsigned long)SCHAR_MIN,
                                          (unsigned long)SCHAR_MIN,
                                          (unsigned long)UINT_MAX,
                                          (unsigned long)FLT_MAX,
                                          (unsigned long)DBL_MAX,
                                          (unsigned long)LDBL_MAX,
                                          (unsigned long)FLT_MIN,
                                          (unsigned long)DBL_MIN,
                                          (unsigned long)LDBL_MIN};

  value_library_.insert(value_library_.begin(), value_lib_init.begin(),
                        value_lib_init.end());

  return;
}

void Mutator::init_ir_library(string filename) {
  ifstream input_file(filename);
  string line;

  cout << "[*] init ir_library: " << filename << endl;
  while (getline(input_file, line)) {
    if (line.empty())
      continue;
    auto p = parser(line);
    if (p == NULL)
      continue;

    vector<IR *> v_ir;
    auto res = p->translate(v_ir);
    p->deep_delete();
    p = NULL;

    add_ir_to_library(res);
    deep_delete(res);
  }
  return;
}

void Mutator::init_safe_generate_type(string filename) {
  ifstream input_file(filename);
  string line;

  cout << "[*] init safe generate type: " << filename << endl;
  while (getline(input_file, line)) {
    if (line.empty())
      continue;
    auto node_type = get_nodetype_by_string("k" + line);
    safe_generate_type_.insert(node_type);
  }
}

void Mutator::init(string f_testcase, string f_common_string, string file2d,
                   string file1d, string f_gen_type) {

  // if (!f_testcase.empty())
  //   init_ir_library(f_testcase);

  // init value_library_
  init_value_library();

  // init common_string_library
  // if (!f_common_string.empty())
    // {init_common_string(f_common_string);}

  // init data_library_2d
  // if (!file2d.empty())
  //   init_data_library_2d(file2d);

  // if (!file1d.empty())
  //   init_data_library(file1d);
  // if (!f_gen_type.empty())
  //   init_safe_generate_type(f_gen_type);

  if (not_mutatable_types_.size() == 0) {
    float_types_.insert({kFloatLiteral});
    int_types_.insert(kIntLiteral);
    string_types_.insert(kStringLiteral);

    relationmap_[kDataColumnName][kDataTableName] = kRelationSubtype;
    relationmap_[kDataPragmaValue][kDataPragmaKey] = kRelationSubtype;
    relationmap_[kDataTableName][kDataTableName] = kRelationElement;
    relationmap_[kDataColumnName][kDataColumnName] = kRelationElement;

    split_stmt_types_.insert(kStmt);
    split_substmt_types_.insert({kSelectNoParens});

    not_mutatable_types_.insert({kProgram, kStmtlist, kStmt, kCreateStmt,
                                 kDropStmt, kCreateTableStmt, kCreateIndexStmt,
                                 kCreateViewStmt, kDropIndexStmt, kDropTableStmt,
                                 kDropViewStmt, kSelectStmt, kUpdateStmt,
                                 kInsertStmt, kAlterStmt, kReindexStmt});
  }


  ifstream input_test(f_testcase);
  string line;

  // init lib from multiple sql
  while (getline(input_test, line)) {

    vector<IR *> v_ir = parse_query_str_get_ir_set(line);
    if (v_ir.size() <= 0) {
      cerr << "failed to parse: " << line << endl;
      continue;
    }

    IR* v_ir_root = v_ir.back();
    string strip_sql = extract_struct(v_ir_root);
    v_ir.back()->deep_drop();
    v_ir.clear();

    v_ir = parse_query_str_get_ir_set(strip_sql);
    if (v_ir.size() <= 0) {
      cerr << "failed to parse after extract_struct:" << endl
           << line << endl
           << strip_sql << endl;
      continue;
    }

    add_all_to_library(v_ir.back());
    v_ir.back()->deep_drop();
  }

  return;
}

vector<IR *> Mutator::mutate(IR *input) {
  vector<IR *> res;

  if (!lucky_enough_to_be_mutated(input->mutated_times_)) {
    return res;
  }
  auto tmp = strategy_delete(input);
  if (tmp != NULL) {
    res.push_back(tmp);
  }

  tmp = strategy_insert(input);
  if (tmp != NULL) {
    res.push_back(tmp);
  }

  tmp = strategy_replace(input);
  if (tmp != NULL) {
    res.push_back(tmp);
  }

  input->mutated_times_ += res.size();
  for (auto i : res) {
    if (i == NULL)
      continue;
    i->mutated_times_ = input->mutated_times_;
  }
  return res;
}

bool Mutator::replace(IR *root, IR *old_ir, IR *new_ir) {
  auto parent_ir = locate_parent(root, old_ir);
  if (parent_ir == NULL)
    return false;
  if (parent_ir->left_ == old_ir) {
    deep_delete(old_ir);
    parent_ir->left_ = new_ir;
    return true;
  } else if (parent_ir->right_ == old_ir) {
    deep_delete(old_ir);
    parent_ir->right_ = new_ir;
    return true;
  }
  return false;
}

IR *Mutator::locate_parent(IR *root, IR *old_ir) {

  if (root->left_ == old_ir || root->right_ == old_ir)
    return root;

  if (root->left_ != NULL)
    if (auto res = locate_parent(root->left_, old_ir))
      return res;
  if (root->right_ != NULL)
    if (auto res = locate_parent(root->right_, old_ir))
      return res;

  return NULL;
}

IR *Mutator::strategy_delete(IR *cur) {
  assert(cur);
  MUTATESTART

  DOLEFT
  res = deep_copy(cur);
  if (res->left_ != NULL)
    deep_delete(res->left_);
  res->left_ = NULL;

  DORIGHT
  res = deep_copy(cur);
  if (res->right_ != NULL)
    deep_delete(res->right_);
  res->right_ = NULL;

  DOBOTH
  res = deep_copy(cur);
  if (res->left_ != NULL)
    deep_delete(res->left_);
  if (res->right_ != NULL)
    deep_delete(res->right_);
  res->left_ = res->right_ = NULL;

  MUTATEEND
}

IR *Mutator::strategy_insert(IR *cur) {
  // NOTE(vancir): rewritten by vancir.
  assert(cur);

  // auto res = deep_copy(cur);
  // auto parent_type = cur->type_;

  // if (res->right_ == NULL && res->left_ != NULL) {
  //   auto left_type = res->left_->type_;
  //   for (int k = 0; k < 4; k++) {
  //     auto fetch_ir = get_ir_from_library(parent_type);
  //     if (fetch_ir->left_ != NULL && fetch_ir->left_->type_ == left_type &&
  //         fetch_ir->right_ != NULL) {
  //       res->right_ = deep_copy(fetch_ir->right_);
  //       return res;
  //     }
  //   }
  // } else if (res->right_ != NULL && res->left_ == NULL) {
  //   auto right_type = res->left_->type_;
  //   for (int k = 0; k < 4; k++) {
  //     auto fetch_ir = get_ir_from_library(parent_type);
  //     if (fetch_ir->right_ != NULL && fetch_ir->right_->type_ == right_type &&
  //         fetch_ir->left_ != NULL) {
  //       res->left_ = deep_copy(fetch_ir->left_);
  //       return res;
  //     }
  //   }
  // } else if (res->left_ == NULL && res->right_ == NULL) {
  //   for (int k = 0; k < 4; k++) {
  //     auto fetch_ir = get_ir_from_library(parent_type);
  //     if (fetch_ir->right_ != NULL && fetch_ir->left_ != NULL) {
  //       res->left_ = deep_copy(fetch_ir->left_);
  //       res->right_ = deep_copy(fetch_ir->right_);
  //       return res;
  //     }
  //   }
  // }

  // return res;

  if (cur->type_ == kStmtlist) {
    auto new_right = get_from_libary_with_left_type(cur->type_);
    if (new_right != NULL) {
      auto res = cur->deep_copy();
      auto new_res = new IR(kStmtlist, OPMID(";"), res, new_right);
      return new_res;
    }
  }

  else if (cur->right_ == NULL && cur->left_ != NULL) {
    auto left_type = cur->left_->type_;
    auto new_right = get_from_libary_with_left_type(left_type);
    if (new_right != NULL) {
      auto res = cur->deep_copy();
      res->update_right(new_right);
      return res;
    }
  }

  else if (cur->right_ != NULL && cur->left_ == NULL) {
    auto right_type = cur->right_->type_;
    auto new_left = get_from_libary_with_right_type(right_type);
    if (new_left != NULL) {
      auto res = cur->deep_copy();
      res->update_left(new_left);
      return res;
    }
  }

  return get_from_libary_with_type(cur->type_);
}

IR *Mutator::strategy_replace(IR *cur) {
  assert(cur);

  MUTATESTART

  DOLEFT
  if (cur->left_ != NULL) {
    res = deep_copy(cur);

    auto new_node = get_ir_from_library(res->left_->type_);
    new_node->data_type_ = res->left_->data_type_;
    deep_delete(res->left_);
    res->left_ = deep_copy(new_node);
  }

  DORIGHT
  if (cur->right_ != NULL) {
    res = deep_copy(cur);

    auto new_node = get_ir_from_library(res->right_->type_);
    new_node->data_type_ = res->right_->data_type_;
    deep_delete(res->right_);
    res->right_ = deep_copy(new_node);
  }

  DOBOTH
  if (cur->left_ != NULL && cur->right_ != NULL) {
    res = deep_copy(cur);

    auto new_left = get_ir_from_library(res->left_->type_);
    auto new_right = get_ir_from_library(res->right_->type_);
    new_left->data_type_ = res->left_->data_type_;
    new_right->data_type_ = res->right_->data_type_;
    deep_delete(res->right_);
    res->right_ = deep_copy(new_right);

    deep_delete(res->left_);
    res->left_ = deep_copy(new_left);
  }

  MUTATEEND

  return res;
}

bool Mutator::lucky_enough_to_be_mutated(unsigned int mutated_times) {
  if (get_rand_int(mutated_times + 1) < LUCKY_NUMBER) {
    return true;
  }
  return false;
}

pair<string, string> Mutator::get_data_2d_by_type(DATATYPE type1,
                                                  DATATYPE type2) {
  pair<string, string> res("", "");
  auto size = data_library_2d_[type1].size();

  if (size == 0)
    return res;
  auto rint = get_rand_int(size);

  int counter = 0;
  for (auto &i : data_library_2d_[type1]) {
    if (counter++ == rint) {
      return std::make_pair(i.first, vector_rand_ele(i.second[type2]));
    }
  }
  return res;
}

IR *Mutator::generate_ir_by_type(IRTYPE type) {
  auto ast_node = generate_ast_node_by_type(type);
  ast_node->generate();
  vector<IR *> tmp_vector;
  ast_node->translate(tmp_vector);
  assert(tmp_vector.size());

  return tmp_vector[tmp_vector.size() - 1];
}

IR *Mutator::get_ir_from_library(IRTYPE type) {

  const int generate_prop = 1;
  const int threshold = 0;
  static IR *empty_ir = new IR(kStringLiteral, "");
#ifdef USEGENERATE
  if (ir_library_[type].empty() == true ||
      (get_rand_int(400) == 0 && type != kUnknown)) {
    auto ir = generate_ir_by_type(type);
    add_ir_to_library_no_deepcopy(ir);
    return ir;
  }
#endif
  if (ir_library_[type].empty())
    return empty_ir;
  return vector_rand_ele(ir_library_[type]);
}

string Mutator::get_a_string() {
  unsigned com_size = common_string_library_.size();
  unsigned lib_size = string_library_.size();

  if (get_rand_int(3) <= 1) {
    if (lib_size == 0) {
      return "hello";
    } else {
      return string_library_[get_rand_int(lib_size)];
    }
  } else {
    if (com_size == 0) {
      return "hello";
    } else {
      return common_string_library_[get_rand_int(com_size)];
    }
  }
}

unsigned long Mutator::get_a_val() {
  assert(value_library_.size());

  return vector_rand_ele(value_library_);
}

unsigned long Mutator::hash(string &sql) {
  return fuzzing_hash(sql.c_str(), sql.size());
}

unsigned long Mutator::hash(IR *root) {
  auto tmp_str = move(root->to_string());
  return this->hash(tmp_str);
}

void Mutator::debug(IR *root) {
  for (auto &i : data_library_[kDataFunctionName]) {
    cout << i << endl;
  }
}

void Mutator::debug(IR *root, unsigned level) {

  for (unsigned i = 0; i < level; i++)
    cout << " ";

  cout << level << ": "
       << get_string_by_ir_type(root->type_) << ": "
       << get_string_by_data_type(root->data_type_) << ": "
       << get_string_by_data_flag(root->data_flag_) << ": "
       << root -> to_string() 
       << endl;

  if (root->left_)
    debug(root->left_, level + 1);
  if (root->right_)
    debug(root->right_, level + 1);
}

Mutator::~Mutator() {
  for (auto iter = ir_library_.begin(); iter != ir_library_.end(); iter++){
    for (IR* cur_ir : iter->second) {
      cur_ir->deep_drop();
    }
  }

  for (auto iter : all_query_pstr_set) {
    delete iter;
  }

}

string Mutator::extract_struct(IR *root) {
  string res = "";
  _extract_struct(root);
  res = root->to_string();
  trim_string(res);
  return res;
}

void Mutator::_extract_struct(IR *root) {
  auto type = root->type_;
  if (root->left_) {
    extract_struct(root->left_);
  }
  if (root->right_) {
    extract_struct(root->right_);
  }

  if (root->left_ || root->right_ || root->data_type_ == kDataFunctionName)
    return;

  if (root->data_type_ != kDataWhatever && root->data_type_ != kDataFunctionName) {

    root->str_val_ = "x";
    return;
  }

  if (string_types_.find(type) != string_types_.end()) {
    root->str_val_ = "'x'";
  } else if (int_types_.find(type) != int_types_.end()) {
    root->int_val_ = 1;
  } else if (float_types_.find(type) != float_types_.end()) {
    root->float_val_ = 1.0;
  }
}

void Mutator::extract_struct2(IR *root) {
  static int counter = 0;
  auto type = root->type_;
  if (root->left_) {
    extract_struct2(root->left_);
  }
  if (root->right_) {
    extract_struct2(root->right_);
  }

  if (root->left_ || root->right_)
    return;

  if (root->data_type_ != kDataWhatever) {

    root->str_val_ = "x" + to_string(counter++);
    return;
  }

  if (string_types_.find(type) != string_types_.end()) {
    root->str_val_ = "'x'";
  } else if (int_types_.find(type) != int_types_.end()) {
    root->int_val_ = 1;
  } else if (float_types_.find(type) != float_types_.end()) {
    root->float_val_ = 1.0;
  }
}

string Mutator::parse_data(string &input) {
  string res;
  if (!input.compare("_int_")) {
    res = to_string(get_a_val());
  } else if (!input.compare("_empty_")) {
    res = "";
  } else if (!input.compare("_boolean_")) {
    if (get_rand_int(2) == 0)
      res = "false";
    else
      res = "true";
  } else if (!input.compare("_string_")) {
    res = get_a_string();
  } else {
    res = input;
  }

  return res;
}

void Mutator::pre_validate() {
  // Reset components that is local to the one query sequence. 
  reset_id_counter();
  reset_data_library();
  reset_scope_library(true);
  return;
}

bool Mutator::validate(IR *&cur_stmt) {

  if (cur_stmt->type_ == kProgram) {
    vector<IR*> cur_stmt_vec = p_oracle->ir_wrapper.get_stmt_ir_vec(cur_stmt);
    for (IR* cur_stmt_tmp : cur_stmt_vec) {
      if (!this->validate(cur_stmt_tmp)) {
        return false;
      }
    }
  }

  if (cur_stmt == NULL)
    {return false;}

  /* All the fixing steps happens here. */
  // cerr << "Trying to fix stmt: " << cur_stmt->to_string() << " \n";
  if (!fix(cur_stmt)) {  // Pass in kStmt, not kSpecificStatementType. 
    // cur_stmt->deep_drop();
    // cerr << "fix(cur_stmt) failed. \n\n\n";
    return false;
  }
  // cerr << "After fixing: " << cur_stmt->to_string() << " \n\n\n";
  return true;
}


string Mutator::validate(string query) {
  reset_data_library();
  reset_data_library();
  reset_scope_library(true);

  vector<IR *> ir_set = parse_query_str_get_ir_set(query);
  if (ir_set.size() == 0)
    return "";

  IR *root = ir_set.back();
  if (root->type_ != kProgram) {
    root->deep_drop();
    return "";
  }
  
  if (!this->validate(root)){
    return "";
  }
  string res = root->to_string();
  root->deep_drop();
  return res;
}

unsigned int Mutator::calc_node(IR *root) {
  unsigned int res = 0;
  if (root->left_)
    res += calc_node(root->left_);
  if (root->right_)
    res += calc_node(root->right_);

  return res + 1;
}

bool Mutator::fix(IR *cur_stmt) {
  map<IR **, IR *> m_save;
  bool res = true;

  vector<IR*> stmts = {cur_stmt};

  /* 
  ** Constraints the statements size to be smaller than 8 queries. 
  ** Obsoleted
  */
  // if (stmts.size() > 8) {
  //   connect_back(m_save);
  //   return false;
  // }

  /* Separated statement, not substmt! */
  for (auto &stmt : stmts) {
    /* Reset library that is local to one query set. */
    reset_data_library_single_stmt();

    /* Used for reconstruct the tree. */
    map<IR **, IR *> m_substmt_save;
    auto substmts = split_to_stmt(stmt, m_substmt_save, split_substmt_types_);

    int substmt_num = substmts.size();
    // cerr << "Getting substmts num: " << substmt_num << " \n\n\n";
    if (substmt_num > 4) {
      // connect_back(m_save);
      connect_back(m_substmt_save);
      // return false;
      /* Do not validate too complicated query. */
      // cerr << "In Mutator::fix(), for the cur_stmt, substmt_num > 4, too complicated, thus drop. \n";
      // cerr << "cur_stmt string: " << cur_stmt->to_string() << "\n\n\n";
      continue;
    }

    for (auto &substmt : substmts) {
      // reset_scope_library(false);

      int tmp_node_num = calc_node(substmt);
      /* No sub-queries, then <= 150, sub-queries <= 120 */
      if ((substmt_num == 1 && tmp_node_num > 150) || tmp_node_num > 120) {
        // connect_back(m_save);
        // connect_back(m_substmt_save);
        // return false;
        /* Do not validate too complicated query. */
        // cerr << "In Mutator::fix(), for the cur_substmt, tmp_node_num too big, thus drop. \n";
        // cerr << "cur_substmt string: " << substmt->to_string() << "\n\n\n";
        continue;
      }

      // cout << "substmt: " << substmt->to_string() << endl;
      /* Node not connected to the root tree when fixing. */
      res = fix_one(substmt, scope_library_) && res;

      /* Ignore single stmt fixing error now. */
      if (res == false) {
        // cerr << "For substmt: " << substmt->to_string() << ", fix_one failed. \n\n\n";
      }
    }
    res = connect_back(m_substmt_save) && res;
  }
  res = connect_back(m_save) && res;

  return res;
}

vector<IR*> Mutator::pre_fix_transform(IR * root, vector<STMT_TYPE>& stmt_type_vec) {

  p_oracle->init_ir_wrapper(root);
  vector<IR*> all_trans_vec;
  vector<IR*> all_statements_vec = p_oracle->ir_wrapper.get_stmt_ir_vec();

  // cerr << "In func: Mutator::pre_fix_transform(IR * root, vector<STMT_TYPE>& stmt_type_vec), we have all_statements_vec size(): "
  //     << all_statements_vec.size() << "\n\n\n";

  for (IR* cur_stmt : all_statements_vec) {
    /* Identify oracle related statements. Ready for transformation. */
    bool is_oracle_select = false, is_oracle_normal = false;
    if (p_oracle->is_oracle_normal_stmt(cur_stmt)) {is_oracle_normal = true; stmt_type_vec.push_back(ORACLE_NORMAL);}
    else if (p_oracle->is_oracle_select_stmt(cur_stmt)) {is_oracle_select = true; stmt_type_vec.push_back(ORACLE_SELECT);}
    else {stmt_type_vec.push_back(NOT_ORACLE);}

    /* Apply pre_fix_transformation functions. */
    IR* trans_IR = nullptr;
    if (is_oracle_normal) {
      trans_IR = p_oracle->pre_fix_transform_normal_stmt(cur_stmt); // Deep_copied
    } else if (is_oracle_select) {
      trans_IR = p_oracle->pre_fix_transform_select_stmt(cur_stmt); // Deep_copied
    }
    /* If no pre_fix_transformation is needed, directly use the original cur_root. */
    if (trans_IR == nullptr ){
      trans_IR = cur_stmt->deep_copy(); 
    }
    all_trans_vec.push_back(trans_IR);
  }

  return all_trans_vec;
}

vector<vector<vector<IR*>>> Mutator::post_fix_transform(vector<IR*>& all_pre_trans_vec, vector<STMT_TYPE>& stmt_type_vec) {
  int total_run_count = p_oracle->get_mul_run_num();
  vector<vector<vector<IR*>>> all_trans_vec_all_run;
  for (int run_count = 0; run_count < total_run_count; run_count++){
    all_trans_vec_all_run.push_back(this->post_fix_transform(all_pre_trans_vec, stmt_type_vec, run_count)); // All deep_copied. 
  }
  return all_trans_vec_all_run;
}

vector<vector<IR*>> Mutator::post_fix_transform(vector<IR*>& all_pre_trans_vec, vector<STMT_TYPE>& stmt_type_vec, int run_count) {
  // Apply post_fix_transform functions. 
  vector<vector<IR*>> all_post_trans_vec;
  for (int i = 0; i < all_pre_trans_vec.size(); i++) { // Loop through across statements. 
    IR* cur_pre_trans_ir = all_pre_trans_vec[i];
    vector<IR*> post_trans_stmt_vec;
    assert(cur_pre_trans_ir != nullptr);

    bool is_oracle_normal = false, is_oracle_select = false;
    if (stmt_type_vec[i] == ORACLE_SELECT) {is_oracle_select = true;}
    else if (stmt_type_vec[i] == ORACLE_NORMAL) {is_oracle_normal = true;}

    if (is_oracle_normal) {
      post_trans_stmt_vec = p_oracle->post_fix_transform_normal_stmt(cur_pre_trans_ir, run_count); // All deep_copied
    } else if (is_oracle_select) {
      post_trans_stmt_vec = p_oracle->post_fix_transform_select_stmt(cur_pre_trans_ir, run_count); // All deep_copied
    }
    
    if (post_trans_stmt_vec.size() == 0){
      post_trans_stmt_vec.push_back(cur_pre_trans_ir->deep_copy());
    }
    all_post_trans_vec.push_back(post_trans_stmt_vec);
  }
  return all_post_trans_vec;
}

/* 
** From the outer most statements to the inner most statements. 
*/
vector<IR *> Mutator::split_to_stmt(IR *cur_stmt, map<IR **, IR *> &m_save,
                                    set<IRTYPE> &split_set) {
  vector<IR *> res;
  deque<IR *> bfs = {cur_stmt};
  

  /* The root cur_stmt should always be saved. */
  // cerr << "The cur_stmt type_ is: " << cur_stmt->type_ << "\n";
  // cerr << "cur_stmt is: " << cur_stmt->to_string() << "\n\n\n";
  res.push_back(cur_stmt);

  while (!bfs.empty()) {
    auto node = bfs.front();
    bfs.pop_front();

    if (node && node->left_)
      bfs.push_back(node->left_);
    if (node && node->right_)
      bfs.push_back(node->right_); 

    /* See if current node type is kStmt. If yes, disconnect node->left and node->right. */
    if (node->left_ &&
        find(split_set.begin(), split_set.end(), node->left_->type_) != split_set.end() && 
        p_oracle->ir_wrapper.is_in_subquery(cur_stmt, node->left_)
    ) {
      // cerr << "Found sub_stmt with type_: " << get_string_by_ir_type(node->left_->type_) << "\n";
      // cerr << "sub_stmt: " << node->left_->to_string() << "\n\n\n";
      res.push_back(node->left_);
      m_save[&node->left_] = node->left_;
      // cur_stmt->detach_node(node->left_);
    }
    if (node->right_ &&
        find(split_set.begin(), split_set.end(), node->right_->type_) != split_set.end() && 
        p_oracle->ir_wrapper.is_in_subquery(cur_stmt, node->right_)
      ) {
      // cerr << "Found sub_stmt with type_: " << get_string_by_ir_type(node->right_->type_) << "\n";
      // cerr << "sub_stmt: " << node->right_->to_string() << "\n\n\n";
      res.push_back(node->right_);
      m_save[&node->right_] = node->right_;
      // cur_stmt->detach_node(node->right_);
    }
  }

  for (int idx = 1; idx < res.size(); idx++) {
    cur_stmt->detach_node(res[idx]);
  }

  return res;
}

bool Mutator::connect_back(map<IR **, IR *> &m_save) {
  for (auto &iter : m_save) {
    *(iter.first) = iter.second;
  }
  return true;
}

static set<IR *> visited;

bool Mutator::fix_one(IR *stmt_root,
                      map<int, map<DATATYPE, vector<IR *>>> &scope_library) {
  visited.clear();
  /* Not sure whether it is necessary. */
  analyze_scope(stmt_root);
  vector<IR*> ir_to_fix;
  this->fix_preprocessing(stmt_root, ir_to_fix);
  // cerr << "In fix_one, the stmt_root is: " << stmt_root->to_string() << " ir_to_fix size is: " << ir_to_fix.size() << "\n\n\n";
  // cerr << "In fix_one, num of ir_to_fix is: " << ir_to_fix.size() << "\n";
  // for (IR* cur_ir_to_fix : ir_to_fix) {
  //   cerr << "cur_ir_to_fix: data_type_ " << get_string_by_data_type(cur_ir_to_fix->data_type_)
  //        << ", data_flag_ " << get_string_by_data_flag(cur_ir_to_fix->data_flag_)
  //        << ", string: " << cur_ir_to_fix->to_string()
  //        << "\n\n\n" ;
  // }
  if (!this->fix_dependency(stmt_root, ir_to_fix)){
    cerr << "After fix_dependency: cur_stmt_root: " << stmt_root->to_string() << "\n\n\n";
    return false;
  }
  cerr << "After fix_dependency: cur_stmt_root: " << stmt_root->to_string() << "\n\n\n";
  return true;
}

pair<string, string> Mutator::ir_to_string(IR* root, vector<vector<IR*>> all_post_trans_vec, const vector<STMT_TYPE>& stmt_type_vec) {
  // Final step, IR_to_string function. 
  string output_str_mark, output_str_no_mark; 
  for (int i = 0; i < all_post_trans_vec.size(); i++) { // Loop between different statements. 
    vector<IR*> post_trans_vec = all_post_trans_vec[i];
    int count = 0;
    bool is_oracle_select = false;
    if (stmt_type_vec[i] == ORACLE_SELECT) {is_oracle_select = true;}
    for (IR* cur_trans_stmt : post_trans_vec) {  // Loop between different transformations. 
      string tmp = cur_trans_stmt->to_string();
      if (is_oracle_select) {
        output_str_mark += "SELECT 'BEGIN VERI " + to_string(count) + "'; \n";
        output_str_mark  += tmp + "; \n";
        output_str_mark += "SELECT 'END VERI " + to_string(count) + "'; \n";
        output_str_no_mark += tmp + "; \n";
        count++;
      } else {
        output_str_mark += tmp + "; \n";
        output_str_no_mark += tmp + "; \n";
      }
    }
  }
  pair<string, string> output_str_pair =  make_pair(output_str_mark, output_str_no_mark); 
  return output_str_pair;
}

void Mutator::analyze_scope(IR *stmt_root) {
  if (stmt_root->left_) {
    analyze_scope(stmt_root->left_);
  }
  if (stmt_root->right_) {
    analyze_scope(stmt_root->right_);
  }

  auto data_type = stmt_root->data_type_;
  if (data_type == kDataWhatever)
    return;

  scope_library_[stmt_root->scope_][data_type].push_back(stmt_root);
}

// find tree node whose identifier type can be handled
//
// NOTE: identifier type is different from IR type
//
static void collect_ir(IR *root, set<DATATYPE> &type_to_fix,
                       vector<IR *> &ir_to_fix) {
  DATATYPE idtype = root->data_type_;

  if (root->left_) {
    collect_ir(root->left_, type_to_fix, ir_to_fix);
  }

  if (type_to_fix.find(idtype) != type_to_fix.end()) {
    ir_to_fix.push_back(root);
  }

  if (root->right_) {
    collect_ir(root->right_, type_to_fix, ir_to_fix);
  }
}

/*
** relationmap_[kDataColumnName][kDataTableName] = kRelationSubtype;
** relationmap_[kDataPragmaValue][kDataPragmaKey] = kRelationSubtype;
** relationmap_[kDataTableName][kDataTableName] = kRelationElement;
** relationmap_[kDataColumnName][kDataColumnName] = kRelationElement;
*/
void
Mutator::fix_preprocessing(IR *stmt_root,
                     vector<IR*> &ordered_all_subquery_ir) {
  set<DATATYPE> type_to_fix = {kDataColumnName, kDataTableName, kDataPragmaKey, kDataPragmaValue, kDataLiteral};
  vector<IR*> ir_to_fix;
  collect_ir(stmt_root, type_to_fix, ordered_all_subquery_ir);
}

bool Mutator::fix_dependency(IR* cur_stmt_root, const vector<IR*> ir_to_fix_vec) {

  cerr << "Fix_dependency: cur_stmt_root: " << cur_stmt_root->to_string() << "\n\n\n";

  bool is_replace_table = false, is_replace_column = false;
  /* Definition of kDataTableName */
  for (IR* ir_to_fix : ir_to_fix_vec){
    if (ir_to_fix->data_type_ == kDataTableName && (ir_to_fix->data_flag_ == kDefine || ir_to_fix->data_flag_ == kReplace)) {
      if (ir_to_fix->data_flag_ == kReplace) {
        is_replace_table = true;
      }
      string new_name = gen_id_name();
      ir_to_fix->str_val_ = new_name;
      v_table_names.push_back(new_name);
      v_table_names_single.push_back(new_name);
      cerr << "Dependency: Added to v_table_names: " << new_name << ", in kDataTableName with kDefine or kReplace. \n\n\n";
    } else if (ir_to_fix->data_type_ == kDataTableName && ir_to_fix->data_flag_ == kUndefine) {
      if (v_table_names.size() > 0 ) {
        string removed_table_name = v_table_names[get_rand_int(v_table_names.size())];
        v_table_names.erase(std::remove(v_table_names.begin(), v_table_names.end(), removed_table_name), v_table_names.end());
        v_table_names_single.erase(std::remove(v_table_names_single.begin(), v_table_names_single.end(), removed_table_name), v_table_names_single.end());
        ir_to_fix->str_val_ = removed_table_name;
        cerr << "Dependency: Removed from v_table_names: " << removed_table_name << ", in kDataTableName with kUndefine \n\n\n";
      } else {
        cerr << "Dependency Error: Failed to find info in v_table_names, in kDataTableName with kUndefine. \n\n\n";
        ir_to_fix->str_val_ = 'y';
      }
    }
  }

  /* kUse of kDataTableName */
  for (IR* ir_to_fix : ir_to_fix_vec){
    if (ir_to_fix->data_type_ == kDataTableName && (ir_to_fix->data_flag_ == kUse)) {
      if (v_table_names.size() == 0) {
        cerr << "Dependency Error: Failed to find info in v_table_names, in kDataTableName with kUse. \n\n\n";
        ir_to_fix->str_val_ = "y";
        return false;
      }
      string used_name = v_table_names[get_rand_int(v_table_names.size())];
      ir_to_fix->str_val_ = used_name;
      // v_table_names.push_back(new_name);
      v_table_names_single.push_back(used_name);
      cerr << "Dependency: In the context of kUsed table, we got table_name: " << used_name << ". \n\n\n";
      if (is_replace_table) {
        v_table_names.erase(std::remove(v_table_names.begin(), v_table_names.end(), used_name), v_table_names.end());
        cerr << "Dependency: In the context of replacing table, removing table_name: " << used_name << ". \n\n\n";
      }
    }
  }

  /* Definition and kUse of kDataColumnName */
  for (IR* ir_to_fix : ir_to_fix_vec){
    /* Don't fix values inside INSERT_REST as kDataColumnName. */
    if (p_oracle->ir_wrapper.is_in_insert_rest(cur_stmt_root, ir_to_fix, false)) {
      ir_to_fix->data_type_ = kDataLiteral;
      continue;
    }
    if (ir_to_fix->data_type_ == kDataColumnName && (ir_to_fix->data_flag_ == kDefine || ir_to_fix->data_flag_ == kReplace)) {
      if (ir_to_fix->data_flag_ == kReplace) {
        is_replace_column = true;
      }
      string new_name = gen_column_name();
      ir_to_fix->str_val_ = new_name;
      vector<IR*> table_name_ir;
      set<DATATYPE> type_to_search = {kDataTableName};
      IR* closest_table_ir = find_closest_node(cur_stmt_root, ir_to_fix, kDataTableName);
      string closest_table_name = "";
      if (closest_table_ir == NULL) {
        closest_table_name = v_table_names_single[get_rand_int(v_table_names_single.size())];
      } else {
        closest_table_name = closest_table_ir->str_val_;
      }
      if (closest_table_name == "" || closest_table_name == "x") {
        cerr << "Dependency Error: Cannot find the closest_table_name from the query. In kDataColumnName, kDefine or kReplace. \n\n\n";
        return false;
      }

      cerr << "Dependency: For column_name: " << new_name << ", found closest_table_name: " << closest_table_name << ". \n\n\n";
      m_tables[closest_table_name].push_back(new_name);

      /* Next, we save the column type to the mapping */
      if (ir_to_fix->data_flag_ == kDefine) {
        /* For normal tables, we need to save its column type. */
        if (ir_to_fix ->get_parent() ->get_parent()->type_ == kColumnDef) {
          IR* type_name_ir = ir_to_fix->get_parent()->right_->left_;   // identifier -> kColumnDef(kUnknown) -> type_name -> kNumericType or kCharacterType
          if (type_name_ir->type_ == kNumericType) { // NumericalType
            if (type_name_ir->op_ && type_name_ir->op_->prefix_ == "BOOLEAN") {
              m_column2datatype[new_name] = 3;  // boolean
            } else {
              m_column2datatype[new_name] = 1;  // numerial
            }
          } 
          else if (type_name_ir->type_ == kCharacterType) {m_column2datatype[new_name] = 2;} // kCharacterType
          else {m_column2datatype[new_name] = 0;} // Unknown type. 
        }
        /* For view, we don't have the obvious type information. Currently treat it as unknown types. */
        else {
          m_column2datatype[new_name] = 0; // Unknown data type. 
        }
      } else { // kReplace
        /* This is a ALTER replace column statment. Find the previous column name, map it to the new one. */
        vector<IR*> column_name_ir;
        set<DATATYPE> type_to_search = {kDataColumnName};
        collect_ir(cur_stmt_root, type_to_search, column_name_ir);
        string prev_column_name = column_name_ir[0]->str_val_;
        int column_data_type = m_column2datatype[prev_column_name];
        m_column2datatype[new_name] = column_data_type;
        cerr << "Dependency: In the context of kReplace column, we got new column_name: " << new_name << ". \n\n\n";
      }

    } else if (ir_to_fix->data_type_ == kDataColumnName && ir_to_fix->data_flag_ == kUndefine) {
      /* Find the table_name in the query first. */
      set<DATATYPE> type_to_search = {kDataTableName};

      IR* closest_table_ir = find_closest_node(cur_stmt_root, ir_to_fix, kDataTableName);
      string closest_table_name = "";
      if (closest_table_ir == NULL) {
        closest_table_name = v_table_names_single[get_rand_int(v_table_names_single.size())];
      } else {
        closest_table_name = closest_table_ir->str_val_;
      }
      if (closest_table_name == "" || closest_table_name == "x") {
        cerr << "Dependency Error: Cannot find the closest_table_name from the query. In kDataColumnName, kUndefine. \n\n\n";
        return false;
      }

      cerr << "Dependency: In kDataColumnName, kUndefine, found closest_table_name: " << closest_table_name << ". \n\n\n";

      vector<string>& column_vec = m_tables[closest_table_name];
      string removed_column_name = column_vec[get_rand_int(column_vec.size())];
      column_vec.erase(std::remove(column_vec.begin(), column_vec.end(), removed_column_name), column_vec.end());
      ir_to_fix->str_val_ = removed_column_name;
    } 

    /* kUse of kDataColumnName. */
    else if (ir_to_fix->data_type_ == kDataColumnName && ir_to_fix->data_flag_ == kUse) {
      
      IR* closest_table_ir = find_closest_node(cur_stmt_root, ir_to_fix, kDataTableName);
      string closest_table_name = "";
      if (closest_table_ir != NULL && (get_rand_int(100) < 50) ) {
        closest_table_name = closest_table_ir->str_val_;
      } else {
        if (v_table_names_single.size() == 0) {
          cerr << "Dependency Error: v_table_names_single.size() == 0. In kDataColumnName, kDefine or kReplace. \n\n\n";
        }
        closest_table_name = v_table_names_single[get_rand_int(v_table_names_single.size())];
      }
      if (closest_table_name == "" || closest_table_name == "x") {
        cerr << "Dependency Error: Cannot find the closest_table_name from the query. In kDataColumnName, kDefine or kReplace. \n\n\n";
        return false;
      }

      vector<string>& cur_mapped_column_name_vec = m_tables[closest_table_name];
      if (cur_mapped_column_name_vec.size() > 0) {
        string cur_chosen_column = cur_mapped_column_name_vec[get_rand_int(cur_mapped_column_name_vec.size())];
        ir_to_fix->str_val_ = cur_chosen_column;
        cerr << "Dependency: In kDataColumnName, kUse, we choose closest_table_name: " << closest_table_name << " and column_name: " << cur_chosen_column << ". \n\n\n";
      } else {
        ir_to_fix->str_val_ = "y";
        cerr << "Dependency Error: In kDataColumnName, kUse, cannot find mapping from table_name" << closest_table_name << ". \n\n\n";
      }
    }
  }

  /* Fix the Literal. */
  for (IR* ir_to_fix : ir_to_fix_vec){
    if (ir_to_fix->data_type_ == kDataLiteral) {
      int column_data_type = 0;
      IR* closest_column_name = find_closest_node(cur_stmt_root, ir_to_fix, kDataColumnName);
      if (closest_column_name != NULL) {
        string column_name = closest_column_name->str_val_;
        if (m_column2datatype.find(column_name) != m_column2datatype.end())
          {column_data_type = m_column2datatype[column_name];} // 0 is Unknown, 1 is Numerical, 2 is Character, 3 is Boolean. 
      }
      if (!column_data_type) {column_data_type = (get_rand_int(3) + 1);} // 30/30/30 Numerical, Character or Boolean. 
      if (column_data_type == 1) { //Numbercal
        /* 50/50 INT or FLOAT */
        if (get_rand_int(100) < 50){ // INT
          if (get_rand_int(100) < 50) {
            if (value_library_.size() == 0) {
              FATAL("Error: value_library_ is not being init properly. \n");
            }
            ir_to_fix->int_val_ = vector_rand_ele(value_library_);
            ir_to_fix->str_val_ = to_string(ir_to_fix->int_val_);
          } else {
            ir_to_fix->int_val_ = get_rand_int(100);
            ir_to_fix->str_val_ = to_string(ir_to_fix->int_val_);
          }
        } 
        else {  // FLOAT
          ir_to_fix->float_val_ = (double)(get_rand_int(100000000));
          ir_to_fix->str_val_ = to_string(ir_to_fix->float_val_);
        }
      }
      else if (column_data_type == 3){ //Boolean
        if (get_rand_int(100) < 50){
          ir_to_fix->str_val_ = "TRUE";
        } else {
          ir_to_fix->str_val_ = "FALSE";
        }
      }
      else { // Character
        ir_to_fix->str_val_ = get_a_string();
      }
    }
  }

  return true;

  // map<IR *, bool> zero_indegrees;
  // for (auto &iter : graph) {
  //   if (zero_indegrees.find(iter.first) == zero_indegrees.end()) {
  //     zero_indegrees[iter.first] = true;
  //   }
  //   for (auto ir : iter.second) {
  //     zero_indegrees[ir] = false;
  //   }
  // }
  // for (auto &iter : graph) {
  //   auto type1 = iter.first->data_type_;
  //   auto beg = iter.first;
  //   if (zero_indegrees[beg] == false || visited.find(beg) != visited.end()) {
  //     continue;
  //   }
  //   res &= fill_one(iter.first);
  //   res &= fill_stmt_graph_one(graph, iter.first);
  // }

  // return res;
}

bool Mutator::fill_stmt_graph_one(map<IR *, vector<IR *>> &graph, IR *ir) {
  if (graph.find(ir) == graph.end())
    return true;

  bool res = true;
  auto type = ir->data_type_;
  auto &vec = graph[ir];

  if (!vec.empty()) {
    for (auto d : vec) {
      res = res & fill_one_pair(ir, d);
      res = res & fill_stmt_graph_one(graph, d);
    }
  }
  return res;
}

static bool replace_in_vector(string &old_str, string &new_str,
                              vector<string> &victim) {
  for (int i = 0; i < victim.size(); i++) {
    if (victim[i] == old_str) {
      victim[i] = new_str;
      return true;
    }
  }
  return false;
}

static bool remove_in_vector(string &str_to_remove, vector<string> &victim) {
  for (auto iter = victim.begin(); iter != victim.end(); iter++) {
    if (*iter == str_to_remove) {
      victim.erase(iter);
      return true;
    }
  }
  return false;
}

bool Mutator::remove_one_from_datalibrary(DATATYPE datatype, string &key) {
  return remove_in_vector(key, data_library_[datatype]);
}

bool Mutator::replace_one_from_datalibrary(DATATYPE datatype, string &old_str,
                                           string &new_str) {
  return replace_in_vector(old_str, new_str, data_library_[datatype]);
}

bool Mutator::remove_one_pair_from_datalibrary_2d(DATATYPE p_datatype,
                                                  DATATYPE c_data_type,
                                                  string &p_key) {
  for (auto &value : data_library_2d_[p_datatype][p_key][c_data_type]) {
    remove_one_from_datalibrary(c_data_type, value);
  }

  data_library_2d_[p_datatype][p_key].erase(c_data_type);
  if (data_library_2d_[p_datatype][p_key].empty()) {
    remove_one_from_datalibrary(p_datatype, p_key);
    data_library_2d_[p_datatype].erase(p_key);
  }

  return true;
}

#define has_element(a, b) (find(a.begin(), a.end(), b) != (a).end())
#define has_key(a, b) ((a).find(b) != (a).end())

bool Mutator::replace_one_value_from_datalibray_2d(DATATYPE p_datatype,
                                                   DATATYPE c_data_type,
                                                   string &p_key,
                                                   string &old_c_value,
                                                   string &new_c_value) {
  replace_one_from_datalibrary(c_data_type, old_c_value, new_c_value);
  replace_in_vector(old_c_value, new_c_value,
                    data_library_2d_[p_datatype][p_key][c_data_type]);
  return true;
}

bool Mutator::fill_one(IR *ir) {
  auto type = ir->data_type_;
  visited.insert(ir);
  if (isDefine(ir->data_flag_)) {
    string new_name = gen_id_name();
    data_library_[type].push_back(new_name);
    ir->str_val_ = new_name;

    for (auto iter : relationmap_) {
      for (auto iter2 : iter.second) {
        if (iter2.first == type && iter2.second == kRelationSubtype) {
          data_library_2d_[type][new_name];
        }
      }
    }
    return true;
  } else if (isAlias(ir->data_flag_)) {
    string alias_target;
    if (data_library_[type].size() != 0)
      alias_target = vector_rand_ele(data_library_[type]);
    else {
      alias_target = get_rand_int(2) ? "v0" : "v1";
    }

    string new_name = gen_id_name();
    data_library_[type].push_back(new_name);
    ir->str_val_ = new_name;

    if (has_key(data_library_2d_, type)) {
      if (has_key(data_library_2d_[type], alias_target)) {
        data_library_2d_[type][new_name] = data_library_2d_[type][alias_target];
      }
    }
    return true;
  }

  else if (data_library_.find(type) != data_library_.end()) {
    if (data_library_[type].empty()) {
      ir->str_val_ = "v0";
      return false;
    }
    ir->str_val_ = vector_rand_ele(data_library_[type]);
    if (isUndefine(ir->data_flag_)) {
      remove_one_from_datalibrary(ir->data_type_, ir->str_val_);
      if (has_key(data_library_2d_, type) &&
          has_key(data_library_2d_[type], ir->str_val_)) {
        for (auto itr = data_library_2d_[type][ir->str_val_].begin();
             has_key(data_library_2d_[type], ir->str_val_) &&
             itr != data_library_2d_[type][ir->str_val_].end();
             itr++) {
          auto c_data_type = *itr;
          remove_one_pair_from_datalibrary_2d(type, c_data_type.first,
                                              ir->str_val_);
          itr--;
          if (!has_key(data_library_2d_[type], ir->str_val_))
            break;
        }
      }
    }
    return true;
  } else if (g_data_library_.find(type) != g_data_library_.end()) {
    if (g_data_library_[type].empty()) {
      return false;
    }
    ir->str_val_ = vector_rand_ele(g_data_library_[type]);
    return true;
  } else if (g_data_library_2d_.find(type) != g_data_library_2d_.end()) {
    int choice = get_rand_int(g_data_library_2d_[type].size());
    auto iter = g_data_library_2d_[type].begin();
    while (choice > 0) {
      iter++;
      choice--;
    }
    ir->str_val_ = iter->first;
    return true;
  } else {
    return false;
  }
  return true;
}

bool Mutator::fill_one_pair(IR *parent, IR *child) {
  visited.insert(child);

  bool is_define = isDefine(child->data_flag_);
  bool is_replace = isReplace(child->data_flag_);
  bool is_undefine = isUndefine(child->data_flag_);
  bool is_alias = isAlias(child->data_flag_);

  string new_name = "";
  if (is_define || is_replace || is_alias) {
    new_name = gen_id_name();
  }

  auto p_type = parent->data_type_;
  auto c_type = child->data_type_;
  auto p_str = parent->str_val_;

  auto r_type = relationmap_[c_type][p_type];
  switch (r_type) {
  case kRelationElement:

    if (is_replace) {
      child->str_val_ = new_name;
      replace_one_from_datalibrary(c_type, p_str, new_name);

      if (has_key(data_library_2d_, p_type)) {
        if (has_key(data_library_2d_[p_type], p_str)) {
          auto tmp = data_library_2d_[p_type].extract(p_str);
          tmp.key() = new_name;
          data_library_2d_[p_type].insert(move(tmp));
        }
      } else {
        for (auto &i1 : data_library_2d_) {
          for (auto &i2 : i1.second) {
            for (auto &i3 : i2.second) {
              if (i3.first == c_type) {
                if (has_element(i3.second, p_str)) {
                  replace_in_vector(p_str, new_name, i3.second);
                  goto END;
                }
              }
            }
          }
        }
      }
    } else if (is_alias) {
      child->str_val_ = new_name;

      if (has_key(data_library_2d_, p_type)) {
        if (has_key(data_library_2d_[p_type], p_str)) {
          data_library_2d_[p_type][new_name] = data_library_2d_[p_type][p_str];
          data_library_[p_type].push_back(new_name);
        }
      }
    } else {
      child->str_val_ = p_str;
    }
  END:
    break;

  case kRelationSubtype:
    if (data_library_2d_.find(p_type) != data_library_2d_.end()) {
      if (data_library_2d_[p_type].find(p_str) !=
          data_library_2d_[p_type].end()) {
        if (is_define) {
          data_library_2d_[p_type][p_str][c_type].push_back(new_name);
          child->str_val_ = new_name;
          data_library_[c_type].push_back(new_name);
          break;
        } else if (is_undefine) {
          if ((data_library_2d_[p_type][p_str][c_type]).empty()) {
            child->str_val_ = "v1";
            break;
          }
          child->str_val_ =
              vector_rand_ele(data_library_2d_[p_type][p_str][c_type]);
          remove_in_vector(child->str_val_,
                           data_library_2d_[p_type][p_str][c_type]);
          remove_in_vector(child->str_val_, data_library_[c_type]);
          break;
        } else if (data_library_2d_[p_type][p_str].find(c_type) !=
                   data_library_2d_[p_type][p_str].end()) {
          if (data_library_2d_[p_type][p_str][c_type].empty() == false) {
            child->str_val_ =
                vector_rand_ele(data_library_2d_[p_type][p_str][c_type]);
          }
        } else {
          if (data_library_[c_type].empty()) {
            if (get_rand_int(2) == 1) {
              child->str_val_ = "v0";
            } else {
              child->str_val_ = "v1";
            }
          } else
            child->str_val_ = vector_rand_ele(data_library_[c_type]);
        }
      } else {
      }
    } else if (g_data_library_2d_.find(p_type) != g_data_library_2d_.end()) {
      if (g_data_library_2d_[p_type].find(p_str) !=
          g_data_library_2d_[p_type].end()) {
        if (g_data_library_2d_[p_type][p_str].find(c_type) !=
            g_data_library_2d_[p_type][p_str].end()) {
          if (g_data_library_2d_[p_type][p_str][c_type].empty() == false) {
            child->str_val_ =
                vector_rand_ele(g_data_library_2d_[p_type][p_str][c_type]);
          }
        }
      }
    } else {
      return false;
    }

    break;

  default:
    assert(0);
    break;
  }

  return true;
}

void Mutator::reset_scope_library(bool clear_define) {
  scope_library_.clear();
  return;
}

void Mutator::reset_data_library_single_stmt() {
  this->v_table_names_single.clear();
  this->v_alias_names_single.clear();
  this->m_table2alias_single.clear();
}

void Mutator::reset_data_library() {
  // data_library_.clear();
  // data_library_2d_.clear();
  m_tables.clear();
  v_table_names.clear();
  m_table2index.clear();
  m_table2alias_single.clear();
  v_table_names_single.clear();
  v_alias_names_single.clear();
}

static IR *search_mapped_ir(IR *ir, DATATYPE type) {
  vector<IR *> to_search;
  vector<IR *> backup;
  to_search.push_back(ir);
  while (!to_search.empty()) {
    for (auto i : to_search) {
      if (i->data_type_ == type) {
        return i;
      }
      if (i->left_) {
        backup.push_back(i->left_);
      }
      if (i->right_) {
        backup.push_back(i->right_);
      }
    }
    to_search = move(backup);
    backup.clear();
  }
  return NULL;
}

IR *Mutator::find_closest_node(IR *stmt_root, IR *node, DATATYPE type) {
  auto cur = node;
  while (true) {
    auto parent = locate_parent(stmt_root, cur);
    if (!parent)
      break;
    bool flag = false;
    while (parent->left_ == NULL || parent->right_ == NULL) {
      cur = parent;
      parent = locate_parent(stmt_root, cur);
      if (!parent) {
        flag = true;
        break;
      }
    }
    if (flag)
      return NULL;

    auto search_root = parent->left_ == cur ? parent->right_ : parent->left_;
    auto res = search_mapped_ir(search_root, type);
    if (res)
      return res;

    cur = parent;
  }
  return NULL;
}

int Mutator::try_fix(char *buf, int len, char *&new_buf, int &new_len) {
  string sql(buf);
  auto ast = parser(sql);

  new_buf = buf;
  new_len = len;
  if (ast == NULL)
    return 0;

  vector<IR *> v_ir;
  auto ir_root = ast->translate(v_ir);
  ast->deep_delete();

  if (ir_root == NULL)
    return 0;
  validate(ir_root);
  string fixed = ir_root->to_string();
  if (fixed == "") {
    return 0;
  }
  deep_delete(ir_root);
  if (fixed.empty())
    return 0;

  char *sfixed = (char *)malloc(fixed.size() + 1);
  memcpy(sfixed, fixed.c_str(), fixed.size());
  sfixed[fixed.size()] = 0;

  new_buf = sfixed;
  new_len = fixed.size();

  return 1;
}

// added by vancir.

// Return use_temp or not.
bool Mutator::get_valid_str_from_lib(string &ori_norec_select) {
  /* For 1/2 chance, grab one query from the norec library, and return.
   * For 1/2 chance, take the template from the p_oracle and return.
   */
  bool is_succeed = false;

  while (!is_succeed) { // Potential dead loop. Only escape through return.
    bool use_temp = false;
    int query_method = get_rand_int(2);
    if (all_valid_pstr_vec.size() > 0 && query_method < 1) {
      /* Pick the query from the lib, pass to the mutator. */
      ori_norec_select =
          *(all_valid_pstr_vec[get_rand_int(all_valid_pstr_vec.size())]);
      
      if (ori_norec_select == "" ||
          !p_oracle->is_oracle_valid_stmt(ori_norec_select))
        continue;
      use_temp = false;
    } else {
      /* Pick the query from the template, pass to the mutator. */
      ori_norec_select = p_oracle->get_temp_valid_stmts();
      use_temp = true;
    }

    trim_string(ori_norec_select);
    return use_temp;
  }
  fprintf(stderr, "*** FATAL ERROR: Unexpected code execution in the "
                  "Mutator::get_valid_str_from_lib function. \n");
  fflush(stderr);
  abort();
}


vector<IR *> Mutator::parse_query_str_get_ir_set(string &query_str) {
  vector<IR *> ir_set;

  ensure_semicolon_at_query_end(query_str);

  // cerr << "In func: Mutator::parse_query_str_get_ir_set(), getting query_str: \n" << query_str << " \n";
  auto p_strip_sql = parser(query_str.c_str());
  if (p_strip_sql == NULL) {
    // cerr << "In func: Mutator::parse_query_str_get_ir_set(), returned because p_strip_sql == NULL; \n";
    return ir_set;
  }

  try {
    auto root_ir = p_strip_sql->translate(ir_set);
  } catch (...) {
    // cerr << "In func: Mutator::parse_query_str_get_ir_set(), into the catch exceptions. \n";
    p_strip_sql->deep_delete();

    for (IR* ir : ir_set)
      {ir->drop();}

    ir_set.clear();
    return ir_set;
  }

  // cerr << "In func: Mutator::parse_query_str_get_ir_set(), finished translate(). \n";

  int unique_id_for_node = 0;
  for (auto ir : ir_set) 
    {ir->uniq_id_in_tree_ = unique_id_for_node++;}

  p_strip_sql->deep_delete();
  // ir_set.back()->deep_drop();
  // ir_set.clear();

  return ir_set;
}


bool Mutator::check_node_num(IR *root, unsigned int limit) {

  auto v_statements = extract_statement(root);
  bool is_good = true;

  for (auto stmt : v_statements) {
    // cerr << "For current query stmt: " << root->to_string() << endl;
    // cerr << calc_node(stmt) << endl;
    if (calc_node(stmt) > limit) {
      is_good = false;
      break;
    }
  }

  return is_good;
}


vector<IR *> Mutator::extract_statement(IR *root) {
  vector<IR *> res;
  deque<IR *> bfs = {root};

  while (bfs.empty() != true) {
    auto node = bfs.front();
    bfs.pop_front();

    if (node->type_ == kStmt)
      res.push_back(node);
    if (node->left_)
      bfs.push_back(node->left_);
    if (node->right_)
      bfs.push_back(node->right_);
  }

  return res;
}

void Mutator::set_dump_library(bool to_dump) { this->dump_library = to_dump; }

int Mutator::get_ir_libary_2D_hash_kStatement_size() {
  return this->ir_libary_2D_hash_[kStmt].size();
}

bool Mutator::is_stripped_str_in_lib(string stripped_str) {
  // stripped_str = extract_struct(stripped_str);
  unsigned long str_hash = hash(stripped_str);
  if (stripped_string_hash_.find(str_hash) != stripped_string_hash_.end())
    return true;
  stripped_string_hash_.insert(str_hash);
  return false;
}

/* add_to_library supports only one stmt at a time,
 * add_all_to_library is responsible to split the
 * the current IR tree into single query stmts.
 * This function is not responsible to free the input IR tree.
 */
void Mutator::add_all_to_library(IR *ir, const vector<int> &explain_diff_id) {
  add_all_to_library(ir->to_string(), explain_diff_id);
}

/*  Save an interesting query stmt into the mutator library.
 *
 *   The uniq_id_in_tree_ should be, more idealy, being setup and kept unchanged
 * once an IR tree has been reconstructed. However, there are some difficulties
 * there. For example, how to keep the uniqueness and the fix order of the
 * unique_id_in_tree_ for each node in mutations. Therefore, setting and
 * checking the uniq_id_in_tree_ variable in every nodes of an IR tree are only
 * done when necessary by calling this funcion and
 * get_from_library_with_[_,left,right]_type. We ignore this unique_id_in_tree_
 * in other operations of the IR nodes. The unique_id_in_tree_ is setup based on
 * the order of the ir_set vector, returned from Program*->translate(ir_set).
 *
 */

void Mutator::add_all_to_library(string whole_query_str,
                                 const vector<int> &explain_diff_id) {

  /* If the query_str is empty. Ignored and return. */
  bool is_empty = true;
  for (int i = 0; i < whole_query_str.size(); i++) {
    char c = whole_query_str[i];
    if (!isspace(c) && c != '\n' && c != '\0') {
      is_empty = false; // Not empty.
      break;
    } // Empty
  }

  if (is_empty)
    return;

  vector<string> queries_vector = string_splitter(whole_query_str, ";");
  int i = 0; // For counting oracle valid stmt IDs.
  for (auto current_query : queries_vector) {
    trim_string(current_query);
    current_query += ";";
    // check the validity of the IR here
    // The unique_id_in_tree_ variable are being set inside the parsing func.
    vector<IR *> ir_set = parse_query_str_get_ir_set(current_query);
    if (ir_set.size() == 0)
      continue;

    IR *root = ir_set[ir_set.size() - 1];
    IR* cur_stmt_ir = p_oracle->ir_wrapper.get_stmt_ir_vec(root)[0];

    if (p_oracle->is_oracle_select_stmt(cur_stmt_ir)) {
    // if (p_oracle->is_oracle_valid_stmt(current_query)) {
      if (std::find(explain_diff_id.begin(), explain_diff_id.end(), i) !=
          explain_diff_id.end()) {
        add_to_valid_lib(root, current_query, true);
      } else {
        add_to_valid_lib(root, current_query, false);
      }
      ++i; // For counting oracle valid stmt IDs.
    } else {
      add_to_library(root, current_query);
    }

    root->deep_drop();
  }
}


void Mutator::add_to_valid_lib(IR *ir, string &select,
                               const bool is_explain_diff) {

  unsigned long p_hash = hash(select);

  if (norec_hash.find(p_hash) != norec_hash.end())
    return;

  norec_hash[p_hash] = true;

  string *new_select = new string(select);

  all_query_pstr_set.insert(new_select);
  all_valid_pstr_vec.push_back(new_select);

  if (this->dump_library) {
    std::ofstream f;
    f.open("./norec-select", std::ofstream::out | std::ofstream::app);
    f << *new_select << endl;
    f.close();
  }

  add_to_library_core(ir, new_select);

  return;
}

void Mutator::add_to_library(IR *ir, string &query) {

  if (query == "")
    return;

  NODETYPE p_type = ir->type_;
  unsigned long p_hash = hash(query);

  if (ir_libary_2D_hash_[p_type].find(p_hash) !=
      ir_libary_2D_hash_[p_type].end()) {
    /* query not interesting enough. Ignore it and clean up. */
    return;
  }
  ir_libary_2D_hash_[p_type].insert(p_hash);

  string *p_query_str = new string(query);
  all_query_pstr_set.insert(p_query_str);
  // all_valid_pstr_vec.push_back(p_query_str);

  if (this->dump_library) {
    std::ofstream f;
    f.open("./normal-lib", std::ofstream::out | std::ofstream::app);
    f << *p_query_str << endl;
    f.close();
  }

  add_to_library_core(ir, p_query_str);

  // get_memory_usage();  // Debug purpose.

  return;
}

void Mutator::add_to_library_core(IR *ir, string *p_query_str) {
  /* Save an interesting query stmt into the mutator library. Helper function
   * for Mutator::add_to_library();
   */

  if (*p_query_str == "")
    return;

  int current_unique_id = ir->uniq_id_in_tree_;
  bool is_skip_saving_current_node = false; //

  NODETYPE p_type = ir->type_;
  NODETYPE left_type = kEmpty, right_type = kEmpty;
  
  string ir_str = ir->to_string();
  unsigned long p_hash = hash(ir_str);
  if (p_type != kProgram && ir_libary_2D_hash_[p_type].find(p_hash) !=
                                ir_libary_2D_hash_[p_type].end()) {
    /* current node not interesting enough. Ignore it and clean up. */
    return;
  }
  if (p_type != kProgram)
    ir_libary_2D_hash_[p_type].insert(p_hash);

  if (!is_skip_saving_current_node)
    real_ir_set[p_type].push_back(
        std::make_pair(p_query_str, current_unique_id));

  // Update right_lib, left_lib
  if (ir->right_ && ir->left_ && !is_skip_saving_current_node) {
    left_type = ir->left_->type_;
    right_type = ir->right_->type_;
    left_lib_set[left_type].push_back(std::make_pair(
        p_query_str, current_unique_id)); // Saving the parent node id. When
                                          // fetching, use current_node->right.
    right_lib_set[right_type].push_back(std::make_pair(
        p_query_str, current_unique_id)); // Saving the parent node id. When
                                          // fetching, use current_node->left.
  }

  if (this->dump_library) {

    std::ofstream f;
    f.open("./append-core", std::ofstream::out | std::ofstream::app);
    f << *p_query_str << " node_id: " << current_unique_id << endl;
    f.close();
  }

  if (ir->left_) {
    add_to_library_core(ir->left_, p_query_str);
  }

  if (ir->right_) {
    add_to_library_core(ir->right_, p_query_str);
  }

  return;
}

int Mutator::get_cri_valid_collection_size() {
  return all_cri_valid_pstr_vec.size();
}

int Mutator::get_valid_collection_size() { return all_valid_pstr_vec.size(); }


IR *Mutator::get_from_libary_with_type(IRTYPE type_) {
  /* Given a data type, return a randomly selected prevously seen IR node that
     matched the given type. If nothing has found, return an empty
     kStringLiteral.
  */

  vector<IR *> current_ir_set;
  IR *current_ir_root;
  vector<pair<string *, int>> &all_matching_node = real_ir_set[type_];
  IR *return_matched_ir_node = NULL;

  if (all_matching_node.size() > 0) {
    /* Pick a random matching node from the library. */
    int random_idx = get_rand_int(all_matching_node.size());
    std::pair<string *, int> &selected_matched_node =
        all_matching_node[random_idx];
    string *p_current_query_str = selected_matched_node.first;
    int unique_node_id = selected_matched_node.second;

    /* Reconstruct the IR tree. */
    current_ir_set = parse_query_str_get_ir_set(*p_current_query_str);
    if (current_ir_set.size() <= 0)
      return new IR(kStringLiteral, "");
    current_ir_root = current_ir_set.back();

    /* Retrive the required node, deep copy it, clean up the IR tree and return.
     */
    IR *matched_ir_node = current_ir_set[unique_node_id];
    if (matched_ir_node != NULL) {
      if (matched_ir_node->type_ != type_) {
        current_ir_root->deep_drop();
        return new IR(kStringLiteral, "");
      }
      // return_matched_ir_node = matched_ir_node->deep_copy();
      return_matched_ir_node = matched_ir_node;
      current_ir_root->detach_node(return_matched_ir_node);
    }

    current_ir_root->deep_drop();

    if (return_matched_ir_node != NULL) {
      // cerr << "\n\n\nSuccessfuly with_type: with string: " <<
      // return_matched_ir_node->to_string() << endl;
      return return_matched_ir_node;
    }
  }

  return new IR(kStringLiteral, "");
}

IR *Mutator::get_from_libary_with_left_type(IRTYPE type_) {
  /* Given a left_ type, return a randomly selected prevously seen right_ node
     that share the same parent. If nothing has found, return NULL.
  */

  vector<IR *> current_ir_set;
  IR *current_ir_root;
  vector<pair<string *, int>> &all_matching_node = left_lib_set[type_];
  IR *return_matched_ir_node = NULL;

  if (all_matching_node.size() > 0) {
    /* Pick a random matching node from the library. */
    int random_idx = get_rand_int(all_matching_node.size());
    std::pair<string *, int> &selected_matched_node =
        all_matching_node[random_idx];
    string *p_current_query_str = selected_matched_node.first;
    int unique_node_id = selected_matched_node.second;

    /* Reconstruct the IR tree. */
    current_ir_set = parse_query_str_get_ir_set(*p_current_query_str);
    if (current_ir_set.size() <= 0)
      return NULL;
    current_ir_root = current_ir_set.back();

    /* Retrive the required node, deep copy it, clean up the IR tree and return.
     */
    IR *matched_ir_node = current_ir_set[unique_node_id];
    if (matched_ir_node != NULL) {
      if (matched_ir_node->left_->type_ != type_) {
        current_ir_root->deep_drop();
        return NULL;
      }
      // return_matched_ir_node = matched_ir_node->right_->deep_copy();;  // Not
      // returnning the matched_ir_node itself, but its right_ child node!
      return_matched_ir_node = matched_ir_node->right_;
      current_ir_root->detach_node(return_matched_ir_node);
    }

    current_ir_root->deep_drop();

    if (return_matched_ir_node != NULL) {
      // cerr << "\n\n\nSuccessfuly left_type: with string: " <<
      // return_matched_ir_node->to_string() << endl;
      return return_matched_ir_node;
    }
  }

  return NULL;
}

IR *Mutator::get_from_libary_with_right_type(IRTYPE type_) {
  /* Given a right_ type, return a randomly selected prevously seen left_ node
     that share the same parent. If nothing has found, return NULL.
  */

  vector<IR *> current_ir_set;
  IR *current_ir_root;
  vector<pair<string *, int>> &all_matching_node = right_lib_set[type_];
  IR *return_matched_ir_node = NULL;

  if (all_matching_node.size() > 0) {
    /* Pick a random matching node from the library. */
    std::pair<string *, int> &selected_matched_node =
        all_matching_node[get_rand_int(all_matching_node.size())];
    string *p_current_query_str = selected_matched_node.first;
    int unique_node_id = selected_matched_node.second;

    /* Reconstruct the IR tree. */
    current_ir_set = parse_query_str_get_ir_set(*p_current_query_str);
    if (current_ir_set.size() <= 0)
      return NULL;
    current_ir_root = current_ir_set.back();

    /* Retrive the required node, deep copy it, clean up the IR tree and return.
     */
    IR *matched_ir_node = current_ir_set[unique_node_id];
    if (matched_ir_node != NULL) {
      if (matched_ir_node->right_->type_ != type_) {
        current_ir_root->deep_drop();
        return NULL;
      }
      // return_matched_ir_node = matched_ir_node->left_->deep_copy();  // Not
      // returnning the matched_ir_node itself, but its left_ child node!
      return_matched_ir_node = matched_ir_node->left_;
      current_ir_root->detach_node(return_matched_ir_node);
    }

    current_ir_root->deep_drop();

    if (return_matched_ir_node != NULL) {
      // cerr << "\n\n\nSuccessfuly right_type: with string: " <<
      // return_matched_ir_node->to_string() << endl;
      return return_matched_ir_node;
    }
  }

  return NULL;
}
