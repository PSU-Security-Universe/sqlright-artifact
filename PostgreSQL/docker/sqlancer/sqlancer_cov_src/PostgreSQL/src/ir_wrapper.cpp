#include "../include/ir_wrapper.h"
#include "../include/define.h"
#include "../AFL/debug.h"
#include "../include/utils.h"
#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>

bool IRWrapper::is_exist_ir_node_in_stmt_with_type(IRTYPE ir_type, bool is_subquery, int stmt_idx){
    vector<IR*> matching_IR_vec = this->get_ir_node_in_stmt_with_type(ir_type, is_subquery, stmt_idx);
    if (matching_IR_vec.size() == 0){
        return false;
    } else {
        return true;
    }
}

bool IRWrapper::is_exist_ir_node_in_stmt_with_type(IR* cur_stmt, IRTYPE ir_type, bool is_subquery, bool ignore_is_subquery = false) {
    vector<IR*> matching_IR_vec = this->get_ir_node_in_stmt_with_type(cur_stmt, ir_type, is_subquery, ignore_is_subquery);
    if (matching_IR_vec.size() == 0){
        return false;
    } else {
        return true;
    }
}

vector<IR*> IRWrapper::get_ir_node_in_stmt_with_type(IR* cur_stmt, IRTYPE ir_type, bool is_subquery = false, bool ignore_is_subquery = false) {

    // Iterate IR binary tree, left depth prioritized.
    bool is_finished_search = false;
    std::vector<IR*> ir_vec_iter;
    std::vector<IR*> ir_vec_matching_type;
    IR* cur_IR = cur_stmt; 
    // Begin iterating. 
    while (!is_finished_search) {
        ir_vec_iter.push_back(cur_IR);
        if (cur_IR->type_ == ir_type) {
            ir_vec_matching_type.push_back(cur_IR);
        }

        if (cur_IR->left_ != nullptr){
            cur_IR = cur_IR->left_;
            continue;
        } else { // Reaching the most depth. Consulting ir_vec_iter for right_ nodes. 
            cur_IR = nullptr;
            while (cur_IR == nullptr){
                if (ir_vec_iter.size() == 0){
                    is_finished_search = true;
                    break;
                }
                cur_IR = ir_vec_iter.back()->right_;
                ir_vec_iter.pop_back();
            }
            continue;
        }
    }

    // cerr << "We have ir_vec_matching_type.size()" << ir_vec_matching_type.size() << "\n\n\n";
    // if (ir_vec_matching_type.size() > 0 ) {
    //     cerr << "We have ir_vec_matching_type.type_, parent->type_, parent->parent->type_: " << ir_vec_matching_type[0] ->type_ << "  "
    //          << get_parent_type(ir_vec_matching_type[0], 3)  << "   " << get_parent_type(ir_vec_matching_type[0], 4) << "\n\n\n";
    //     cerr << "is_sub_query: " << this->is_in_subquery(cur_stmt, ir_vec_matching_type[0]) << "\n\n\n";
    //     cerr << "ir_vec_matching_type->to_string: " << ir_vec_matching_type[0]->to_string() << "\n\n\n";
    // }

    // Check whether IR node is in a SELECT subquery. 
    if (!ignore_is_subquery) {
        std::vector<IR*> ir_vec_matching_type_depth;
        for (IR* ir_match : ir_vec_matching_type){
            if(this->is_in_subquery(cur_stmt, ir_match) == is_subquery) {
                ir_vec_matching_type_depth.push_back(ir_match);
            }
            continue;
        }
        // cerr << "We have ir_vec_matching_type_depth.size()" << ir_vec_matching_type_depth.size() << "\n\n\n";
        return ir_vec_matching_type_depth;
    } else {
        return ir_vec_matching_type;
    }

    

}

bool IRWrapper::is_in_insert_rest(IR* cur_stmt, IR* check_node, bool output_debug=false)  {
    IR* cur_iter = check_node;
    bool is_finished_search = false;
    while (!is_finished_search) {
        if (cur_iter == NULL) { // Iter to the parent node. This is Not a subquery. 
            return false;
        }
        else if (cur_iter == cur_stmt) {
            return false;
        }
        else if (cur_iter->type_ == kStmtlist) { // Iter to the parent node. This is Not a subquery. 
            return false;
        }
        else if (cur_iter->type_ == kInsertRest){
            return true;
        }
        cur_iter = cur_iter->get_parent(); // Assuming cur_iter->get_parent() will always get to kStatementList. Otherwise, it would be error. 
        continue;
    }
}

