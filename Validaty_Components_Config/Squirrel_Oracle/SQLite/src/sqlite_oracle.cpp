#include "../include/sqlite_oracle.h"
#include "../include/ast.h"

bool SQL_ORACLE::mark_node_valid(IR *root) {
  return true;
}

void SQL_ORACLE::set_mutator(Mutator *mutator) { this->g_mutator = mutator; }

// TODO:: This function is a bit too long.
// guarantee to generate grammarly correct query
string SQL_ORACLE::get_random_mutated_valid_stmt() {
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
    /* If we are using a non template valid stmt from the p_oracle lib:
     *  2/3 of chances to return the stmt immediate without mutation.
     *  1/3 of chances to return with further mutation.
     */
    if (!use_temp && get_rand_int(3) < 2) {
      return ori_valid_select;
    }

    ir_tree.clear();
    ir_tree = g_mutator->parse_query_str_get_ir_set(ori_valid_select);
    if (ir_tree.size() == 0)
      continue;

    root = ir_tree.back();
    if (!g_mutator->check_node_num(root, 300)) {
      /* The retrived norec stmt is too complicated to mutate, directly return
       * the retrived query. */
      root->deep_drop();
      return ori_valid_select;
    }

    /* Restrict changes on the signiture norec select components. Could increase
     * mutation efficiency. */
    mark_all_valid_node(ir_tree);

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
        is_mutate_ir_node_chosen = true;
        break;
      }

      if (!is_mutate_ir_node_chosen)
        break; // The current ir tree cannot even find the node to mutate.
               // Ignored and retrive new norec stmt from lib or from library.

      /* Pick random mutation methods. */
      switch (get_rand_int(3)) {
      case 0:
        new_mutated_ir_node = g_mutator->strategy_delete(mutate_ir_node);
        break;
      case 1:
        new_mutated_ir_node = g_mutator->strategy_insert(mutate_ir_node);
        break;
      case 2:
        new_mutated_ir_node = g_mutator->strategy_replace(mutate_ir_node);
        break;
      }

      IR *new_ir_tree = g_mutator->deep_copy_with_record(root, mutate_ir_node);
      g_mutator->replace(new_ir_tree, g_mutator->record_, new_mutated_ir_node);

      if (!g_mutator->check_node_num(new_ir_tree, 300)) {
        deep_delete(new_ir_tree);
        continue;
      }

      string new_valid_select_str = new_ir_tree->to_string();
      if (new_valid_select_str != ori_valid_select) {
        new_valid_select_str = g_mutator->extract_struct(new_ir_tree);
      } 
      
      if (new_valid_select_str != ori_valid_select_struct) {
        new_valid_select_str = g_mutator->extract_struct(new_ir_tree);
      } else {
        new_ir_tree->deep_drop();
        new_valid_select_str = "";
        continue;
      }

      new_ir_tree->deep_drop();

      if (true) {
        // Make sure the mutated structure is different.
        if (new_valid_select_str  != ori_valid_select_struct) {

          root->deep_drop();
          is_success = true;

          if (use_temp)
            total_temp++;
          // cerr << "Getting new_valid_select_str: " << new_valid_select_str << endl;
          return new_valid_select_str;
        }
        // else {
        //  cout << "new|" << new_valid_select_str << "|\n"
        //       << "old|" << ori_valid_select << "|\n";;

        //  if (new_valid_select_str.find(" d ") != string::npos) {
        //    debug(root, 0);
        //    exit(0);
        //  }
        //}
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
}
