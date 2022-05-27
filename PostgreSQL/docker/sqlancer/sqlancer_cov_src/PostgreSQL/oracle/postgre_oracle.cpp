#include "./postgre_oracle.h"
#include "../include/ast.h"
#include "../AFL/debug.h"

bool SQL_ORACLE::mark_node_valid(IR *root) {
  if (root == nullptr)
    return false;
  /* the following types do not added to the norec_select_stmt list. They should
   * be able to mutate as usual. */
  if (// root->type_ == kNewExpr || root->type_ == kTableOrSubquery ||
      root->type_ == kOptGroupClause || root->type_ == kWindowClause)
    return false;
  root->is_node_struct_fixed = true;
  if (root->left_ != nullptr)
    this->mark_node_valid(root->left_);
  if (root->right_ != nullptr)
    this->mark_node_valid(root->right_);
  return true;
}

void SQL_ORACLE::set_mutator(Mutator *mutator) { this->g_mutator = mutator; }

// TODO:: This function is a bit too long.
// guarantee to generate grammarly correct query
IR* SQL_ORACLE::get_random_mutated_valid_stmt() {
  /* Read from the previously seen norec compatible select stmt.
   * SELECT COUNT ( * ) FROM ... WHERE ...; mutate them, and then return the
   string of the new generated norec compatible SELECT query.
  */
  bool is_success = false;
  vector<IR *> ir_tree;
  IR *root = NULL;
  string new_valid_select_str = "";

  total_rand_valid += 1;
  bool use_temp = false;

  while (!is_success) {

    string ori_valid_select = "";
    use_temp = g_mutator->get_valid_str_from_lib(ori_valid_select);

    // cerr << "Inside the loop \n\n\n";

    ir_tree.clear();
    ir_tree = g_mutator->parse_query_str_get_ir_set(ori_valid_select);

    if (ir_tree.size() == 0) {
      cerr << "Error: string: " << ori_valid_select << "parsing failed in Func: SQL_ORACLE::get_random_mutated_valid_stmt. \n\n\n";
      continue;
    }

    if (ir_tree.back()->left_ == nullptr || ir_tree.back()->left_->left_ == nullptr || ir_tree.back()->left_->left_->left_ == nullptr)
      {
        cerr << "Error: ir_tree.back()->left_->left_->left_ is NULL in Func: SQL_ORACLE::get_random_mutated_valid_stmt. \n\n\n";
        continue;
      }
    // kProgram -> kStatementList -> kStatement -> specific_statement_type_
    IR *cur_ir_stmt = ir_tree.back()->left_->left_->left_;

    if (!this->is_oracle_select_stmt(cur_ir_stmt))
      {
        cerr << "Error: cur_ir_stmt is not oracle statement. cur_ir_stmt->to_stirng(): "<<  cur_ir_stmt->to_string() << "  In func: SQL_ORACLE::get_random_mutated_valid_stmt. \n\n\n";
        continue;
      }

    root = ir_tree.back();
    if (!g_mutator->check_node_num(root, 400)) {
      /* The retrived norec stmt is too complicated to mutate, directly return
       * the retrived query. */
      // this->ir_wrapper.set_ir_root(root);
      // IR* returned_stmt_ir = ir_wrapper.get_stmt_ir_vec()[0]->deep_copy();
      // root->deep_drop();
      // cerr << "Successfully return: " << returned_stmt_ir << "\n\n\n";
      IR* returned_stmt_ir = cur_ir_stmt -> deep_copy();
      root->deep_drop();
      return returned_stmt_ir;
    }

    /* If we are using a non template valid stmt from the p_oracle lib:
     *  2/3 of chances to return the stmt immediate without mutation.
     *  1/3 of chances to return with further mutation.
     */
    // cout << "ori_valid_select: " << ori_valid_select << endl;
    if (!use_temp && get_rand_int(3) < 2) {
      // this->ir_wrapper.set_ir_root(root);
      // IR* returned_stmt_ir = ir_wrapper.get_stmt_ir_vec()[0]->deep_copy();
      // root->deep_drop();
      IR* returned_stmt_ir = cur_ir_stmt -> deep_copy();
      root->deep_drop();
      // cerr << "Successfully return: " << returned_stmt_ir << "\n\n\n";
      return returned_stmt_ir;
    }

    /* Restrict changes on the signiture norec select components. Could increase
     * mutation efficiency. */
    mark_all_valid_node(ir_tree);

    // cout << "root: " << root->to_string()  << endl;

    string ori_valid_select_struct = g_mutator->extract_struct(root);
    string new_valid_select_struct = "";

    /* For every retrived norec stmt, and its parsed IR tree, give it 100 trials
     * to mutate.
     */
    for (int trial_count = 0; trial_count < 30; trial_count++) {

      /* Pick random ir node in the select stmt */
      bool is_mutate_ir_node_chosen = false;
      IR *mutate_ir_node = NULL;
      IR *new_mutated_ir_node = NULL;
      int choose_node_trial = 0;
      while (!is_mutate_ir_node_chosen) {
        if (choose_node_trial > 100)
          break;
        choose_node_trial++;
        mutate_ir_node = ir_tree[get_rand_int(
            ir_tree.size() - 1)]; // Do not choose the program_root to mutate.
        if (mutate_ir_node == NULL) {
          // cerr << "chosen mutate_ir_node is NULL\n\n\n";
          continue; 
        }
        if (mutate_ir_node->is_node_struct_fixed) {
          // cerr << "node strcut is fixed. \n\n\n";
          continue;
        }
        is_mutate_ir_node_chosen = true;
        break;
      }

      if (!is_mutate_ir_node_chosen)
        break; // The current ir tree cannot even find the node to mutate.
               // Ignored and retrive new norec stmt from lib or from library.
      // cout << "\n################################" << endl;
      // cout << "before_strategy: " << root->to_string() << endl;
      /* Pick random mutation methods. */
      // cerr << "The chosen IR node type_: " << mutate_ir_node->type_ << "  string: " << mutate_ir_node->to_string() << "\n\n\n";
      switch (get_rand_int(3)) {
      // switch (1) {
      case 0: {
        
        new_mutated_ir_node = g_mutator->strategy_delete(mutate_ir_node);
        // if (new_mutated_ir_node!=NULL) 
        //   cout << "strategy_delete: " << new_mutated_ir_node->to_string() << endl;
        
        break;
      }
      case 1:{
        new_mutated_ir_node = g_mutator->strategy_insert(mutate_ir_node);
        // if (new_mutated_ir_node!=NULL) 
        //   cout << "strategy_insert: " << new_mutated_ir_node->to_string() << endl;
        
        break;
      }
      case 2: {
        new_mutated_ir_node = g_mutator->strategy_replace(mutate_ir_node);
        // if (new_mutated_ir_node!=NULL) 
        //   cout << "strategy_replace: " << new_mutated_ir_node->to_string() << endl;
        break;
      }
      }

      if (new_mutated_ir_node==NULL) {
        // cerr << "new_mutated_ir_node is NULL\n\n\n";
        continue;
      }

      if (!root->swap_node(mutate_ir_node, new_mutated_ir_node)) {
        new_mutated_ir_node->deep_drop();
        // cerr << "swap node to new_mutated_ir_node failure. \n";
        continue;
      }
      // cout << "mutated query: " <<  root->to_string() << endl;
      // cout << "################################" << endl;
      // exit(0);

      new_valid_select_str = root->to_string();

      if (new_valid_select_str != ori_valid_select) {
        new_valid_select_struct = g_mutator->extract_struct(root);
      }

      root->swap_node(new_mutated_ir_node, mutate_ir_node);
      // cout << "new query: "<<  new_valid_select_str << endl;
      // cout << "ori query: " << root->to_string() << endl;
      new_mutated_ir_node->deep_drop();
      if (new_valid_select_str == ori_valid_select) {
        // cerr << "Mutated string is the same as before. \n";
        continue;
      }

      /* Final check and return string if compatible */
      vector<IR *> new_ir_verified =
          g_mutator->parse_query_str_get_ir_set(new_valid_select_str);
      

      if (new_ir_verified.size() <= 0) {
        // cerr << "new_ir_verified cannot pass the parser: ";
        continue;
      }

      // Make sure the mutated structure is different.
      // kProgram -> kStatementList -> kStatement -> specific_statement_type_
      IR* new_ir_verified_stmt = new_ir_verified.back()->left_->left_->left_; 
      if (this->is_oracle_select_stmt(new_ir_verified_stmt) && new_valid_select_struct != ori_valid_select_struct) {
        root->deep_drop();
        is_success = true;

        if (use_temp)
          total_temp++;
        
        IR* returned_stmt_ir = new_ir_verified_stmt->deep_copy();
        new_ir_verified.back()->deep_drop();
        // cerr << "ori_valid_select is: " << ori_valid_select << "\n";
        // cerr << "Successfully return: " << returned_stmt_ir->to_string() << "\n\n\n";
        return returned_stmt_ir;
      }
      else {
        // cerr << "Mutated query is not the same as before. Or mutation doesn't change the query. \n\n\n";
        new_ir_verified.back()->deep_drop();
      }

      continue; // Retry mutating the current norec stmt and its IR tree.
    }

    /* Failed to mutate the retrived norec select stmt after 100 trials.
     * Maybe it is because the norec select stmt is too complex the mutate.
     * Grab another norec select stmt from the lib or from the template, try
     * again.
     */
    root->deep_drop();
    root = NULL;
  }
  FATAL("Unexpected code execution in '%s'", "SQL_ORACLE::get_random_mutated_valid_stmt()");
  return nullptr;
}