bool IRWrapper::is_in_subquery(IR* cur_stmt, IR* check_node, bool output_debug = false) {
    IR* cur_iter = check_node;
    bool is_finished_search = false;
    while (!is_finished_search) {
        if (cur_iter == NULL) { // Iter to the parent node. This is Not a subquery. 
            return false;
        }
        else if (cur_iter == cur_stmt) {
            return false;
        }
        else if (cur_iter->type_ == kStmtlist) { // Iter to the parent node. This is Not a subquery. 
            return false;
        }
        else if (cur_iter->type_ == kSelectNoParens && 
                this->get_parent_type(cur_iter, 1) != kSelectStmt && 
                this->get_parent_type(cur_iter, 1) != kSelectWithParens &&
                this->get_parent_type(cur_iter, 1) != kUnknown
                )  // This IS a subquery. 
        {   
            if (output_debug) {
                cerr << "For kSelectNoParens cur_iter: " << cur_iter->to_string() << ", treated is subquery, parent: " 
                     << get_string_by_ir_type(this->get_parent_type(cur_iter, 1)) << "\n\n\n";
            }
            return true;
        }
        else if (cur_iter->type_ == kSelectStmt && 
                 this->get_parent_type(cur_iter, 1) != kStmt  &&
                 this->get_parent_type(cur_iter, 1) != kUnknown
                 ) {
            if (output_debug) {
                cerr << "For kSelectStmt cur_iter: " << cur_iter->to_string() << ", treated is subquery, parent: " 
                     << get_string_by_ir_type(this->get_parent_type(cur_iter, 1)) << "\n\n\n";
            }
            return true;
        }
        cur_iter = cur_iter->get_parent(); // Assuming cur_iter->get_parent() will always get to kStatementList. Otherwise, it would be error. 
        continue;
    }
}

vector<IR*> IRWrapper::get_ir_node_in_stmt_with_type(IRTYPE ir_type, bool is_subquery = false, int stmt_idx = -1) { // (IRTYPE, subquery_level)

    if (stmt_idx < 0) {
        FATAL("Checking on non-existing stmt. Function: IRWrapper::get_ir_node__in_stmt_with_type. Idx < 0. idx: '%s' \n", to_string(stmt_idx));
    }
    IR* cur_stmt = this->get_ir_node_for_stmt_with_idx(stmt_idx);

    return this->get_ir_node_in_stmt_with_type(cur_stmt, ir_type, is_subquery);
}

IR* IRWrapper::get_ir_node_for_stmt_with_idx(int idx) {

    if (idx < 0) {
        FATAL("Checking on non-existing stmt. Function: IRWrapper::get_ir_node_for_stmt_with_idx(). Idx < 0. idx: '%s' \n", to_string(idx));
    }

    if (this->ir_root == nullptr){
        FATAL("Root IR not found in IRWrapper::get_ir_node_for_stmt_with_idx(); Forgot to initilize the IRWrapper? \n");
    }

    vector<IR*> stmt_list_v = this->get_stmtlist_IR_vec();

    if (idx >= stmt_list_v.size()){
        std::cerr << "Statement with idx " << idx << " not found in the IR. " << std::endl;
        return nullptr;
    }
    IR* cur_stmt_list = stmt_list_v[idx];
    IR* cur_stmt = cur_stmt_list -> left_ ->left_;  /* stmt_list -> stmt -> specific_stmt */
    return cur_stmt;
}

IR* IRWrapper::get_ir_node_for_stmt_with_idx(IR* ir_root, int idx) {
    this->set_ir_root(ir_root);
    return this->get_ir_node_for_stmt_with_idx(idx);
}

/* Not accurate within query. */
bool IRWrapper::is_ir_before(IR* f, IR* l){
    return this->is_ir_after(l, f);
}

