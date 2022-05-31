#include "../include/mutator.h"
#include "../include/ast.h"
#include "../include/define.h"
#include "../include/utils.h"

#include "../parser/bison_parser.h"
#include "../parser/flex_lexer.h"

#include "../oracle/sqlite_norec.h"
#include "../oracle/sqlite_oracle.h"

#include <sys/resource.h>
#include <sys/time.h>

#include <algorithm>
#include <assert.h>
#include <cfloat>
#include <climits>
#include <cstdio>
#include <deque>
#include <fstream>

using namespace std;

vector<string> Mutator::value_libary;
map<string, vector<string>> Mutator::m_tables;
map<string, vector<string>> Mutator::m_table2index;
map<string, vector<string>> Mutator::m_table2alias;
vector<string> Mutator::v_table_names;

void Mutator::set_dump_library(bool to_dump) { this->dump_library = to_dump; }

IR *Mutator::deep_copy_with_record(const IR *root, const IR *record) {

  IR *left = NULL, *right = NULL, *copy_res;

  if (root->left_)
    left = deep_copy_with_record(root->left_, record);
  if (root->right_)
    right = deep_copy_with_record(root->right_, record);

  if (root->op_ != NULL)
    copy_res = new IR(
        root->type_,
        OP3(root->op_->prefix_, root->op_->middle_, root->op_->suffix_), left,
        right, root->f_val_, root->str_val_, root->name_, root->mutated_times_);
  else
    copy_res = new IR(root->type_, NULL, left, right, root->f_val_,
                      root->str_val_, root->name_, root->mutated_times_);

  copy_res->id_type_ = root->id_type_;

  if (root == record && record != NULL) {
    this->record_ = copy_res;
  }

  return copy_res;
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

vector<string *> Mutator::mutate_all(vector<IR *> &v_ir_collector) {
  vector<string *> res;
  set<unsigned long> res_hash;
  IR *root = v_ir_collector[v_ir_collector.size() - 1];

  p_oracle->mark_all_valid_node(v_ir_collector);

  for (auto old_ir : v_ir_collector) {

    if (old_ir == root || old_ir->type_ == kProgram ||
        old_ir->is_node_struct_fixed)
      continue;

    // cerr << "\n\n\nLooking at ir node: " << ir->to_string() << endl;
    vector<IR *> v_mutated_ir = mutate(old_ir);

    for (auto new_ir : v_mutated_ir) {

      if (!root->swap_node(old_ir, new_ir)) {
        new_ir->deep_drop();
        continue;
      }

      if (!check_node_num(root, 300)) {
        root->swap_node(new_ir, old_ir);
        new_ir->deep_drop();
        continue;
      }

      string tmp = root->to_string();
      unsigned tmp_hash = hash(tmp);
      if (res_hash.find(tmp_hash) != res_hash.end()) {
        root->swap_node(new_ir, old_ir);
        new_ir->deep_drop();
        continue;
      }

      string *new_str = new string(tmp);
      res_hash.insert(tmp_hash);
      res.push_back(new_str);

      root->swap_node(new_ir, old_ir);
      new_ir->deep_drop();
    }
  }

  return res;
}

vector<IR *> Mutator::parse_query_str_get_ir_set(string &query_str) {
  vector<IR *> ir_set;

  auto p_strip_sql = parser(query_str.c_str());
  if (p_strip_sql == NULL)
    return ir_set;

  try {
    auto root_ir = p_strip_sql->translate(ir_set);
  } catch (...) {
    p_strip_sql->deep_delete();

    for (auto ir : ir_set)
      ir->drop();

    ir_set.clear();
    return ir_set;
  }

  int unique_id_for_node = 0;
  for (auto ir : ir_set)
    ir->uniq_id_in_tree_ = unique_id_for_node++;

  p_strip_sql->deep_delete();
  return ir_set;
}

int Mutator::get_ir_libary_2D_hash_kStatement_size() {
  return this->ir_libary_2D_hash_[kStatement].size();
}

void Mutator::init(string f_testcase, string f_common_string, string pragma) {

  ifstream input_test(f_testcase);
  string line;

  // init lib from multiple sql
  while (getline(input_test, line)) {

    vector<IR *> v_ir = parse_query_str_get_ir_set(line);
    if (v_ir.size() <= 0) {
      cerr << "failed to parse: " << line << endl;
      continue;
    }

    string strip_sql = extract_struct(v_ir.back());
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

  // init utils::m_tables
  vector<string> v_tmp = {"haha1", "haha2", "haha3"};
  v_table_names.insert(v_table_names.end(), v_tmp.begin(), v_tmp.end());
  m_tables["haha1"] = {"fuzzing_column0_1", "fuzzing_column1_1",
                       "fuzzing_column2_1"};
  m_tables["haha2"] = {"fuzzing_column0_2", "fuzzing_column1_2",
                       "fuzzing_column2_2"};
  m_tables["haha3"] = {"fuzzing_column0_3", "fuzzing_column1_3",
                       "fuzzing_column2_3"};

  // init value_libary
  vector<string> value_lib_init = {std::to_string(0),
                                   std::to_string((unsigned long)LONG_MAX),
                                   std::to_string((unsigned long)ULONG_MAX),
                                   std::to_string((unsigned long)CHAR_BIT),
                                   std::to_string((unsigned long)SCHAR_MIN),
                                   std::to_string((unsigned long)SCHAR_MAX),
                                   std::to_string((unsigned long)UCHAR_MAX),
                                   std::to_string((unsigned long)CHAR_MIN),
                                   std::to_string((unsigned long)CHAR_MAX),
                                   std::to_string((unsigned long)MB_LEN_MAX),
                                   std::to_string((unsigned long)SHRT_MIN),
                                   std::to_string((unsigned long)INT_MIN),
                                   std::to_string((unsigned long)INT_MAX),
                                   std::to_string((unsigned long)SCHAR_MIN),
                                   std::to_string((unsigned long)SCHAR_MIN),
                                   std::to_string((unsigned long)UINT_MAX),
                                   std::to_string((unsigned long)FLT_MAX),
                                   std::to_string((unsigned long)DBL_MAX),
                                   std::to_string((unsigned long)LDBL_MAX),
                                   std::to_string((unsigned long)FLT_MIN),
                                   std::to_string((unsigned long)DBL_MIN),
                                   std::to_string((unsigned long)LDBL_MIN)};
  value_libary.insert(value_libary.begin(), value_lib_init.begin(),
                      value_lib_init.end());

  string_libary.push_back("x");
  string_libary.push_back("v0");
  string_libary.push_back("v1");

  ifstream input_pragma("./pragma");
  string s;
  cout << "start init pragma" << endl;
  while (getline(input_pragma, s)) {
    if (s.empty())
      continue;
    auto pos = s.find('=');
    if (pos == string::npos)
      continue;

    string k = s.substr(0, pos - 1);
    string v = s.substr(pos + 2);
    if (find(cmds_.begin(), cmds_.end(), k) == cmds_.end())
      cmds_.push_back(k);
    m_cmd_value_lib_[k].push_back(v);
  }

  relationmap[id_table_alias_name] = id_top_table_name;
  relationmap[id_column_name] = id_top_table_name;
  relationmap[id_table_name] = id_top_table_name;
  relationmap[id_index_name] = id_top_table_name;
  relationmap[id_create_column_name] = id_create_table_name;
  relationmap[id_pragma_value] = id_pragma_name;
  relationmap[id_create_index_name] = id_create_table_name;
  cross_map[id_top_table_name] = id_create_table_name;
  relationmap_alternate[id_create_column_name] = id_top_table_name;
  relationmap_alternate[id_create_index_name] = id_top_table_name;
  return;
}

vector<IR *> Mutator::mutate(IR *input) {
  vector<IR *> res;

  // if(!lucky_enough_to_be_mutated(input->mutated_times_)){
  //     return res; // return a empty set if the IR is not mutated
  // }

  res.push_back(strategy_delete(input));
  res.push_back(strategy_insert(input));
  res.push_back(strategy_replace(input));

  // may do some simple filter for res, like removing some duplicated cases

  input->mutated_times_ += res.size();
  for (auto i : res) {
    if (i == NULL)
      continue;
    i->mutated_times_ = input->mutated_times_;
  }
  return res;
}

string Mutator::validate(IR *root) {

  if (root == NULL)
    return "";

  return validate(root->to_string());
}

string Mutator::validate(string query) {

  vector<IR *> ir_set = parse_query_str_get_ir_set(query);
  if (ir_set.size() == 0)
    return "";

  IR *root = ir_set.back();

  reset_counter();
  vector<IR *> ordered_ir;
  // debug(root, 0);
  auto graph = build_dependency_graph(root, relationmap, cross_map, ordered_ir);
  fix_graph(graph, root, ordered_ir);

  string tmp = fix(root);
  root->deep_drop();
  return tmp;
}

// find tree node whose identifier type can be handled
//
// NOTE: identifier type is different from IR type
//
static void collect_ir(IR *root, set<IDTYPE> &type_to_fix,
                       vector<IR *> &ir_to_fix) {
  auto idtype = root->id_type_;

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

static IR *search_mapped_ir(IR *ir, IDTYPE idtype) {
  deque<IR *> to_search = {ir};

  while (to_search.empty() != true) {
    auto node = to_search.front();
    to_search.pop_front();

    if (node->id_type_ == idtype)
      return node;
    ;
    if (node->left_)
      to_search.push_back(node->left_);
    if (node->right_)
      to_search.push_back(node->right_);
  }

  // vector<IR*> to_search;
  // vector<IR*> backup;
  // to_search.push_back(ir);
  // while(!to_search.empty()){
  //    for(auto i: to_search){
  //        if(i->id_type_ == idtype){
  //            return i;
  //        }
  //        if(i->left_){
  //            backup.push_back(i->left_);
  //        }
  //        if(i->right_){
  //            backup.push_back(i->right_);
  //        }
  //    }
  //    to_search = move(backup);
  //    backup.clear();
  //}
  return NULL;
}

// propagate relionship between subqueries. The logic is correct
//
// graph.second relies on graph.first
// crossmap.first relies on crossmap.second
//
// so we should propagate the dependency via
// graph.second -> graph.first = crossmap.first -> crossmap.second
//
void cross_stmt_map(map<IR *, set<IR *>> &graph, vector<IR *> &ir_to_fix,
                    map<IDTYPE, IDTYPE> &cross_map) {
  for (auto m : cross_map) {
    vector<IR *> value;
    vector<IR *> key;

    for (auto &k : graph) {
      if (k.first->id_type_ == m.first) {
        key.push_back(k.first);
      }
    }

    for (auto &k : ir_to_fix) {
      if (k->id_type_ == m.second) {
        value.push_back(k);
      }
    }

    if (key.empty())
      return;
    for (auto val : value) {
      graph[key[get_rand_int(key.size())]].insert(val);
    }
  }
}

// randomly build connection between top_table_name and table_name
//
// top_table_name does not rely on others, while table_name relies on some
// top_table_name
//
void toptable_map(map<IR *, set<IR *>> &graph, vector<IR *> &ir_to_fix,
                  vector<IR *> &toptable) {
  vector<IR *> tablename;
  for (auto ir : ir_to_fix) {
    if (ir->id_type_ == id_table_name) {
      tablename.push_back(ir);
    } else if (ir->id_type_ == id_top_table_name) {
      toptable.push_back(ir);
    }
  }
  if (toptable.empty())
    return;
  for (auto k : tablename) {
    auto r = get_rand_int(toptable.size());
    graph[toptable[r]].insert(k);
  }
}

vector<IR *> Mutator::extract_statement(IR *root) {
  vector<IR *> res;
  deque<IR *> bfs = {root};

  while (bfs.empty() != true) {
    auto node = bfs.front();
    bfs.pop_front();

    if (node->type_ == kStatement)
      res.push_back(node);
    if (node->left_)
      bfs.push_back(node->left_);
    if (node->right_)
      bfs.push_back(node->right_);
  }

  return res;
}

// find all subqueries (SELECT statement)
//
// find all SelectCore subtree, and save them in the returned vector
// save the mapping from the subtree address to subtree into 2nd arg
//
vector<IR *> Mutator::cut_subquery(IR *program, TmpRecord &m_save) {

  vector<IR *> res;
  vector<IR *> v_statements;
  deque<IR *> dfs = {program};

  while (dfs.empty() != true) {
    auto node = dfs.front();
    dfs.pop_front();

    if (node->type_ == kStatement)
      v_statements.push_back(node);
    if (node->left_)
      dfs.push_back(node->left_);
    if (node->right_)
      dfs.push_back(node->right_);
  }

  reverse(v_statements.begin(), v_statements.end());
  for (auto &stmt : v_statements) {
    deque<IR *> q_bfs = {stmt};
    res.push_back(stmt);

    while (!q_bfs.empty()) {
      auto cur = q_bfs.front();
      q_bfs.pop_front();

      if (cur->left_) {
        q_bfs.push_back(cur->left_);
        if (cur->left_->type_ == kSelectCore) {
          res.push_back(cur->left_);
          m_save[cur] = make_pair(0, cur->left_);
          cur->detach_node(cur->left_);
        }
      }

      if (cur->right_) {
        q_bfs.push_back(cur->right_);
        if (cur->right_->type_ == kSelectCore) {
          res.push_back(cur->right_);
          m_save[cur] = make_pair(1, cur->right_);
          cur->detach_node(cur->right_);
        }
      }
    }
  }
  return res;
}

bool Mutator::add_back(TmpRecord &m_save) {

  for (auto &i : m_save) {

    IR *parent = i.first;
    int is_right = i.second.first;
    IR *child = i.second.second;

    if (is_right)
      parent->update_right(child);
    else
      parent->update_left(child);
  }

  return true;
}

// build the dependency graph between names, for example, the column name
// should belong to one column of one already created table. The dependency
// is denfined in the "relationmap" global variable
//
// The result is a map, where the value is a set of IRs, which are dependents
// of the key
map<IR *, set<IR *>>
Mutator::build_dependency_graph(IR *root, map<IDTYPE, IDTYPE> &relationmap,
                                map<IDTYPE, IDTYPE> &cross_map,
                                vector<IR *> &ordered_ir) {

  map<IR *, set<IR *>> graph;
  TmpRecord m_save;
  set<IDTYPE> type_to_fix;

  for (auto &iter : relationmap) {
    type_to_fix.insert(iter.first);
    type_to_fix.insert(iter.second);
  }

  for (auto &iter : relationmap_alternate) {
    type_to_fix.insert(iter.first);
    type_to_fix.insert(iter.second);
  }

  vector<IR *> subqueries = cut_subquery(root, m_save);

  // cout << subqueries.size() << endl;

  for (IR *subquery : subqueries) {

    // cout << "subquery" << endl;
    // debug(subquery, 0);

    vector<IR *> ir_to_fix;
    collect_ir(subquery, type_to_fix, ir_to_fix);
    for (auto ii : ir_to_fix) {
      ordered_ir.push_back(ii);
    }
    cross_stmt_map(graph, ir_to_fix, cross_map);
    vector<IR *> v_top_table;
    toptable_map(graph, ir_to_fix, v_top_table);

    // cout << "size of ir_to_fix: " << ir_to_fix.size() << endl;

    for (auto ir : ir_to_fix) {

      auto idtype = ir->id_type_;

      // set.empty() returns whether the set is empty,
      // but the result is not used here
      // graph[ir].empty();

      if (relationmap.find(idtype) == relationmap.end()) {
        continue;
      }

      auto curptr = ir;
      bool flag = false;

      while (true) {

        IR *pptr = subquery->locate_parent(curptr);
        if (pptr == NULL)
          break;

        while (pptr->left_ == NULL || pptr->right_ == NULL) {
          curptr = pptr;
          pptr = subquery->locate_parent(curptr);
          if (pptr == NULL) {
            flag = true;
            break;
          }
        }
        if (flag)
          break;

        auto to_search_child = pptr->left_;
        if (pptr->left_ == curptr) {
          to_search_child = pptr->right_;
        }

        auto match_ir = search_mapped_ir(to_search_child, relationmap[idtype]);

        if (match_ir == NULL &&
            relationmap_alternate.find(idtype) != relationmap_alternate.end())
          match_ir =
              search_mapped_ir(to_search_child, relationmap_alternate[idtype]);

        if (match_ir != NULL) {
          if (ir->type_ == kColumnName && ir->left_ != NULL) {
            if (v_top_table.size() > 0)
              match_ir = v_top_table[get_rand_int(v_top_table.size())];
            graph[match_ir].insert(ir->left_);
            if (ir->right_) {
              graph[match_ir].insert(ir->right_);
              ir->left_->id_type_ = id_table_name;
              ir->right_->id_type_ = id_column_name;
              ir->id_type_ = id_whatever;
            }
          } else {
            // cout << "graph: " << endl;
            // debug(match_ir, 0);
            // debug(ir, 0);
            // cout << endl << endl;
            graph[match_ir].insert(ir);
          }
          break;
        }
        curptr = pptr;
      }
    }
  }

  add_back(m_save);
  return graph;
}

IR *Mutator::strategy_delete(IR *cur) {
  assert(cur);
  MUTATESTART

  DOLEFT
  res = cur->deep_copy();
  if (res->left_ != NULL)
    res->left_->deep_drop();
  res->update_left(NULL);

  DORIGHT
  res = cur->deep_copy();
  if (res->right_ != NULL)
    res->right_->deep_drop();
  res->update_right(NULL);

  DOBOTH
  res = cur->deep_copy();
  if (res->left_ != NULL)
    res->left_->deep_drop();
  if (res->right_ != NULL)
    res->right_->deep_drop();
  res->update_left(NULL);
  res->update_right(NULL);

  MUTATEEND
}

IR *Mutator::strategy_insert(IR *cur) {

  assert(cur);

  if (cur->type_ == kStatementList) {
    auto new_right = get_from_libary_with_left_type(cur->type_);
    if (new_right != NULL) {
      auto res = cur->deep_copy();
      auto new_res = new IR(kStatementList, OPMID(";"), res, new_right);
      return new_res;
    }
  }

  if (cur->right_ == NULL && cur->left_ != NULL) {
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
  res = cur->deep_copy();
  if (res->left_ == NULL)
    break;

  auto new_node = get_from_libary_with_type(res->left_->type_);

  if (new_node != NULL) {
    if (res->left_ != NULL) {
      new_node->id_type_ = res->left_->id_type_;
    }
  }
  if (res->left_ != NULL)
    res->left_->deep_drop();
  res->update_left(new_node);

  DORIGHT
  res = cur->deep_copy();
  if (res->right_ == NULL)
    break;

  auto new_node = get_from_libary_with_type(res->right_->type_);
  if (new_node != NULL) {
    if (res->right_ != NULL) {
      new_node->id_type_ = res->right_->id_type_;
    }
  }
  if (res->right_ != NULL)
    res->right_->deep_drop();
  res->update_right(new_node);

  DOBOTH
  res = cur->deep_copy();
  if (res->left_ == NULL || res->right_ == NULL)
    break;

  auto new_left = get_from_libary_with_type(res->left_->type_);
  auto new_right = get_from_libary_with_type(res->right_->type_);

  if (new_left != NULL) {
    if (res->left_ != NULL) {
      new_left->id_type_ = res->left_->id_type_;
    }
  }

  if (new_right != NULL) {
    if (res->right_ != NULL) {
      new_right->id_type_ = res->right_->id_type_;
    }
  }

  if (res->left_)
    res->left_->deep_drop();
  if (res->right_)
    res->right_->deep_drop();
  res->update_left(new_left);
  res->update_right(new_right);

  MUTATEEND

  return res;
}

bool Mutator::lucky_enough_to_be_mutated(unsigned int mutated_times) {
  if (get_rand_int(mutated_times + 1) < LUCKY_NUMBER) {
    return true;
  }
  return false;
}

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

unsigned long Mutator::get_library_size() {
  unsigned long res = 0;

  for (auto &i : real_ir_set) {
    res += 1;
  }

  for (auto &i : left_lib_set) {
    res += 1;
  }

  for (auto &i : right_lib_set) {
    res += 1;
  }

  return res;
}

bool Mutator::is_stripped_str_in_lib(string stripped_str) {
  stripped_str = extract_struct(stripped_str);
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

    if (p_oracle->is_oracle_valid_stmt(current_query)) {
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

  if (is_explain_diff && use_cri_val)
    all_cri_valid_pstr_vec.push_back(new_select);

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

  unsigned long p_hash = hash(ir->to_string());
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

void Mutator::get_memory_usage() {

  static unsigned long old_use = 0;

  std::ofstream f;
  // f.rdbuf()->pubsetbuf(0, 0);
  f.open("./memlog.txt", std::ofstream::out | std::ofstream::app);

  struct rusage usage;
  getrusage(RUSAGE_SELF, &usage);

  unsigned long use = usage.ru_maxrss * 1024;

  // if (use - old_use < 1024 * 1024)
  //   return;

  f << "-------------------------------------\n";
  f << "memory use:  " << use << "\n";
  old_use = use;

  unsigned long total_size = 0;

  // unsigned long size_2D_hash = 0;
  // for (auto &i : ir_libary_2D_hash_)
  //   size_2D_hash += i.second.size() * 8;
  // f << "2D hash size:" << size_2D_hash
  //      << "\t - " << size_2D_hash * 1.0 / use << "\n";
  // total_size += size_2D_hash;

  // unsigned long size_2D = 0;
  // for(auto &i: ir_libary_2D_)
  //   size_2D += i.second.size() * 8;
  // f << "2D size:     " << size_2D
  //      << "\t - " << size_2D * 1.0 / use << "\n";
  // total_size += size_2D;

  // unsigned long size_left = 0;
  // for(auto &i: left_lib)
  //   size_left += i.second.size() * 8;;
  // f << "left size:   " << size_left
  //      << "\t - " << size_left * 1.0 / use << "\n";
  // total_size += size_left;

  // unsigned long size_right = 0;
  // for(auto &i: right_lib)
  //   size_right += i.second.size();
  // f << "right size:  " << size_right
  //      << "\t - " << size_right * 1.0 / use << "\n";
  // total_size += size_right;

  unsigned long size_value = 0;
  size_value += value_libary.size() * 8;
  f << "value size:   " << size_value << "\t - " << size_value * 1.0 / use
    << "\n";
  total_size += size_value;

  unsigned long size_m_tables = 0;
  for (auto &i : m_tables)
    for (auto &j : i.second)
      size_m_tables += j.capacity();
  ;
  f << "m_tables size:" << size_m_tables << "\t - " << size_m_tables * 1.0 / use
    << "\n";
  total_size += size_m_tables;

  unsigned long size_v_table_names = 0;
  for (auto &i : v_table_names)
    size_v_table_names += i.capacity();
  ;
  f << "v_tbl size:   " << size_v_table_names << "\t - "
    << size_v_table_names * 1.0 / use << "\n";
  total_size += size_v_table_names;

  unsigned long size_string_libary = 0;
  for (auto &i : string_libary)
    size_string_libary += i.capacity();
  f << "str lib size :" << size_string_libary << "\t - "
    << size_string_libary * 1.0 / use << "\n";
  total_size += size_string_libary;

  unsigned long size_real_ir_set_str_libary = 0;
  for (auto i : all_query_pstr_set)
    size_real_ir_set_str_libary += i->capacity();
  f << "all_saved_query_str size :" << size_real_ir_set_str_libary << "\t - "
    << size_real_ir_set_str_libary * 1.0 / use << "\n";
  total_size += size_real_ir_set_str_libary;

  f << "total size:  " << total_size << "\t - " << total_size * 1.0 / use
    << "\n";

  f.close();
}

unsigned long Mutator::hash(string sql) {
  return fuzzing_hash(sql.c_str(), sql.size());
}

unsigned long Mutator::hash(IR *root) { return this->hash(root->to_string()); }

void Mutator::debug(IR *root, unsigned level) {

  for (unsigned i = 0; i < level; i++)
    cout << " ";

  cout << get_string_by_ir_type(root->type_) << ": "
       << get_string_by_id_type(root->id_type_) << endl;

  if (root->left_)
    debug(root->left_, level + 1);
  if (root->right_)
    debug(root->right_, level + 1);
}

Mutator::~Mutator() {
  cout << "HERE" << endl;

  for (auto iter : all_query_pstr_set) {
    delete iter;
  }
}

void Mutator::fix_one(map<IR *, set<IR *>> &graph, IR *fixed_key,
                      set<IR *> &visited) {
  if (fixed_key->id_type_ == id_create_table_name) {
    string tablename = fixed_key->str_val_;
    auto &colums = m_tables[tablename];
    auto &indices = m_table2index[tablename];
    for (auto &val : graph[fixed_key]) {
      if (val->id_type_ == id_create_column_name) {
        string new_column = gen_id_name();
        colums.push_back(new_column);
        val->str_val_ = new_column;
        visited.insert(val);
      } else if (val->id_type_ == id_top_table_name) {
        val->str_val_ = tablename;
        visited.insert(val);
        fix_one(graph, val, visited);
      }
    }
  } else if (fixed_key->id_type_ == id_top_table_name) {
    string tablename = fixed_key->str_val_;
    auto &colums = m_tables[tablename];
    auto &indices = m_table2index[tablename];
    auto &alias= m_table2alias[tablename];

    for (auto &val : graph[fixed_key]) {

      switch (val->id_type_) {
      case id_table_alias_name: {
        string new_alias = gen_alias_name();
        alias.push_back(new_alias);
        val->str_val_ = new_alias;
        visited.insert(val);
        break;
      }
      default: break;
      }

    }

    for (auto &val : graph[fixed_key]) {

      switch (val->id_type_) {

      case id_column_name: {
        // We created alias for every table name. So when we get top column name
        // from mappings, we need to prepend the corresponding alias to the
        // column name. for example:
        //  CREATE TABLE v0 ( v1 INT );
        //  SELECT * FROM v0 AS A, v0 AS B WHERE v1 = 1337;
        // we need to generate prepend 'A' or 'B' to 'v1' to avoid ambiguous
        // name.

        val->str_val_ = vector_rand_ele(colums);

        string table_name_with_alias = fixed_key->parent_->parent_->to_string();
        string as_token_delim = "AS ";
        size_t found = table_name_with_alias.find(as_token_delim);

        if (found != string::npos) {
          string table_name_alias = table_name_with_alias.substr(
              found + as_token_delim.size());
          val->str_val_ = table_name_alias + "." + val->str_val_;
        }

        visited.insert(val);
        break;
      }

      case id_table_name: {
        val->str_val_ = tablename;
        visited.insert(val);
        break;
      }

      case id_create_index_name: {
        string new_index = gen_id_name();
        // cout << "index name: " << new_index << endl;
        indices.push_back(new_index);
        val->str_val_ = new_index;
        visited.insert(val);
        break;
      }

      case id_create_column_name: {
        string new_column = gen_id_name();
        colums.push_back(new_column);
        val->str_val_ = new_column;
        visited.insert(val);
        break;
      }
      }
    }
  }
}

//    relationmap[id_column_name] = id_top_table_name;
//    relationmap[id_table_name] = id_top_table_name;
//    relationmap[id_index_name] = id_top_table_name;
//    relationmap[id_create_column_name] = id_create_table_name;
//    relationmap[id_pragma_value] = id_pragma_name;
//
void Mutator::fix_graph(map<IR *, set<IR *>> &graph, IR *root,
                        vector<IR *> &ordered_ir) {
  set<IR *> visited;

  reset_database();
  for (auto ir : ordered_ir) {

    if (visited.find(ir) != visited.end())
      continue;
    visited.insert(ir);

    auto dependencies = graph[ir];
    if (dependencies.empty()) {

      if (ir->id_type_ == id_column_name) {

        // there are two possibllity we visit the column_name node first:
        //
        // 1. this is a standalone column_name -- it does not depend on others
        //    in this case, likely wrong mutate, just allocate random name
        //
        // 2. we will find its dependecies later, like top_table_name, etc
        //    in this case, we can skip the assignment, but it does not hurt
        //    even if we assign it some value as it will be anyway overwritten
        //
        string tablename = vector_rand_ele(v_table_names);
        // cout << "tablename: " << tablename << endl;
        auto &colums = m_tables[tablename];
        ir->str_val_ = vector_rand_ele(colums);
        // cout << "column name: " << ir->str_val_ << endl;
        continue;
      }
    }

    switch (ir->id_type_) {

    case id_create_table_name:

      ir->str_val_ = gen_id_name();
      v_table_names.push_back(ir->str_val_);
      // cout << "create_table_name: " << ir->str_val_ << endl;
      fix_one(graph, ir, visited);
      break;

    case id_top_table_name:

      ir->str_val_ = vector_rand_ele(v_table_names);
      // cout << "top_table_name: " << ir->str_val_ << endl;
      fix_one(graph, ir, visited);
      break;

    case id_index_name:

      // FIXME: handle index name
      // cout << "id_index_name: " << endl;
      break;

    default:

      // cerr << ir->id_type_ << endl;
      // cerr << "this: " << ir->to_string() << endl;

      // if (ir->get_parent()) {
      //  cerr << "parent: " << ir->get_parent()->to_string() << endl;

      //  if (ir->get_parent()->get_parent()) {
      //    cerr << "p parent: " << ir->get_parent()->get_parent()->to_string()
      //    << endl;

      //    if (ir->get_root())
      //      cerr << "root: " << ir->get_root()->to_string() << endl;
      //  }
      //}
      break;
    }
  }
}

/* tranverse ir in the order: _right ==> root ==> left_ */

string Mutator::fix(IR *root) {

  string res = "";
  _fix(root, res);
  trim_string(res);
  return res;
}

void Mutator::_fix(IR *root, string &res) {

  auto *right_ = root->right_, *left_ = root->left_;
  auto *op_ = root->op_;
  auto type_ = root->type_;
  auto str_val_ = root->str_val_;
  auto f_val_ = root->f_val_;
  auto int_val_ = root->int_val_;
  auto id_type_ = root->id_type_;

  if (type_ == kIdentifier && id_type_ == id_database_name) {

    res += "main";
    return;
  }

  if (type_ == kIdentifier && id_type_ == id_schema_name) {

    res += "sqlite_master";
    return;
  }

  if (type_ == kPragmaStatement) {

    string key = "";
    int lib_size = cmds_.size();
    if (lib_size != 0) {
      key = cmds_[get_rand_int(lib_size)];
      res += ("PRAGMA " + key);
    } else
      return;

    int value_size = m_cmd_value_lib_[key].size();
    string value = m_cmd_value_lib_[key][get_rand_int(value_size)];
    if (!value.compare("_int_")) {
      value = string("=") + value_libary[get_rand_int(value_libary.size())];
    } else if (!value.compare("_empty_")) {
      value = "";
    } else if (!value.compare("_boolean_")) {
      if (get_rand_int(2) == 0)
        value = "=false";
      else
        value = "=true";
    } else {
      value = "=" + value;
    }
    if (!value.empty())
      res += value + ";";
    return;
  }

  if (type_ == kFilePath || type_ == kOptOrderType || type_ == kColumnType ||
      type_ == kSetOperator || type_ == kOptJoinType || type_ == kOptDistinct ||
      type_ == kNullLiteral) {
    res += str_val_;
    return;
  }

  if (type_ == kStringLiteral) {
    auto s = string_libary[get_rand_int(string_libary.size())];
    res += "'" + s + "'";
    return;
  }

  if (type_ == kNumericLiteral) {
    res += value_libary[get_rand_int(value_libary.size())];
    return;
  }

  if (type_ == kconst_str) {
    res += string_libary[get_rand_int(string_libary.size())];
    return;
  }

  if (!str_val_.empty()) {
    res += str_val_;
    return;
  }

  if (op_ != NULL)
    res += op_->prefix_ + " ";

  if (left_ != NULL) {
    _fix(left_, res);
    res += " ";
  }

  if (op_ != NULL)
    res += op_->middle_ + " ";

  if (right_ != NULL) {
    _fix(right_, res);
    res += " ";
  }

  if (op_ != NULL)
    res += op_->suffix_;

  return;
}

unsigned int Mutator::calc_node(IR *root) {
  unsigned int res = 0;
  if (root->left_)
    res += calc_node(root->left_);
  if (root->right_)
    res += calc_node(root->right_);

  return res + 1;
}

string Mutator::extract_struct(string query) {

  vector<IR *> original_ir_tree = parse_query_str_get_ir_set(query);

  string res = "";

  if (original_ir_tree.size() > 0) {

    IR *root = original_ir_tree[original_ir_tree.size() - 1];
    res = extract_struct(root);
    root->deep_drop();
  }

  return res;
}

string Mutator::extract_struct(IR *root) {

  string res = "";
  _extract_struct(root, res);
  trim_string(res);
  return res;
}

void Mutator::_extract_struct(IR *root, string &res) {

  static int counter = 0;
  auto *right_ = root->right_, *left_ = root->left_;
  auto *op_ = root->op_;
  auto type_ = root->type_;
  auto str_val_ = root->str_val_;

  if (type_ == kColumnName && str_val_ == "*") {
    res += str_val_;
    return;
  }

  if (type_ == kOptOrderType || type_ == kNullLiteral || type_ == kColumnType ||
      type_ == kSetOperator || type_ == kOptJoinType || type_ == kOptDistinct) {
    res += str_val_;
    return;
  }

  if (root->id_type_ != id_whatever && root->id_type_ != id_module_name) {
    res += "x";
    return;
  }

  if (type_ == kStringLiteral) {
    string str_val = str_val_;
    str_val.erase(std::remove(str_val.begin(), str_val.end(), '\''),
                  str_val.end());
    str_val.erase(std::remove(str_val.begin(), str_val.end(), '"'),
                  str_val.end());
    string magic_string = magic_string_generator(str_val);
    unsigned long h = hash(magic_string);
    if (string_libary_hash_.find(h) == string_libary_hash_.end()) {

      string_libary.push_back(magic_string);
      string_libary_hash_.insert(h);
    }
    res += "'y'";
    return;
  }

  if (type_ == kNumericLiteral) {
    unsigned long h = hash(root->str_val_);
    if (value_library_hash_.find(h) == value_library_hash_.end()) {
      value_libary.push_back(root->str_val_);
    }
    res += "10";
    return;
  }

  if (type_ == kFilePath) {
    res += "'file_name'";
    return;
  }

  if (!str_val_.empty()) {
    res += str_val_;
    return;
  }

  if (op_ != NULL)
    res += op_->prefix_ + " ";

  if (left_ != NULL) {
    _extract_struct(left_, res);
    res += " ";
  }

  if (op_ != NULL)
    res += op_->middle_ + " ";

  if (right_ != NULL) {
    _extract_struct(right_, res);
    res += " ";
  }

  if (op_ != NULL)
    res += op_->suffix_;

  return;
}

void Mutator::add_new_table(IR *root, string &table_name) {

  if (root->left_ != NULL)
    add_new_table(root->left_, table_name);

  if (root->right_ != NULL)
    add_new_table(root->right_, table_name);

  // add to table_name_lib_
  if (root->type_ == kTableName) {
    if (root->operand_num_ == 1) {
      table_name = root->left_->str_val_;
    } else if (root->operand_num_ == 2) {
      table_name = root->left_->str_val_ + "." + root->right_->str_val_;
    }
  }

  // add to column_name_lib_
  if (root->type_ == kColumnDef) {
    auto tmp = root->left_;
    if (tmp->type_ == kIdentifier) {
      if (!table_name.empty() && !tmp->str_val_.empty())
        ;
      m_tables[table_name].push_back(tmp->str_val_);
      if (find(v_table_names.begin(), v_table_names.end(), table_name) !=
          v_table_names.end())
        v_table_names.push_back(table_name);
    }
  }
}

void Mutator::reset_database() {
  m_tables.clear();
  v_table_names.clear();
}

int Mutator::try_fix(char *buf, int len, char *&new_buf, int &new_len) {

  auto ast = parser(buf);

  new_buf = buf;
  new_len = len;
  if (ast == NULL)
    return 0;

  vector<IR *> v_ir;
  auto ir_root = ast->translate(v_ir);
  ast->deep_delete();

  if (ir_root == NULL)
    return 0;
  auto fixed = validate(ir_root);
  ir_root->deep_drop();
  if (fixed.empty())
    return 0;

  char *sfixed = (char *)malloc(fixed.size() + 1);
  memcpy(sfixed, fixed.c_str(), fixed.size());
  sfixed[fixed.size()] = 0;

  new_buf = sfixed;
  new_len = fixed.size();

  return 1;
}

int Mutator::get_cri_valid_collection_size() {
  return all_cri_valid_pstr_vec.size();
}

int Mutator::get_valid_collection_size() { return all_valid_pstr_vec.size(); }

Program *Mutator::parser(const char *sql) {

  yyscan_t scanner;
  YY_BUFFER_STATE state;
  Program *p = new Program();

  if (hsql_lex_init(&scanner)) {
    return NULL;
  }
  state = hsql__scan_string(sql, scanner);

  int ret = hsql_parse(p, scanner);

  hsql__delete_buffer(state, scanner);
  hsql_lex_destroy(scanner);
  if (ret != 0) {
    p->deep_delete();
    return NULL;
  }

  return p;
}

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
      if (use_cri_val && all_cri_valid_pstr_vec.size() > 0 &&
          get_rand_int(3) < 2) {
        ori_norec_select = *(all_cri_valid_pstr_vec[get_rand_int(
            all_cri_valid_pstr_vec.size())]);
      } else {
        ori_norec_select =
            *(all_valid_pstr_vec[get_rand_int(all_valid_pstr_vec.size())]);
      }
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