int SQL_ORACLE::count_oracle_select_stmts(IR* ir_root) {
  ir_wrapper.set_ir_root(ir_root);
  vector<IR*> stmt_vec = ir_wrapper.get_stmt_ir_vec();

  int oracle_stmt_num = 0;
  for (IR* cur_stmt : stmt_vec){
    if (this->is_oracle_select_stmt(cur_stmt)) {oracle_stmt_num++;}
  }
  return oracle_stmt_num;
}

int SQL_ORACLE::count_oracle_normal_stmts(IR* ir_root) {
  ir_wrapper.set_ir_root(ir_root);
  vector<IR*> stmt_vec = ir_wrapper.get_stmt_ir_vec();

  int oracle_stmt_num = 0;
  for (IR* cur_stmt : stmt_vec){
    if (this->is_oracle_normal_stmt(cur_stmt)) {oracle_stmt_num++;}
  }
  return oracle_stmt_num;
}

bool SQL_ORACLE::is_oracle_select_stmt(IR* cur_IR){
  if (ir_wrapper.is_exist_ir_node_in_stmt_with_type(cur_IR, kSelectStmt, false)) {
    return true;
  }
  return false;
}

void SQL_ORACLE::remove_select_stmt_from_ir(IR* ir_root) {
  vector<IR*> stmt_vec = ir_wrapper.get_stmt_ir_vec(ir_root);
  for (IR* cur_stmt : stmt_vec) {
    if (cur_stmt->type_ == kSelectStmt) {
      ir_wrapper.remove_stmt_and_free(cur_stmt);
    }
  }
  return;
}

void SQL_ORACLE::remove_oracle_select_stmt_from_ir(IR* ir_root) {
  vector<IR*> stmt_vec = ir_wrapper.get_stmt_ir_vec(ir_root);
  for (IR* cur_stmt : stmt_vec) {
    if (this->is_oracle_select_stmt(cur_stmt)) {
      ir_wrapper.remove_stmt_and_free(cur_stmt);
    }
  }
  return;
}