/* Not accurate within query. */
bool IRWrapper::is_ir_after(IR* f, IR* l){
    if (this->ir_root == nullptr){
        FATAL("Root IR not found in IRWrapper::is_ir_before/after(); Forgot to initilize the IRWrapper? \n");
    }

    // Left depth prioritized iteration. Should found l first if IR f is behind(after) l. 
    // Iterate IR binary tree, left depth prioritized.
    bool is_finished_search = false;
    std::vector<IR*> ir_vec_iter;
    IR* cur_IR = this->ir_root; 
    // Begin iterating. 
    while (!is_finished_search) {
        ir_vec_iter.push_back(cur_IR);
        if (cur_IR == l) {
            return true;
        } else if (cur_IR == f) {
            return false;
        }

        if (cur_IR->left_ != nullptr){
            cur_IR = cur_IR->left_;
            continue;
        } else { // Reaching the most depth. Consulting ir_vec_iter for right_ nodes. 
            cur_IR = nullptr;
            while (cur_IR == nullptr){
                if (ir_vec_iter.size() == 0){
                    is_finished_search = true;
                    break;
                }
                cur_IR = ir_vec_iter.back()->right_;
                ir_vec_iter.pop_back();
            }
            continue;
        }
    }

    FATAL("Cannot find curent IR in the IR tree. Function IRWrapper::is_ir_after(). \n");

}


vector<IRTYPE> IRWrapper::get_all_stmt_ir_type(){

    vector<IR*> stmt_list_v = this->get_stmtlist_IR_vec();

    vector<IRTYPE> all_types;
    for (auto iter = stmt_list_v.begin(); iter != stmt_list_v.end(); iter++){
        all_types.push_back((**iter).type_);
    }
    return all_types;

}

int IRWrapper::get_stmt_num(){
    return this->get_stmtlist_IR_vec().size();
}

int IRWrapper::get_stmt_num(IR* cur_root) {
    if (cur_root->type_ != kProgram) {
        cerr << "Error: Receiving NON-kProgram root. Func: IRWrapper::get_stmt_num(IR* cur_root). Aboard!\n";
        FATAL("Error: Receiving NON-kProgram root. Func: IRWrapper::get_stmt_num(IR* cur_root). Aboard!\n");
    }
    this->set_ir_root(cur_root);
    return this->get_stmt_num();
}

vector<IR*> IRWrapper::get_stmtlist_IR_vec(){
    IR* stmt_IR_p = this->ir_root->left_;
    vector<IR*> stmt_list_v;


    while (true){ // Iterate from the first kstatementlist to the last. 
        stmt_list_v.push_back(stmt_IR_p);
        if (stmt_IR_p->right_ == nullptr || stmt_IR_p->left_ == nullptr) break; // This is the last kstatementlist. 
        stmt_IR_p = stmt_IR_p -> right_; // Lead to the next kstatementlist. 
    }

    return stmt_list_v;
}

bool IRWrapper::append_stmt_at_idx(string app_str, int idx, const Mutator& g_mutator){

    vector<IR*> stmt_list_v = this->get_stmtlist_IR_vec();

    if (idx != -1 && idx > stmt_list_v.size()){
        std::cerr << "Error: Input index exceed total statement number. \n In function IRWrapper::append_stmt_at_idx(). \n";
        return false;
    }

    // Parse and get the new statement. 
    vector<IR*> app_IR_vec = g_mutator.parse_query_str_get_ir_set(app_str);
    IR* app_IR_node = app_IR_vec.back()->left_->left_->left_;  // Program -> kStatementlist -> kStatement -> kSpecificStmt. 
    app_IR_node = app_IR_node->deep_copy();
    app_IR_vec.back()->deep_drop();
    app_IR_vec.clear();

    return this->append_stmt_at_idx(app_IR_node, idx);

}

bool IRWrapper::append_stmt_at_end(string app_str, const Mutator& g_mutator) {

    vector<IR*> stmt_list_v = this->get_stmtlist_IR_vec();

    // Parse and get the new statement. 
    vector<IR*> app_IR_vec = g_mutator.parse_query_str_get_ir_set(app_str);
    IR* app_IR_node = app_IR_vec.back()->left_->left_->left_;  // Program -> Statementlist -> Statement -> kSpecificStmt
    app_IR_node = app_IR_node->deep_copy();
    app_IR_vec.back()->deep_drop();
    app_IR_vec.clear();

    return this->append_stmt_at_idx(app_IR_node, stmt_list_v.size());
    
}


