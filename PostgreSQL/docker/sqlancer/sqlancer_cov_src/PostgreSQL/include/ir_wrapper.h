#ifndef __IR_WRAPPER_H__
#define __IR_WRAPPER_H__

#include "define.h"
#include "ast.h"
#include <string>
#include "mutate.h"

typedef NODETYPE IRTYPE;

class IRWrapper {
public:
    void set_ir_root (IR* in) {this->ir_root = in;} 
    IR* get_ir_root () {return this->ir_root;}

    vector<IR*> get_all_ir_node (IR* cur_ir_root);
    vector<IR*> get_all_ir_node ();

    bool is_exist_ir_node_in_stmt_with_type(IRTYPE ir_type, bool is_subquery, int stmt_idx);
    vector<IR*> get_ir_node_in_stmt_with_type(IRTYPE ir_type, bool is_subquery = false, int stmt_idx = -1);

    bool is_exist_ir_node_in_stmt_with_type(IR* cur_stmt, IRTYPE ir_type, bool is_subquery = false, bool ignore_is_subquery = false);
    vector<IR*> get_ir_node_in_stmt_with_type(IR* cur_stmt, IRTYPE ir_type, bool is_subquery = false, bool ignore_is_subquery = false);

    bool is_exist_ir_node_in_stmt_with_type(IR* cur_stmt, IRTYPE ir_type);
    vector<IR*> get_ir_node_in_stmt_with_type(IR* cur_stmt, IRTYPE ir_type);

    bool append_stmt_at_idx(string, int idx, const Mutator& g_mutator);
    bool append_stmt_at_end(string, const Mutator& g_mutator);
    bool append_stmt_at_idx(IR*, int idx); // Please provide with IR* (kStatement*) type, do not provide IR*(kStatementList*) type. If want to append at the start, use idx=-1; 
    bool append_stmt_at_end(IR*, const Mutator& g_mutator);
    bool append_stmt_at_end(IR*); // Please provide with IR* (kStatement*) type, do not provide IR*(kStatementList*) type. 

    bool remove_stmt_at_idx_and_free(unsigned idx);
    bool remove_stmt_and_free(IR* rov_stmt);

    bool replace_stmt_and_free(IR* old_stmt, IR* cur_stmt);

    bool append_components_at_ir(IR*, IR*, bool is_left, bool is_replace = true);
    bool remove_components_at_ir(IR*);

    // bool swap_components_at_ir(IR*, bool is_left_f, IR*, bool is_left_l);

    IR* get_ir_node_for_stmt_with_idx(int idx);
    IR* get_ir_node_for_stmt_with_idx(IR* ir_root, int idx);

    bool is_ir_before(IR* f, IR* l); // Check is IR f before IR l in query string.
    bool is_ir_after(IR* f, IR* l); // Check is IR f after IR l in query string.

    vector<IRTYPE> get_all_stmt_ir_type();
    int get_stmt_num();
    int get_stmt_num(IR* cur_root);
    int get_stmt_idx(IR*);

    vector<IR*> get_stmt_ir_vec();
    vector<IR*> get_stmt_ir_vec(IR* root) {this->set_ir_root(root); return this->get_stmt_ir_vec();}

    vector<IR*> get_stmtlist_IR_vec();
    vector<IR*> get_stmtlist_IR_vec(IR* root) {this->set_ir_root(root); return this->get_stmtlist_IR_vec();}

    bool is_in_subquery(IR* cur_stmt, IR* check_node, bool output_debug = false);
    bool is_in_insert_rest(IR* cur_stmt, IR* check_node, bool output_debug=false);

    /*
    ** Iterately find the parent type. Skip kUnknown and keep iterating until not kUnknown is found. Return the parent IRTYPE. 
    ** If parent_ is NULL. Return kUnknown instead. 
    */
    IRTYPE get_parent_type(IR* cur_IR, int depth);
    IR* get_p_parent_with_a_type(IR* cur_IR, int depth=0);

    /**/
    bool is_exist_group_by(IR*);
    bool is_exist_having(IR*);
    bool is_exist_limit(IR*);

    /**/
    vector<IR*> get_selectclauselist_vec(IR*);
    bool append_selectclause_clause_at_idx(IR* cur_stmt, IR* app_ir, string set_oper_str, int idx);
    bool remove_selectclause_clause_at_idx_and_free(IR* cur_stmt, int idx);
    int get_num_selectclause(IR* cur_stmt) {return this->get_selectclauselist_vec(cur_stmt).size();}

    vector<IR*> get_expr_list_in_select_target(IR* cur_stmt);
    int get_num_expr_list_in_select_clause(IR* cur_stmt) { return this->get_expr_list_in_select_target(cur_stmt).size(); }


private:
    IR* ir_root = nullptr;

};


#endif