bool IRWrapper::append_stmt_at_end(IR* app_IR_node) { // Please provide with IR* (Statement*) type, do not provide IR*(StatementList*) type. 

    int total_num = this->get_stmt_num();
    return this->append_stmt_at_idx(app_IR_node, total_num);

}

bool IRWrapper::append_stmt_at_idx(IR* app_IR_node, int idx) { // Please provide with IR* (Statement*) type, do not provide IR*(StatementList*) type. 
    vector<IR*> stmt_list_v = this->get_stmtlist_IR_vec();

    if (idx < 0 && idx > stmt_list_v.size()){
        std::cerr << "Error: Input index exceed total statement number. \n In function IRWrapper::append_stmt_at_idx(). \n";
        std::cerr << "Error: Input index " << to_string(idx) << "; stmt_list_v size(): " << stmt_list_v.size() << ".\n";
        return false;
    }

    app_IR_node = new IR(kStmt, OP0(), app_IR_node);

    if (idx < stmt_list_v.size()) {
        IR* insert_pos_ir = stmt_list_v[idx];

        auto new_res = new IR(kStmtlist, OPMID(";"), app_IR_node, NULL);

        if (!ir_root->swap_node(insert_pos_ir, new_res)){ // swap_node only rewrite the parent of insert_pos_ir, it will not affect     insert_pos_ir. 
            new_res->deep_drop();
            // FATAL("Error: Swap node failure? In function: IRWrapper::append_stmt_at_idx. \n");
            std::cerr << "Error: Swap node failure? In function: IRWrapper::append_stmt_at_idx. idx = " << idx << "\n";
            return false;
        }

        new_res->update_right(insert_pos_ir);

        return true;
    } else { // idx == stmt_list_v.size()
        IR* insert_pos_ir = stmt_list_v[idx-1];
        if (insert_pos_ir -> right_ != NULL ){
            std::cerr << "Error: The last stmt_list is having right_ sub-node. In function IRWrapper::append_stmt_at_idx. \n";
            return false;
        }

        auto new_res = new IR(kStmtlist, OPMID(";"), app_IR_node, NULL);
        insert_pos_ir->update_right(new_res);

        return true;
    
    }
}

bool IRWrapper::remove_stmt_at_idx_and_free(unsigned idx){

    vector<IR*> stmt_list_v = this->get_stmtlist_IR_vec();

    if (idx >= stmt_list_v.size() && idx < 0){
        std::cerr << "Error: Input index exceed total statement number. \n In function IRWrapper::remove_stmt_at_idx_and_free(). \n";
        return false;
    }

    if (stmt_list_v.size() == 1) {
        // std::cerr << "Error: Cannot remove stmt becuase there is only one stmt left in the query. \n In function IRWrapper::remove_stmt_at_idx_and_free(). \n";
        return false;
    }

    IR* rov_stmt = stmt_list_v[idx];

    if (idx < stmt_list_v.size()-1){
        IR* parent_node = rov_stmt->get_parent();
        IR* next_stmt = rov_stmt->right_;
        parent_node->swap_node(rov_stmt, next_stmt);
        rov_stmt->right_ = NULL;
        rov_stmt->deep_drop();

    } else { // idx == stmt_list_v.size()-1. Remove the last stmt. 
        IR* parent_node = rov_stmt->get_parent();
        parent_node->detach_node(rov_stmt);
        rov_stmt->deep_drop();
    }

    return true;
}

vector<IR*> IRWrapper::get_stmt_ir_vec() {
    vector<IR*> stmtlist_vec = this->get_stmtlist_IR_vec(), stmt_vec;
    if (stmtlist_vec.size() == 0) return stmt_vec;

    for (int i = 0; i < stmtlist_vec.size(); i++){
        stmt_vec.push_back(stmtlist_vec[i]->left_->left_); // kStatementlist -> kStatement -> specific_statement_type
    }
    
    // // DEBUG
    // for (auto stmt : stmt_vec) {
    //     cerr << "In func: IRWrapper::get_stmt_ir_vec(), we have stmt_vec type_: " << get_string_by_ir_type(stmt->type_) << "\n";
    // }

    return stmt_vec;
}

bool IRWrapper::remove_stmt_and_free(IR* rov_stmt) {
    vector<IR*> stmt_vec = this->get_stmt_ir_vec();
    int stmt_idx = -1;
    for (int i = 0; i < stmt_vec.size(); i++) {
        if (stmt_vec[i] == rov_stmt) {stmt_idx = i; break;}
    }
    if (stmt_idx == -1) {return false;}
    else {
        return this->remove_stmt_at_idx_and_free(stmt_idx);
    }
}

bool IRWrapper::append_components_at_ir(IR* parent_node, IR* app_node, bool is_left, bool is_replace = true) {
    if (is_left) {
        if (parent_node->left_ != nullptr) {
            if (!is_replace) {
                cerr << "Append location has content, use is_replace=true if necessary. Function: IRWrapper::append_components_at_ir. \n";
                return false;
            }
            IR* old_node = parent_node->left_;
            parent_node->detach_node(old_node);
            old_node->deep_drop();
        }
        parent_node->update_left(app_node);
        return true;
    } else {
        if (parent_node->right_ != nullptr) {
            if (!is_replace) {
                cerr << "Append location has content, use is_replace=true if necessary. Function: IRWrapper::append_components_at_ir. \n";
                return false;
            }
            IR* old_node = parent_node->right_;
            parent_node->detach_node(old_node);
            old_node->deep_drop();
        }
        parent_node->update_right(app_node);
        return true;
    }
}

bool IRWrapper::remove_components_at_ir(IR* rov_ir) {
    if (rov_ir && rov_ir->parent_) {
        IR* parent_node = rov_ir->get_parent();
        parent_node->detach_node(rov_ir);
        rov_ir->deep_drop();
        return true;
    }
    cerr << "Error: rov_ir or rov_ir->parent_ are nullptr. Function IRWrapper::remove_components_at_ir() \n";
    return false;
}

vector<IR*> IRWrapper::get_all_ir_node (IR* cur_ir_root) {
    this->set_ir_root(cur_ir_root);
    return this->get_all_ir_node();
}

vector<IR*> IRWrapper::get_all_ir_node() {
    if (this->ir_root == nullptr) {
        std::cerr << "Error: IRWrapper::ir_root is nullptr. Forget to initilized? \n";
    }
    // Iterate IR binary tree, depth prioritized. (not left depth prioritized)
    bool is_finished_search = false;
    std::vector<IR*> ir_vec_iter;
    std::vector<IR*> all_ir_node_vec;
    IR* cur_IR = this->ir_root;
    // Begin iterating. 
    while (!is_finished_search) {
        ir_vec_iter.push_back(cur_IR);
        if (cur_IR->type_ != kProgram) 
            {all_ir_node_vec.push_back(cur_IR);} // Ignore kProgram at the moment, put it at the end of the vector. 

        if (cur_IR->left_ != nullptr){
            cur_IR = cur_IR->left_;
            continue;
        } else { // Reaching the most depth. Consulting ir_vec_iter for right_ nodes. 
            cur_IR = nullptr;
            while (cur_IR == nullptr){
                if (ir_vec_iter.size() == 0){
                    is_finished_search = true;
                    break;
                }
                cur_IR = ir_vec_iter.back()->right_;
                ir_vec_iter.pop_back();
            }
            continue;
        }
    }
    all_ir_node_vec.push_back(this->ir_root);
    return all_ir_node_vec;
}

int IRWrapper::get_stmt_idx(IR* cur_stmt){
    vector<IR*> all_stmt_vec = this->get_stmt_ir_vec();
    int output_idx = -1;
    int count = 0;
    for (IR* iter_stmt : all_stmt_vec) {
        if (iter_stmt == cur_stmt) {
            output_idx = count;
            break;
        }
        count++;
    }
    return output_idx;
}

bool IRWrapper::replace_stmt_and_free(IR* old_stmt, IR* new_stmt) {
    int old_stmt_idx = this->get_stmt_idx(old_stmt);
    if (old_stmt_idx < 0) {
        // cerr << "Error: old_stmt_idx < 0. Old_stmt_idx: " << old_stmt_idx << ". In func: IRWrapper::replace_stmt_and_free. \n"; 
        return false;
    }
    if (!this->remove_stmt_at_idx_and_free(old_stmt_idx)){
        // cerr << "Error: child function remove_stmt_at_idx_and_free returns error. In func: IRWrapper::replace_stmt_and_free. \n"; 
        return false;
    }
    if (!this->append_stmt_at_idx(new_stmt, old_stmt_idx)){
        // cerr << "Error: child function append_stmt_after_idx returns error. In func: IRWrapper::replace_stmt_and_free. \n";
        return false;
    }
    return true;
}

IRTYPE IRWrapper::get_parent_type(IR* cur_IR, int depth = 0){
    IR* output_IR = this->get_p_parent_with_a_type(cur_IR, depth);
    if (output_IR == nullptr) {
        return kUnknown;
    } else {
        return output_IR->type_;
    }
}

IR* IRWrapper::get_p_parent_with_a_type(IR* cur_IR, int depth=0) {
    while (cur_IR ->parent_ != nullptr) {
        IRTYPE parent_type = cur_IR->parent_->type_;
        if (parent_type != kUnknown) {
            depth--;
            if (depth <= 0) {
                return cur_IR->parent_;
            }   
        }
        cur_IR = cur_IR->parent_;
    }
    // cerr << "Error: Find get_parent_type without parent_ ? \n";
    return nullptr;
}

bool IRWrapper::is_exist_group_by(IR* cur_stmt){
    if (this->is_exist_ir_node_in_stmt_with_type(cur_stmt, kOptGroupClause, false)) {
        vector<IR *> all_opt_group = this->get_ir_node_in_stmt_with_type(cur_stmt, kOptGroupClause, false);
        for (IR *cur_opt_group : all_opt_group) {
            if (cur_opt_group != nullptr && cur_opt_group->op_ != nullptr && cur_opt_group->op_->prefix_ == "GROUP BY") {
                return true;
            }
        }
    }
    return false;
}

bool IRWrapper::is_exist_having(IR* cur_stmt){
    if (this->is_exist_ir_node_in_stmt_with_type(cur_stmt, kOptHavingClause, false)) {
        vector<IR *> all_opt_group = this->get_ir_node_in_stmt_with_type(cur_stmt, kOptHavingClause, false);
        for (IR *cur_opt_group : all_opt_group) {
            if (cur_opt_group->right_ != nullptr) {
                IR* opt_having = cur_opt_group->right_;
                if (opt_having->op_ != nullptr && opt_having->op_->prefix_ == "HAVING") {
                    return true;
                }
            }
        }
    }
    return false;
}

bool IRWrapper::is_exist_limit(IR* cur_stmt){
    if (this->is_exist_ir_node_in_stmt_with_type(cur_stmt, kLimitClause, false)) {
        vector<IR *> all_limit_clause = this->get_ir_node_in_stmt_with_type(cur_stmt, kLimitClause, false);
        for (IR *cur_limit_clause : all_limit_clause) {
            if (cur_limit_clause->op_) {
                if (cur_limit_clause->op_->prefix_ == "LIMIT") {
                    return true;
                }
            }
        }
    }
    return false;
}

vector<IR*> IRWrapper::get_selectclauselist_vec(IR* cur_stmt){
    if (cur_stmt->type_ != kSelectStmt) {
        // cerr << "Error: Not receiving kSelectStatement in the func: IRWrapper::get_selectcore_vec(). \n";
        vector<IR*> tmp; return tmp;
    }
    // cerr << "In Func: IRWrapper::get_selectclauselist_vec(IR*), we have cur_stmt to_string: " << cur_stmt->to_string() << "\n\n\n";

    vector<IR*> res_selectcore_vec;
    vector<IR*> select_clause_list_vec = this->get_ir_node_in_stmt_with_type(cur_stmt, kSelectClauseList, false);

    /* Should be able to return the list directly. */
    // return select_clause_list_vec;

    // Debugging 
    vector<IR*> select_clause_list_vec_tmp;
    IR* first_select_clause_list = select_clause_list_vec[0];
    select_clause_list_vec_tmp.push_back(first_select_clause_list);
    while (first_select_clause_list->right_){
        first_select_clause_list = first_select_clause_list->right_;
        select_clause_list_vec_tmp.push_back(first_select_clause_list);
    }

    if (select_clause_list_vec != select_clause_list_vec_tmp) {
        cerr << "Error. Func get_ir_node_in_stmt_with_type is mismatched with manualy fetched selectclauselist. \n";
    }
    
    return select_clause_list_vec_tmp;

}

bool IRWrapper::append_selectclause_clause_at_idx(IR* cur_stmt, IR* app_ir, string set_oper_str, int idx){
    if (app_ir->type_ != kSelectClause) {
        cerr << "Error: Not receiving kSelectCore in the func: IRWrapper::append_selectcore_clause(). \n";
        return false;
    }
    if (cur_stmt->type_ != kSelectStmt) {
        cerr << "Error: Not receiving kSelectStatement in the func: IRWrapper::append_selectcore_clause(). \n";
        return false;
    }

    vector<IR*> selectclause_vec = this->get_selectclauselist_vec(cur_stmt);
    if (selectclause_vec.size() > idx) {
        cerr << "Idx exceeding the maximum number of selectcore in the statement. \n";
        return false;
    }

    if (idx < selectclause_vec.size()) {
        IR* insert_pos_ir = selectclause_vec[idx];

        IR* combineClauseIR = new IR(kCombineClause, OP3(set_oper_str, "", ""));
        IR* new_res = new IR(kUnknown, OP3("", "", ""), app_ir, combineClauseIR);
        new_res = new IR(kSelectClauseList, OP3("", "", ""), new_res, NULL);

        if (!ir_root->swap_node(insert_pos_ir, new_res)){ // swap_node only rewrite the parent of insert_pos_ir, it will not affect     insert_pos_ir. 
            new_res->deep_drop();
            // FATAL("Error: Swap node failure? In function: IRWrapper::append_stmt_at_idx. \n");
            std::cerr << "Error: Swap node failure? In function: IRWrapper::append_stmt_at_idx. idx = " << idx << "\n";
            return false;
        }

        new_res->update_right(insert_pos_ir);

        return true;
    } else { // idx == selectclause_vec.size()
        IR* new_res = new IR(kSelectClauseList, OP3("", "", ""), app_ir);

        IR* insert_pos_ir = selectclause_vec[idx-1];
        if (insert_pos_ir->right_ != NULL) {
            std::cerr << "Error: The last selectclause_vec is having right_ sub-node. In function IRWrapper::append_stmt_at_idx. \n";
            return false;
        }

        insert_pos_ir->update_right(new_res);

        return true;    
    }
}

bool IRWrapper::remove_selectclause_clause_at_idx_and_free(IR* cur_stmt, int idx) {
    vector<IR*> selectclause_vec = this->get_selectclauselist_vec(cur_stmt);

    if (idx >= selectclause_vec.size() && idx < 0){
        std::cerr << "Error: Input index exceed total statement number. \n In function IRWrapper::remove_stmt_at_idx_and_free(). \n";
        return false;
    }

    if (selectclause_vec.size() == 1) {
        // std::cerr << "Error: Cannot remove stmt becuase there is only one stmt left in the query. \n In function IRWrapper::remove_stmt_at_idx_and_free(). \n";
        return false;
    }

    IR* rov_clause = selectclause_vec[idx];

    if (idx < selectclause_vec.size()-1){
        IR* parent_node = rov_clause->get_parent();
        IR* next_clause = rov_clause->right_;
        parent_node->swap_node(rov_clause, next_clause);
        rov_clause->right_ = NULL;
        rov_clause->deep_drop();

    } else { // idx == stmt_list_v.size()-1. Remove the last stmt. 
        IR* parent_node = rov_clause->get_parent();
        parent_node->detach_node(rov_clause);
        rov_clause->deep_drop();
    }

    return true;
}

vector<IR*> IRWrapper::get_expr_list_in_select_target(IR* cur_stmt){
    vector<IR*> res_vec;

    IR* select_target = this->get_ir_node_in_stmt_with_type(cur_stmt, kSelectTarget, false)[0]; // vec[0]
    IR* expr_list = select_target->left_;
    if (expr_list->type_ != kExprList) {
        cerr << "Error: cannot find expr_list in select_target. \n";
        return res_vec;  // empty. 
    }

    res_vec.push_back(expr_list);
    while(expr_list->right_ != NULL && expr_list->right_->type_ == kExprList) {
        expr_list = expr_list->right_;
        res_vec.push_back(expr_list);
    }
    return res_vec;
}



