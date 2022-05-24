#include "../include/ast.h"
#include "../include/define.h"
#include "../include/utils.h"
#include <cassert>
#include <cstdio>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <vector>
#include <string.h>

static string s_table_name;

string get_string_by_ir_type(IRTYPE type) {

#define DECLARE_CASE(classname) \
  if (type == classname)     \
    return #classname;

  ALLTYPE(DECLARE_CASE);
#undef DECLARE_CASE

  return "";
}

string get_string_by_option_type(RelOptionType type) {
  switch (type) {
    case Unknown:
      return "option_unknown";
    case StorageParameters:
      return "option_storageParameters";
    case SetConfigurationOptions:
      return "option_setConfigurationOptions";
  }
  return "option_unknown";
}

string get_string_by_data_type(DATATYPE type) {

  switch (type) {
  case kDataWhatever:
    return "data_whatever";
  case kDataTableName:
    return "data_tableName";
  case kDataColumnName:
    return "data_columnName";
  case kDataViewName:
    return "data_viewName";
  case kDataFunctionName:
    return "data_functionName";
  case kDataPragmaKey:
    return "data_pragmaKey";
  case kDataPragmaValue:
    return "data_pragmaValue";
  case kDataTableSpaceName:
    return "data_tableSpaceName";
  case kDataSequenceName:
    return "data_SequenceName";
  case kDataExtensionName:
    return "data_extensionName";
  case kDataRoleName:
    return "data_roleName";
  case kDataSchemaName:
    return "data_SchemaName";
  case kDataDatabase:
    return "data_dataDatabase";
  case kDataTriggerName:
    return "data_triggername";
  case kDataWindowName:
    return "data_windowName";
  case kDataTriggerFunction:
    return "data_triggerFunction";
  case kDataDomainName:
    return "data_domainName";
  case kDataAliasName:
    return "data_aliasName";
  default:
    return "data_unknown";
  }
}

string get_string_by_data_flag(DATAFLAG flag_type_) {

  switch (flag_type_) {
  case kUse:
    return "kUse";
  case kMapToClosestOne:
    return "kMapToClosestOne";
  case kNoSplit:
    return "kNoSplit";
  case kGlobal:
    return "kGlobal";
  case kReplace:
    return "kReplace";
  case kUndefine:
    return "kUndefine";
  case kAlias:
    return "kAlias";
  case kMapToAll:
    return "kMapToAll";
  case kDefine:
    return "kDefine";
  default:
    return "kUnknown";
  }
}

string get_string_by_datatype(DATATYPE tt) {
#define DECLARE_CASE(datatypename)                                             \
  if (tt == k##datatypename)                                                   \
    return string(#datatypename);

  ALLDATATYPE(DECLARE_CASE);

#undef DECLARE_CASE
  return string("");
}

DATATYPE get_datatype_by_string(string s) {
#define DECLARE_CASE(datatypename)                                             \
  if (s == #datatypename)                                                      \
    return k##datatypename;

  ALLDATATYPE(DECLARE_CASE);

#undef DECLARE_CASE
  return kDataWhatever;
}

void deep_delete(IR *root) {
  if (root->left_)
    deep_delete(root->left_);
  if (root->right_)
    deep_delete(root->right_);

  if (root->op_)
    delete root->op_;

  delete root;
}

IR *deep_copy(const IR *root) {
  IR *left = NULL, *right = NULL, *copy_res;

  if (root->left_)
    left = deep_copy(root->left_);
  if (root->right_)
    right = deep_copy(root->right_);

  copy_res = new IR(root, left, right);


  return copy_res;
}

bool IR::replace_op(IROperator* op_in) {
  if (this->op_) {
    delete this->op_;
  }

  this->op_ = op_in;

  return true;

}

string IR::to_string() {
  string res = "";
  to_string_core(res);
  trim_string(res);
  return res;
}

/* Very frequently called. Must be very fast. */
void IR::to_string_core(string& res) {

//   if (data_type_ == kDataCollate) {
//     res += "\"" + str_val_ + "\"";
//     return;
//   }

  switch (type_) {
  case kIntLiteral:
    if (str_val_ != "") {
      res += str_val_;
    } else {
      res += std::to_string(int_val_);
    }
    return;
  case kFloatLiteral:
    if (str_val_ != "") {
      res += str_val_;
    } else {
      res += std::to_string(float_val_);
    }
    return;
  case kBoolLiteral:
    if (str_val_ != "") {
      res += str_val_;
    }  else {
      if (bool_val_) {
        res += " TRUE ";
      } else {
        res += " FALSE ";
      }
    }
    return;
  case kIdentifier:
    if (str_val_ != "") {
      res += str_val_;
    }
    return;
  case kStringLiteral:
    res += "'" + str_val_ + "'";
    return;
  }


  // if (type_ == kFuncArgs && str_val_ != "") {
  //   res += str_val_;
  //   return;
  // }

  /* If we have str_val setup, directly return the str_val_; */
  if (str_val_ != "") {
    res += str_val_;
    return;
  }

  if (op_) {
    res += op_->prefix_;
    res += " ";
  }

  if (left_) {
    left_->to_string_core(res);
    res += " ";
  }

  if (op_) {
    res += op_->middle_;
    res += + " ";
  }

  if (right_) {
    right_->to_string_core(res);
    res += " ";
  }

  if (op_)
    res += op_->suffix_;

  return;
}

bool IR::detach_node(IR *node) { return swap_node(node, NULL); }

bool IR::swap_node(IR *old_node, IR *new_node) {
  if (old_node == NULL)
    return false;

  IR *parent = this->locate_parent(old_node);

  if (parent == NULL)
    return false;
  else if (parent->left_ == old_node)
    parent->update_left(new_node);
  else if (parent->right_ == old_node)
    parent->update_right(new_node);
  else
    return false;

  old_node->parent_ = NULL;

  return true;
}

IR *IR::locate_parent(IR *child) {

  for (IR *p = child; p; p = p->parent_)
    if (p->parent_ == this)
      return child->parent_;

  return NULL;
}

IR *IR::get_root() {

  IR *node = this;

  while (node->parent_ != NULL)
    node = node->parent_;

  return node;
}

IR *IR::get_parent() { return this->parent_; }

void IR::update_left(IR *new_left) {

  // we do not update the parent_ of the old left_
  // we do not update the child of the old parent_ of new_left

  this->left_ = new_left;
  if (new_left)
    new_left->parent_ = this;
}

void IR::update_right(IR *new_right) {

  // we do not update the parent_ of the old right_
  // we do not update the child of the old parent_ of new_right

  this->right_ = new_right;
  if (new_right)
    new_right->parent_ = this;
}

void IR::drop() {

  if (this->op_)
    delete this->op_;
  delete this;
}

void IR::deep_drop() {

  if (this->left_)
    this->left_->deep_drop();

  if (this->right_)
    this->right_->deep_drop();

  this->drop();
}

IR *IR::deep_copy() {

  IR *left = NULL, *right = NULL, *copy_res;
  IROperator *op = NULL;

  if (this->left_)
    left = this->left_->deep_copy();
  if (this->right_)
    right = this->right_->deep_copy();

  if (this->op_)
    op = OP3(this->op_->prefix_, this->op_->middle_, this->op_->suffix_);

  copy_res = new IR(this->type_, op, left, right, this->float_val_,
                    this->str_val_, this->name_, this->mutated_times_);
  copy_res->data_type_ = this->data_type_;
  copy_res->data_flag_ = this->data_flag_;
  copy_res->option_type_ = this->option_type_;

  return copy_res;
}

const char* IR::get_prefix(){
  if (op_) {
    return op_->prefix_;
  }
  return "";
}

const char* IR::get_middle() {
  if (op_) {
    return op_->middle_;
  }
  return "";
}

const char* IR::get_suffix() {
  if (op_) {
    return op_->suffix_;
  }
  return "";
}

string IR::get_str_val() {
  return str_val_;
}

bool IR::is_empty() {
    if (op_) {
        if (strcmp(op_->prefix_, "") || strcmp(op_->middle_, "") || strcmp(op_->suffix_, "")) {
            return false;
        }
    }
    if (str_val_ != "") {
        return false;
    }
    if (left_ || right_) {
        return false;
    }
    return true;
}

void IR::set_str_val(string in) {
  str_val_ = in;
}

IRTYPE IR::get_ir_type() {
  return type_;
}

DATATYPE IR::get_data_type() {
  return data_type_;
}

DATAFLAG IR::get_data_flag() {
  return data_flag_;
}

IR* IR::get_left() {
  return left_;
}

IR* IR::get_right() {
  return right_;
}

IR* Node::translate(vector<IR *> &v_ir_collector){
    return NULL;
}
IR*  Program::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(stmtlist_);
		res = new IR(kProgram, OP3("","",""), tmp1);

	TRANSLATEEND
}

void Program::deep_delete(){
	SAFEDELETE(stmtlist_);
	delete this;
};

void Program::generate(){
	GENERATESTART(1)

		stmtlist_ = new Stmtlist();
		stmtlist_->generate();

	GENERATEEND
}



IR*  Stmtlist::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(stmt_);
		auto tmp2= SAFETRANSLATE(stmtlist_);
		res = new IR(kStmtlist, OP3("",";",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(stmt_);
		res = new IR(kStmtlist, OP3("",";",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void Stmtlist::deep_delete(){
	SAFEDELETE(stmt_);
	SAFEDELETE(stmtlist_);
	delete this;
};

void Stmtlist::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		stmt_ = new Stmt();
		stmt_->generate();
		stmtlist_ = new Stmtlist();
		stmtlist_->generate();
		CASEEND
		CASESTART(1)
		stmt_ = new Stmt();
		stmt_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		stmt_ = new Stmt();
		stmt_->generate();
case_idx_ = 1;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  Stmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(create_stmt_);
		res = new IR(kStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(drop_stmt_);
		res = new IR(kStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(select_stmt_);
		res = new IR(kStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(update_stmt_);
		res = new IR(kStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(4)
		auto tmp1= SAFETRANSLATE(insert_stmt_);
		res = new IR(kStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(5)
		auto tmp1= SAFETRANSLATE(alter_stmt_);
		res = new IR(kStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(6)
		auto tmp1= SAFETRANSLATE(reindex_stmt_);
		res = new IR(kStmt, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void Stmt::deep_delete(){
	SAFEDELETE(insert_stmt_);
	SAFEDELETE(drop_stmt_);
	SAFEDELETE(create_stmt_);
	SAFEDELETE(select_stmt_);
	SAFEDELETE(alter_stmt_);
	SAFEDELETE(reindex_stmt_);
	SAFEDELETE(update_stmt_);
	delete this;
};

void Stmt::generate(){
	GENERATESTART(7)

	SWITCHSTART
		CASESTART(0)
		create_stmt_ = new CreateStmt();
		create_stmt_->generate();
		CASEEND
		CASESTART(1)
		drop_stmt_ = new DropStmt();
		drop_stmt_->generate();
		CASEEND
		CASESTART(2)
		select_stmt_ = new SelectStmt();
		select_stmt_->generate();
		CASEEND
		CASESTART(3)
		update_stmt_ = new UpdateStmt();
		update_stmt_->generate();
		CASEEND
		CASESTART(4)
		insert_stmt_ = new InsertStmt();
		insert_stmt_->generate();
		CASEEND
		CASESTART(5)
		alter_stmt_ = new AlterStmt();
		alter_stmt_->generate();
		CASEEND
		CASESTART(6)
		reindex_stmt_ = new ReindexStmt();
		reindex_stmt_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  CreateStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(create_table_stmt_);
		res = new IR(kCreateStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(create_index_stmt_);
		res = new IR(kCreateStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(create_view_stmt_);
		res = new IR(kCreateStmt, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CreateStmt::deep_delete(){
	SAFEDELETE(create_index_stmt_);
	SAFEDELETE(create_view_stmt_);
	SAFEDELETE(create_table_stmt_);
	delete this;
};

void CreateStmt::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		create_table_stmt_ = new CreateTableStmt();
		create_table_stmt_->generate();
		CASEEND
		CASESTART(1)
		create_index_stmt_ = new CreateIndexStmt();
		create_index_stmt_->generate();
		CASEEND
		CASESTART(2)
		create_view_stmt_ = new CreateViewStmt();
		create_view_stmt_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  DropStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(drop_index_stmt_);
		res = new IR(kDropStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(drop_table_stmt_);
		res = new IR(kDropStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(drop_view_stmt_);
		res = new IR(kDropStmt, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void DropStmt::deep_delete(){
	SAFEDELETE(drop_table_stmt_);
	SAFEDELETE(drop_view_stmt_);
	SAFEDELETE(drop_index_stmt_);
	delete this;
};

void DropStmt::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		drop_index_stmt_ = new DropIndexStmt();
		drop_index_stmt_->generate();
		CASEEND
		CASESTART(1)
		drop_table_stmt_ = new DropTableStmt();
		drop_table_stmt_->generate();
		CASEEND
		CASESTART(2)
		drop_view_stmt_ = new DropViewStmt();
		drop_view_stmt_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  AlterStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(table_name_);
		auto tmp2= SAFETRANSLATE(alter_action_);
		res = new IR(kAlterStmt, OP3("ALTER TABLE","",""), tmp1, tmp2);

	TRANSLATEEND
}

void AlterStmt::deep_delete(){
	SAFEDELETE(alter_action_);
	SAFEDELETE(table_name_);
	delete this;
};

void AlterStmt::generate(){
	GENERATESTART(1)

		table_name_ = new TableName();
		table_name_->generate();
		alter_action_ = new AlterAction();
		alter_action_->generate();

	GENERATEEND
}



IR*  SelectStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(select_no_parens_);
		res = new IR(kSelectStmt, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(select_with_parens_);
		res = new IR(kSelectStmt, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void SelectStmt::deep_delete(){
	SAFEDELETE(select_no_parens_);
	SAFEDELETE(select_with_parens_);
	delete this;
};

void SelectStmt::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();
		CASEEND
		CASESTART(1)
		select_with_parens_ = new SelectWithParens();
		select_with_parens_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  SelectWithParens::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(select_no_parens_);
		res = new IR(kSelectWithParens, OP3("(",")",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(select_with_parens_);
		res = new IR(kSelectWithParens, OP3("(",")",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void SelectWithParens::deep_delete(){
	SAFEDELETE(select_no_parens_);
	SAFEDELETE(select_with_parens_);
	delete this;
};

void SelectWithParens::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();
		CASEEND
		CASESTART(1)
		select_with_parens_ = new SelectWithParens();
		select_with_parens_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  SelectNoParens::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_with_clause_);
		auto tmp2= SAFETRANSLATE(select_clause_list_);
		auto tmp3= SAFETRANSLATE(opt_order_clause_);
		auto tmp4= SAFETRANSLATE(opt_limit_clause_);
		auto tmp5 = new IR(kUnknown, OP3("","",""), tmp1, tmp2);
		PUSH(tmp5);
		auto tmp6 = new IR(kUnknown, OP3("","",""), tmp5, tmp3);
		PUSH(tmp6);
		res = new IR(kSelectNoParens, OP3("","",""), tmp6, tmp4);

	TRANSLATEEND
}

void SelectNoParens::deep_delete(){
	SAFEDELETE(select_clause_list_);
	SAFEDELETE(opt_with_clause_);
	SAFEDELETE(opt_order_clause_);
	SAFEDELETE(opt_limit_clause_);
	delete this;
};

void SelectNoParens::generate(){
	GENERATESTART(1)

		opt_with_clause_ = new OptWithClause();
		opt_with_clause_->generate();
		select_clause_list_ = new SelectClauseList();
		select_clause_list_->generate();
		opt_order_clause_ = new OptOrderClause();
		opt_order_clause_->generate();
		opt_limit_clause_ = new OptLimitClause();
		opt_limit_clause_->generate();

	GENERATEEND
}



IR*  SelectClauseList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(select_clause_);
		res = new IR(kSelectClauseList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(select_clause_);
		auto tmp2= SAFETRANSLATE(combine_clause_);
		auto tmp3= SAFETRANSLATE(select_clause_list_);
		auto tmp4 = new IR(kUnknown, OP3("","",""), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kSelectClauseList, OP3("","",""), tmp4, tmp3);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void SelectClauseList::deep_delete(){
	SAFEDELETE(select_clause_list_);
	SAFEDELETE(combine_clause_);
	SAFEDELETE(select_clause_);
	delete this;
};

void SelectClauseList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		select_clause_ = new SelectClause();
		select_clause_->generate();
		CASEEND
		CASESTART(1)
		select_clause_ = new SelectClause();
		select_clause_->generate();
		combine_clause_ = new CombineClause();
		combine_clause_->generate();
		select_clause_list_ = new SelectClauseList();
		select_clause_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		select_clause_ = new SelectClause();
		select_clause_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  SelectClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_all_or_distinct_);
		auto tmp2= SAFETRANSLATE(select_target_);
		auto tmp3= SAFETRANSLATE(opt_cast_);
		auto tmp4= SAFETRANSLATE(opt_alias_0_);
		auto tmp5= SAFETRANSLATE(opt_from_clause_);
		auto tmp6= SAFETRANSLATE(opt_alias_1_);
		auto tmp7= SAFETRANSLATE(opt_where_clause_);
		auto tmp8= SAFETRANSLATE(opt_group_clause_);
		auto tmp9= SAFETRANSLATE(opt_window_clause_);
		auto tmp10 = new IR(kUnknown, OP3("SELECT","",""), tmp1, tmp2);
		PUSH(tmp10);
		auto tmp11 = new IR(kUnknown, OP3("","",""), tmp10, tmp3);
		PUSH(tmp11);
		auto tmp12 = new IR(kUnknown, OP3("","",""), tmp11, tmp4);
		PUSH(tmp12);
		auto tmp13 = new IR(kUnknown, OP3("","",""), tmp12, tmp5);
		PUSH(tmp13);
		auto tmp14 = new IR(kUnknown, OP3("","",""), tmp13, tmp6);
		PUSH(tmp14);
		auto tmp15 = new IR(kUnknown, OP3("","",""), tmp14, tmp7);
		PUSH(tmp15);
		auto tmp16 = new IR(kUnknown, OP3("","",""), tmp15, tmp8);
		PUSH(tmp16);
		res = new IR(kSelectClause, OP3("","",""), tmp16, tmp9);

	TRANSLATEEND
}

void SelectClause::deep_delete(){
	SAFEDELETE(opt_group_clause_);
	SAFEDELETE(opt_all_or_distinct_);
	SAFEDELETE(opt_from_clause_);
	SAFEDELETE(opt_window_clause_);
	SAFEDELETE(select_target_);
	SAFEDELETE(opt_where_clause_);
	SAFEDELETE(opt_alias_0_);
	SAFEDELETE(opt_alias_1_);
	SAFEDELETE(opt_cast_);
	delete this;
};

void SelectClause::generate(){
	GENERATESTART(1)

		opt_all_or_distinct_ = new OptAllOrDistinct();
		opt_all_or_distinct_->generate();
		select_target_ = new SelectTarget();
		select_target_->generate();
		opt_from_clause_ = new OptFromClause();
		opt_from_clause_->generate();
		opt_where_clause_ = new OptWhereClause();
		opt_where_clause_->generate();
		opt_group_clause_ = new OptGroupClause();
		opt_group_clause_->generate();
		opt_window_clause_ = new OptWindowClause();
		opt_window_clause_->generate();

	GENERATEEND
}



IR*  CombineClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kCombineClause, OP3("UNION","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kCombineClause, OP3("INTERSECT","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kCombineClause, OP3("EXCEPT","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CombineClause::deep_delete(){
	delete this;
};

void CombineClause::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptFromClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(from_clause_);
		res = new IR(kOptFromClause, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptFromClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptFromClause::deep_delete(){
	SAFEDELETE(from_clause_);
	delete this;
};

void OptFromClause::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		from_clause_ = new FromClause();
		from_clause_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  SelectTarget::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(expr_list_);
		res = new IR(kSelectTarget, OP3("","",""), tmp1);

	TRANSLATEEND
}

void SelectTarget::deep_delete(){
	SAFEDELETE(expr_list_);
	delete this;
};

void SelectTarget::generate(){
	GENERATESTART(1)

		expr_list_ = new ExprList();
		expr_list_->generate();

	GENERATEEND
}



IR*  OptWindowClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(window_clause_);
		res = new IR(kOptWindowClause, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptWindowClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptWindowClause::deep_delete(){
	SAFEDELETE(window_clause_);
	delete this;
};

void OptWindowClause::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		window_clause_ = new WindowClause();
		window_clause_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  WindowClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(window_def_list_);
		res = new IR(kWindowClause, OP3("WINDOW","",""), tmp1);

	TRANSLATEEND
}

void WindowClause::deep_delete(){
	SAFEDELETE(window_def_list_);
	delete this;
};

void WindowClause::generate(){
	GENERATESTART(1)

		window_def_list_ = new WindowDefList();
		window_def_list_->generate();

	GENERATEEND
}



IR*  WindowDefList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(window_def_);
		res = new IR(kWindowDefList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(window_def_);
		auto tmp2= SAFETRANSLATE(window_def_list_);
		res = new IR(kWindowDefList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void WindowDefList::deep_delete(){
	SAFEDELETE(window_def_);
	SAFEDELETE(window_def_list_);
	delete this;
};

void WindowDefList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		window_def_ = new WindowDef();
		window_def_->generate();
		CASEEND
		CASESTART(1)
		window_def_ = new WindowDef();
		window_def_->generate();
		window_def_list_ = new WindowDefList();
		window_def_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		window_def_ = new WindowDef();
		window_def_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  WindowDef::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(window_name_);
		auto tmp2= SAFETRANSLATE(window_);
		res = new IR(kWindowDef, OP3("","AS (",")"), tmp1, tmp2);

	TRANSLATEEND
}

void WindowDef::deep_delete(){
	SAFEDELETE(window_);
	SAFEDELETE(window_name_);
	delete this;
};

void WindowDef::generate(){
	GENERATESTART(1)

		window_name_ = new WindowName();
		window_name_->generate();
		window_ = new Window();
		window_->generate();

	GENERATEEND
}



IR*  WindowName::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(identifier_);
		res = new IR(kWindowName, OP3("","",""), tmp1);

	TRANSLATEEND
}

void WindowName::deep_delete(){
	SAFEDELETE(identifier_);
	delete this;
};

void WindowName::generate(){
	GENERATESTART(1)

		identifier_ = new Identifier();
		identifier_->generate();

	GENERATEEND
}



IR*  Window::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_exist_window_name_);
		auto tmp2= SAFETRANSLATE(opt_partition_);
		auto tmp3= SAFETRANSLATE(opt_order_clause_);
		auto tmp4= SAFETRANSLATE(opt_frame_clause_);
		auto tmp5 = new IR(kUnknown, OP3("","",""), tmp1, tmp2);
		PUSH(tmp5);
		auto tmp6 = new IR(kUnknown, OP3("","",""), tmp5, tmp3);
		PUSH(tmp6);
		res = new IR(kWindow, OP3("","",""), tmp6, tmp4);

	TRANSLATEEND
}

void Window::deep_delete(){
	SAFEDELETE(opt_exist_window_name_);
	SAFEDELETE(opt_frame_clause_);
	SAFEDELETE(opt_partition_);
	SAFEDELETE(opt_order_clause_);
	delete this;
};

void Window::generate(){
	GENERATESTART(1)

		opt_exist_window_name_ = new OptExistWindowName();
		opt_exist_window_name_->generate();
		opt_partition_ = new OptPartition();
		opt_partition_->generate();
		opt_order_clause_ = new OptOrderClause();
		opt_order_clause_->generate();
		opt_frame_clause_ = new OptFrameClause();
		opt_frame_clause_->generate();

	GENERATEEND
}



IR*  OptPartition::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_list_);
		res = new IR(kOptPartition, OP3("PARTITION BY","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptPartition, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptPartition::deep_delete(){
	SAFEDELETE(expr_list_);
	delete this;
};

void OptPartition::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		expr_list_ = new ExprList();
		expr_list_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptFrameClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(range_or_rows_);
		auto tmp2= SAFETRANSLATE(frame_bound_start_);
		auto tmp3= SAFETRANSLATE(opt_frame_exclude_);
		auto tmp4 = new IR(kUnknown, OP3("","",""), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kOptFrameClause, OP3("","",""), tmp4, tmp3);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(range_or_rows_);
		auto tmp2= SAFETRANSLATE(frame_bound_start_);
		auto tmp3= SAFETRANSLATE(frame_bound_end_);
		auto tmp4= SAFETRANSLATE(opt_frame_exclude_);
		auto tmp5 = new IR(kUnknown, OP3("","BETWEEN","AND"), tmp1, tmp2);
		PUSH(tmp5);
		auto tmp6 = new IR(kUnknown, OP3("","",""), tmp5, tmp3);
		PUSH(tmp6);
		res = new IR(kOptFrameClause, OP3("","",""), tmp6, tmp4);
		CASEEND
		CASESTART(2)
		res = new IR(kOptFrameClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptFrameClause::deep_delete(){
	SAFEDELETE(frame_bound_start_);
	SAFEDELETE(opt_frame_exclude_);
	SAFEDELETE(range_or_rows_);
	SAFEDELETE(frame_bound_end_);
	delete this;
};

void OptFrameClause::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		range_or_rows_ = new RangeOrRows();
		range_or_rows_->generate();
		frame_bound_start_ = new FrameBoundStart();
		frame_bound_start_->generate();
		opt_frame_exclude_ = new OptFrameExclude();
		opt_frame_exclude_->generate();
		CASEEND
		CASESTART(1)
		range_or_rows_ = new RangeOrRows();
		range_or_rows_->generate();
		frame_bound_start_ = new FrameBoundStart();
		frame_bound_start_->generate();
		frame_bound_end_ = new FrameBoundEnd();
		frame_bound_end_->generate();
		opt_frame_exclude_ = new OptFrameExclude();
		opt_frame_exclude_->generate();
		CASEEND
		CASESTART(2)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  RangeOrRows::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kRangeOrRows, OP3("RANGE","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kRangeOrRows, OP3("ROWS","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kRangeOrRows, OP3("GROUPS","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void RangeOrRows::deep_delete(){
	delete this;
};

void RangeOrRows::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  FrameBoundStart::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(frame_bound_);
		res = new IR(kFrameBoundStart, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kFrameBoundStart, OP3("UNBOUNDED PRECEDING","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void FrameBoundStart::deep_delete(){
	SAFEDELETE(frame_bound_);
	delete this;
};

void FrameBoundStart::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		frame_bound_ = new FrameBound();
		frame_bound_->generate();
		CASEEND
		CASESTART(1)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  FrameBoundEnd::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(frame_bound_);
		res = new IR(kFrameBoundEnd, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kFrameBoundEnd, OP3("UNBOUNDED FOLLOWING","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void FrameBoundEnd::deep_delete(){
	SAFEDELETE(frame_bound_);
	delete this;
};

void FrameBoundEnd::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		frame_bound_ = new FrameBound();
		frame_bound_->generate();
		CASEEND
		CASESTART(1)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  FrameBound::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_);
		res = new IR(kFrameBound, OP3("","PRECEDING",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(expr_);
		res = new IR(kFrameBound, OP3("","FOLLOWING",""), tmp1);
		CASEEND
		CASESTART(2)
		res = new IR(kFrameBound, OP3("CURRENT ROW","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void FrameBound::deep_delete(){
	SAFEDELETE(expr_);
	delete this;
};

void FrameBound::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		expr_ = new Expr();
		expr_->generate();
		CASEEND
		CASESTART(1)
		expr_ = new Expr();
		expr_->generate();
		CASEEND
		CASESTART(2)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptFrameExclude::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(frame_exclude_);
		res = new IR(kOptFrameExclude, OP3("EXCLUDE","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptFrameExclude, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptFrameExclude::deep_delete(){
	SAFEDELETE(frame_exclude_);
	delete this;
};

void OptFrameExclude::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		frame_exclude_ = new FrameExclude();
		frame_exclude_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  FrameExclude::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kFrameExclude, OP3("NO OTHERS","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kFrameExclude, OP3("CURRENT ROW","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kFrameExclude, OP3("GROUP","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kFrameExclude, OP3("TIES","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void FrameExclude::deep_delete(){
	delete this;
};

void FrameExclude::generate(){
	GENERATESTART(4)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptExistWindowName::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(identifier_);
		res = new IR(kOptExistWindowName, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptExistWindowName, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptExistWindowName::deep_delete(){
	SAFEDELETE(identifier_);
	delete this;
};

void OptExistWindowName::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		identifier_ = new Identifier();
		identifier_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptGroupClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_list_);
		auto tmp2= SAFETRANSLATE(opt_having_clause_);
		res = new IR(kOptGroupClause, OP3("GROUP BY","",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		res = new IR(kOptGroupClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptGroupClause::deep_delete(){
	SAFEDELETE(expr_list_);
	SAFEDELETE(opt_having_clause_);
	delete this;
};

void OptGroupClause::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		expr_list_ = new ExprList();
		expr_list_->generate();
		opt_having_clause_ = new OptHavingClause();
		opt_having_clause_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptHavingClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_);
		res = new IR(kOptHavingClause, OP3("HAVING","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptHavingClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptHavingClause::deep_delete(){
	SAFEDELETE(expr_);
	delete this;
};

void OptHavingClause::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		expr_ = new Expr();
		expr_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptWhereClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(where_clause_);
		res = new IR(kOptWhereClause, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptWhereClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptWhereClause::deep_delete(){
	SAFEDELETE(where_clause_);
	delete this;
};

void OptWhereClause::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		where_clause_ = new WhereClause();
		where_clause_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  WhereClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(expr_);
		res = new IR(kWhereClause, OP3("WHERE","",""), tmp1);

	TRANSLATEEND
}

void WhereClause::deep_delete(){
	SAFEDELETE(expr_);
	delete this;
};

void WhereClause::generate(){
	GENERATESTART(1)

		expr_ = new Expr();
		expr_->generate();

	GENERATEEND
}



IR*  FromClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(table_ref_);
		res = new IR(kFromClause, OP3("FROM","",""), tmp1);

	TRANSLATEEND
}

void FromClause::deep_delete(){
	SAFEDELETE(table_ref_);
	delete this;
};

void FromClause::generate(){
	GENERATESTART(1)

		table_ref_ = new TableRef();
		table_ref_->generate();

	GENERATEEND
}



IR*  TableRef::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(opt_table_prefix_);
		auto tmp2= SAFETRANSLATE(table_name_);
		auto tmp3= SAFETRANSLATE(opt_on_or_using_);
		auto tmp4 = new IR(kUnknown, OP3("","",""), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kTableRef, OP3("","",""), tmp4, tmp3);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(opt_table_prefix_);
		auto tmp2= SAFETRANSLATE(select_no_parens_);
		auto tmp3= SAFETRANSLATE(opt_on_or_using_);
		auto tmp4 = new IR(kUnknown, OP3("","(",")"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kTableRef, OP3("","",""), tmp4, tmp3);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(opt_table_prefix_);
		auto tmp2= SAFETRANSLATE(table_ref_);
		auto tmp3= SAFETRANSLATE(opt_on_or_using_);
		auto tmp4 = new IR(kUnknown, OP3("","(",")"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kTableRef, OP3("","",""), tmp4, tmp3);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void TableRef::deep_delete(){
	SAFEDELETE(select_no_parens_);
	SAFEDELETE(table_ref_);
	SAFEDELETE(table_name_);
	SAFEDELETE(opt_table_prefix_);
	SAFEDELETE(opt_on_or_using_);
	delete this;
};

void TableRef::generate(){
	GENERATESTART(300)

	SWITCHSTART
		CASESTART(0)
		opt_table_prefix_ = new OptTablePrefix();
		opt_table_prefix_->generate();
		table_name_ = new TableName();
		table_name_->generate();
		opt_on_or_using_ = new OptOnOrUsing();
		opt_on_or_using_->generate();
		CASEEND
		CASESTART(1)
		opt_table_prefix_ = new OptTablePrefix();
		opt_table_prefix_->generate();
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();
		opt_on_or_using_ = new OptOnOrUsing();
		opt_on_or_using_->generate();
		CASEEND
		CASESTART(2)
		opt_table_prefix_ = new OptTablePrefix();
		opt_table_prefix_->generate();
		table_ref_ = new TableRef();
		table_ref_->generate();
		opt_on_or_using_ = new OptOnOrUsing();
		opt_on_or_using_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 2;
        switch(tmp_case_idx){
            CASESTART(0)
		opt_table_prefix_ = new OptTablePrefix();
		opt_table_prefix_->generate();
		table_name_ = new TableName();
		table_name_->generate();
		opt_on_or_using_ = new OptOnOrUsing();
		opt_on_or_using_->generate();
case_idx_ = 0;
CASEEND
CASESTART(1)
		opt_table_prefix_ = new OptTablePrefix();
		opt_table_prefix_->generate();
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();
		opt_on_or_using_ = new OptOnOrUsing();
		opt_on_or_using_->generate();
case_idx_ = 1;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  OptOnOrUsing::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(on_or_using_);
		res = new IR(kOptOnOrUsing, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptOnOrUsing, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptOnOrUsing::deep_delete(){
	SAFEDELETE(on_or_using_);
	delete this;
};

void OptOnOrUsing::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		on_or_using_ = new OnOrUsing();
		on_or_using_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OnOrUsing::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_);
		res = new IR(kOnOrUsing, OP3("ON","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(column_name_list_);
		res = new IR(kOnOrUsing, OP3("USING (",")",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OnOrUsing::deep_delete(){
	SAFEDELETE(expr_);
	SAFEDELETE(column_name_list_);
	delete this;
};

void OnOrUsing::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		expr_ = new Expr();
		expr_->generate();
		CASEEND
		CASESTART(1)
		column_name_list_ = new ColumnNameList();
		column_name_list_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ColumnNameList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(column_name_);
		res = new IR(kColumnNameList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(column_name_);
		auto tmp2= SAFETRANSLATE(column_name_list_);
		res = new IR(kColumnNameList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void ColumnNameList::deep_delete(){
	SAFEDELETE(column_name_list_);
	SAFEDELETE(column_name_);
	delete this;
};

void ColumnNameList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		column_name_ = new ColumnName();
		column_name_->generate();
		CASEEND
		CASESTART(1)
		column_name_ = new ColumnName();
		column_name_->generate();
		column_name_list_ = new ColumnNameList();
		column_name_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		column_name_ = new ColumnName();
		column_name_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  OptTablePrefix::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(table_ref_);
		auto tmp2= SAFETRANSLATE(join_op_);
		res = new IR(kOptTablePrefix, OP3("","",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		res = new IR(kOptTablePrefix, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptTablePrefix::deep_delete(){
	SAFEDELETE(join_op_);
	SAFEDELETE(table_ref_);
	delete this;
};

void OptTablePrefix::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		table_ref_ = new TableRef();
		table_ref_->generate();
		join_op_ = new JoinOp();
		join_op_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  JoinOp::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kJoinOp, OP3(",","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kJoinOp, OP3("JOIN","",""));
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(opt_join_type_);
		res = new IR(kJoinOp, OP3("NATURAL","JOIN",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void JoinOp::deep_delete(){
	SAFEDELETE(opt_join_type_);
	delete this;
};

void JoinOp::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		opt_join_type_ = new OptJoinType();
		opt_join_type_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptJoinType::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptJoinType, OP3("LEFT","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptJoinType, OP3("LEFT OUTER","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kOptJoinType, OP3("INNER","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kOptJoinType, OP3("CROSS","",""));
		CASEEND
		CASESTART(4)
		res = new IR(kOptJoinType, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptJoinType::deep_delete(){
	delete this;
};

void OptJoinType::generate(){
	GENERATESTART(5)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		CASEEND
		CASESTART(4)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ExprList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_);
		auto tmp2= SAFETRANSLATE(expr_list_);
		res = new IR(kExprList, OP3("",",",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(expr_);
		res = new IR(kExprList, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void ExprList::deep_delete(){
	SAFEDELETE(expr_);
	SAFEDELETE(expr_list_);
	delete this;
};

void ExprList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		expr_ = new Expr();
		expr_->generate();
		expr_list_ = new ExprList();
		expr_list_->generate();
		CASEEND
		CASESTART(1)
		expr_ = new Expr();
		expr_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		expr_ = new Expr();
		expr_->generate();
case_idx_ = 1;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  OptLimitClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(limit_clause_);
		res = new IR(kOptLimitClause, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptLimitClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptLimitClause::deep_delete(){
	SAFEDELETE(limit_clause_);
	delete this;
};

void OptLimitClause::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		limit_clause_ = new LimitClause();
		limit_clause_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  LimitClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_1_);
		res = new IR(kLimitClause, OP3("LIMIT","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(expr_1_);
		auto tmp2= SAFETRANSLATE(expr_2_);
		res = new IR(kLimitClause, OP3("LIMIT","OFFSET",""), tmp1, tmp2);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(expr_1_);
		auto tmp2= SAFETRANSLATE(expr_2_);
		res = new IR(kLimitClause, OP3("LIMIT",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void LimitClause::deep_delete(){
	SAFEDELETE(expr_1_);
	SAFEDELETE(expr_2_);
	delete this;
};

void LimitClause::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		expr_1_ = new Expr();
		expr_1_->generate();
		CASEEND
		CASESTART(1)
		expr_1_ = new Expr();
		expr_1_->generate();
		expr_2_ = new Expr();
		expr_2_->generate();
		CASEEND
		CASESTART(2)
		expr_1_ = new Expr();
		expr_1_->generate();
		expr_2_ = new Expr();
		expr_2_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptOrderClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(order_item_list_);
		res = new IR(kOptOrderClause, OP3("ORDER BY","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptOrderClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptOrderClause::deep_delete(){
	SAFEDELETE(order_item_list_);
	delete this;
};

void OptOrderClause::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		order_item_list_ = new OrderItemList();
		order_item_list_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptOrderNulls::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptOrderNulls, OP3("NULLS FIRST","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptOrderNulls, OP3("NULLS LAST","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kOptOrderNulls, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptOrderNulls::deep_delete(){
	delete this;
};

void OptOrderNulls::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OrderItemList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(order_item_);
		res = new IR(kOrderItemList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(order_item_);
		auto tmp2= SAFETRANSLATE(order_item_list_);
		res = new IR(kOrderItemList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OrderItemList::deep_delete(){
	SAFEDELETE(order_item_);
	SAFEDELETE(order_item_list_);
	delete this;
};

void OrderItemList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		order_item_ = new OrderItem();
		order_item_->generate();
		CASEEND
		CASESTART(1)
		order_item_ = new OrderItem();
		order_item_->generate();
		order_item_list_ = new OrderItemList();
		order_item_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		order_item_ = new OrderItem();
		order_item_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  OrderItem::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(expr_);
		auto tmp2= SAFETRANSLATE(opt_order_behavior_);
		auto tmp3= SAFETRANSLATE(opt_order_nulls_);
		auto tmp4 = new IR(kUnknown, OP3("","",""), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kOrderItem, OP3("","",""), tmp4, tmp3);

	TRANSLATEEND
}

void OrderItem::deep_delete(){
	SAFEDELETE(expr_);
	SAFEDELETE(opt_order_nulls_);
	SAFEDELETE(opt_order_behavior_);
	delete this;
};

void OrderItem::generate(){
	GENERATESTART(1)

		expr_ = new Expr();
		expr_->generate();
		opt_order_behavior_ = new OptOrderBehavior();
		opt_order_behavior_->generate();
		opt_order_nulls_ = new OptOrderNulls();
		opt_order_nulls_->generate();

	GENERATEEND
}



IR*  OptOrderBehavior::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptOrderBehavior, OP3("ASC","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptOrderBehavior, OP3("DESC","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kOptOrderBehavior, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptOrderBehavior::deep_delete(){
	delete this;
};

void OptOrderBehavior::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptWithClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(cte_table_list_);
		res = new IR(kOptWithClause, OP3("WITH","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(cte_table_list_);
		res = new IR(kOptWithClause, OP3("WITH RECURSIVE","",""), tmp1);
		CASEEND
		CASESTART(2)
		res = new IR(kOptWithClause, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptWithClause::deep_delete(){
	SAFEDELETE(cte_table_list_);
	delete this;
};

void OptWithClause::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		cte_table_list_ = new CteTableList();
		cte_table_list_->generate();
		CASEEND
		CASESTART(1)
		cte_table_list_ = new CteTableList();
		cte_table_list_->generate();
		CASEEND
		CASESTART(2)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  CteTableList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(cte_table_);
		res = new IR(kCteTableList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(cte_table_);
		auto tmp2= SAFETRANSLATE(cte_table_list_);
		res = new IR(kCteTableList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CteTableList::deep_delete(){
	SAFEDELETE(cte_table_list_);
	SAFEDELETE(cte_table_);
	delete this;
};

void CteTableList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		cte_table_ = new CteTable();
		cte_table_->generate();
		CASEEND
		CASESTART(1)
		cte_table_ = new CteTable();
		cte_table_->generate();
		cte_table_list_ = new CteTableList();
		cte_table_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		cte_table_ = new CteTable();
		cte_table_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  CteTable::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(cte_table_name_);
		auto tmp2= SAFETRANSLATE(select_stmt_);
		res = new IR(kCteTable, OP3("","AS (",")"), tmp1, tmp2);

	TRANSLATEEND
}

void CteTable::deep_delete(){
	SAFEDELETE(cte_table_name_);
	SAFEDELETE(select_stmt_);
	delete this;
};

void CteTable::generate(){
	GENERATESTART(1)

		cte_table_name_ = new CteTableName();
		cte_table_name_->generate();
		select_stmt_ = new SelectStmt();
		select_stmt_->generate();

	GENERATEEND
}



IR*  CteTableName::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(table_name_);
		auto tmp2= SAFETRANSLATE(opt_column_name_list_p_);
		res = new IR(kCteTableName, OP3("","",""), tmp1, tmp2);

	TRANSLATEEND
}

void CteTableName::deep_delete(){
	SAFEDELETE(opt_column_name_list_p_);
	SAFEDELETE(table_name_);
	delete this;
};

void CteTableName::generate(){
	GENERATESTART(1)

		table_name_ = new TableName();
		table_name_->generate();
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();

	GENERATEEND
}



IR*  OptAllOrDistinct::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptAllOrDistinct, OP3("ALL","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptAllOrDistinct, OP3("DISTINCT","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kOptAllOrDistinct, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptAllOrDistinct::deep_delete(){
	delete this;
};

void OptAllOrDistinct::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  CreateTableStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(opt_temp_);
		auto tmp2= SAFETRANSLATE(opt_if_not_exist_);
		auto tmp3= SAFETRANSLATE(table_name_);
		auto tmp4= SAFETRANSLATE(select_stmt_);
		auto tmp5 = new IR(kUnknown, OP3("CREATE","TABLE",""), tmp1, tmp2);
		PUSH(tmp5);
		auto tmp6 = new IR(kUnknown, OP3("","","AS"), tmp5, tmp3);
		PUSH(tmp6);
		res = new IR(kCreateTableStmt, OP3("","",""), tmp6, tmp4);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(opt_temp_);
		auto tmp2= SAFETRANSLATE(opt_if_not_exist_);
		auto tmp3= SAFETRANSLATE(table_name_);
		auto tmp4= SAFETRANSLATE(column_def_list_);
		auto tmp5= SAFETRANSLATE(opt_table_constraint_list_);
		auto tmp6 = new IR(kUnknown, OP3("CREATE","TABLE",""), tmp1, tmp2);
		PUSH(tmp6);
		auto tmp7 = new IR(kUnknown, OP3("","","("), tmp6, tmp3);
		PUSH(tmp7);
		auto tmp8 = new IR(kUnknown, OP3("","",""), tmp7, tmp4);
		PUSH(tmp8);
		res = new IR(kCreateTableStmt, OP3("","",")"), tmp8, tmp5);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CreateTableStmt::deep_delete(){
	SAFEDELETE(opt_table_constraint_list_);
	SAFEDELETE(opt_temp_);
	SAFEDELETE(select_stmt_);
	SAFEDELETE(table_name_);
	SAFEDELETE(column_def_list_);
	SAFEDELETE(opt_if_not_exist_);
	delete this;
};

void CreateTableStmt::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		opt_temp_ = new OptTemp();
		opt_temp_->generate();
		opt_if_not_exist_ = new OptIfNotExist();
		opt_if_not_exist_->generate();
		table_name_ = new TableName();
		table_name_->generate();
		select_stmt_ = new SelectStmt();
		select_stmt_->generate();
		CASEEND
		CASESTART(1)
		opt_temp_ = new OptTemp();
		opt_temp_->generate();
		opt_if_not_exist_ = new OptIfNotExist();
		opt_if_not_exist_->generate();
		table_name_ = new TableName();
		table_name_->generate();
		column_def_list_ = new ColumnDefList();
		column_def_list_->generate();
		opt_table_constraint_list_ = new OptTableConstraintList();
		opt_table_constraint_list_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  CreateIndexStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_unique_);
		auto tmp2= SAFETRANSLATE(opt_if_not_exist_);
		auto tmp3= SAFETRANSLATE(table_name_1_);
		auto tmp4= SAFETRANSLATE(table_name_2_);
		auto tmp5= SAFETRANSLATE(indexed_column_list_);
		auto tmp6= SAFETRANSLATE(opt_where_clause_);
		auto tmp7 = new IR(kUnknown, OP3("CREATE","INDEX",""), tmp1, tmp2);
		PUSH(tmp7);
		auto tmp8 = new IR(kUnknown, OP3("","","ON"), tmp7, tmp3);
		PUSH(tmp8);
		auto tmp9 = new IR(kUnknown, OP3("","","("), tmp8, tmp4);
		PUSH(tmp9);
		auto tmp10 = new IR(kUnknown, OP3("","",")"), tmp9, tmp5);
		PUSH(tmp10);
		res = new IR(kCreateIndexStmt, OP3("","",""), tmp10, tmp6);

	TRANSLATEEND
}

void CreateIndexStmt::deep_delete(){
	SAFEDELETE(table_name_1_);
	SAFEDELETE(table_name_2_);
	SAFEDELETE(opt_if_not_exist_);
	SAFEDELETE(indexed_column_list_);
	SAFEDELETE(opt_where_clause_);
	SAFEDELETE(opt_unique_);
	delete this;
};

void CreateIndexStmt::generate(){
	GENERATESTART(1)

		opt_unique_ = new OptUnique();
		opt_unique_->generate();
		opt_if_not_exist_ = new OptIfNotExist();
		opt_if_not_exist_->generate();
		table_name_1_ = new TableName();
		table_name_1_->generate();
		table_name_2_ = new TableName();
		table_name_2_->generate();
		indexed_column_list_ = new IndexedColumnList();
		indexed_column_list_->generate();
		opt_where_clause_ = new OptWhereClause();
		opt_where_clause_->generate();

	GENERATEEND
}



IR*  CreateViewStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(opt_temp_);
		auto tmp2= SAFETRANSLATE(view_name_);
		auto tmp3= SAFETRANSLATE(opt_column_name_list_p_);
		auto tmp4= SAFETRANSLATE(select_stmt_);
		auto tmp5= SAFETRANSLATE(opt_check_option_);
		auto tmp6 = new IR(kUnknown, OP3("CREATE","VIEW",""), tmp1, tmp2);
		PUSH(tmp6);
		auto tmp7 = new IR(kUnknown, OP3("","","AS"), tmp6, tmp3);
		PUSH(tmp7);
		auto tmp8 = new IR(kUnknown, OP3("","",""), tmp7, tmp4);
		PUSH(tmp8);
		res = new IR(kCreateViewStmt, OP3("","",""), tmp8, tmp5);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(opt_temp_);
		auto tmp2= SAFETRANSLATE(view_name_);
		auto tmp3= SAFETRANSLATE(opt_column_name_list_p_);
		auto tmp4= SAFETRANSLATE(select_stmt_);
		auto tmp5= SAFETRANSLATE(opt_check_option_);
		auto tmp6 = new IR(kUnknown, OP3("CREATE","RECURSIVE VIEW",""), tmp1, tmp2);
		PUSH(tmp6);
		auto tmp7 = new IR(kUnknown, OP3("","","AS"), tmp6, tmp3);
		PUSH(tmp7);
		auto tmp8 = new IR(kUnknown, OP3("","",""), tmp7, tmp4);
		PUSH(tmp8);
		res = new IR(kCreateViewStmt, OP3("","",""), tmp8, tmp5);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(opt_temp_);
		auto tmp2= SAFETRANSLATE(view_name_);
		auto tmp3= SAFETRANSLATE(opt_column_name_list_p_);
		auto tmp4= SAFETRANSLATE(select_stmt_);
		auto tmp5= SAFETRANSLATE(opt_check_option_);
		auto tmp6 = new IR(kUnknown, OP3("CREATE OR REPLACE","VIEW",""), tmp1, tmp2);
		PUSH(tmp6);
		auto tmp7 = new IR(kUnknown, OP3("","","AS"), tmp6, tmp3);
		PUSH(tmp7);
		auto tmp8 = new IR(kUnknown, OP3("","",""), tmp7, tmp4);
		PUSH(tmp8);
		res = new IR(kCreateViewStmt, OP3("","",""), tmp8, tmp5);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(opt_temp_);
		auto tmp2= SAFETRANSLATE(view_name_);
		auto tmp3= SAFETRANSLATE(opt_column_name_list_p_);
		auto tmp4= SAFETRANSLATE(select_stmt_);
		auto tmp5= SAFETRANSLATE(opt_check_option_);
		auto tmp6 = new IR(kUnknown, OP3("CREATE OR REPLACE","RECURSIVE VIEW",""), tmp1, tmp2);
		PUSH(tmp6);
		auto tmp7 = new IR(kUnknown, OP3("","","AS"), tmp6, tmp3);
		PUSH(tmp7);
		auto tmp8 = new IR(kUnknown, OP3("","",""), tmp7, tmp4);
		PUSH(tmp8);
		res = new IR(kCreateViewStmt, OP3("","",""), tmp8, tmp5);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CreateViewStmt::deep_delete(){
	SAFEDELETE(opt_temp_);
	SAFEDELETE(view_name_);
	SAFEDELETE(opt_column_name_list_p_);
	SAFEDELETE(select_stmt_);
	SAFEDELETE(opt_check_option_);
	delete this;
};

void CreateViewStmt::generate(){
	GENERATESTART(4)

	SWITCHSTART
		CASESTART(0)
		opt_temp_ = new OptTemp();
		opt_temp_->generate();
		view_name_ = new ViewName();
		view_name_->generate();
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();
		select_stmt_ = new SelectStmt();
		select_stmt_->generate();
		opt_check_option_ = new OptCheckOption();
		opt_check_option_->generate();
		CASEEND
		CASESTART(1)
		opt_temp_ = new OptTemp();
		opt_temp_->generate();
		view_name_ = new ViewName();
		view_name_->generate();
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();
		select_stmt_ = new SelectStmt();
		select_stmt_->generate();
		opt_check_option_ = new OptCheckOption();
		opt_check_option_->generate();
		CASEEND
		CASESTART(2)
		opt_temp_ = new OptTemp();
		opt_temp_->generate();
		view_name_ = new ViewName();
		view_name_->generate();
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();
		select_stmt_ = new SelectStmt();
		select_stmt_->generate();
		opt_check_option_ = new OptCheckOption();
		opt_check_option_->generate();
		CASEEND
		CASESTART(3)
		opt_temp_ = new OptTemp();
		opt_temp_->generate();
		view_name_ = new ViewName();
		view_name_->generate();
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();
		select_stmt_ = new SelectStmt();
		select_stmt_->generate();
		opt_check_option_ = new OptCheckOption();
		opt_check_option_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  DropIndexStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_if_exist_);
		auto tmp2= SAFETRANSLATE(table_name_);
		res = new IR(kDropIndexStmt, OP3("DROP INDEX","",""), tmp1, tmp2);

	TRANSLATEEND
}

void DropIndexStmt::deep_delete(){
	SAFEDELETE(table_name_);
	SAFEDELETE(opt_if_exist_);
	delete this;
};

void DropIndexStmt::generate(){
	GENERATESTART(1)

		opt_if_exist_ = new OptIfExist();
		opt_if_exist_->generate();
		table_name_ = new TableName();
		table_name_->generate();

	GENERATEEND
}



IR*  DropTableStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_if_exist_);
		auto tmp2= SAFETRANSLATE(table_name_);
		res = new IR(kDropTableStmt, OP3("DROP TABLE","",""), tmp1, tmp2);

	TRANSLATEEND
}

void DropTableStmt::deep_delete(){
	SAFEDELETE(table_name_);
	SAFEDELETE(opt_if_exist_);
	delete this;
};

void DropTableStmt::generate(){
	GENERATESTART(1)

		opt_if_exist_ = new OptIfExist();
		opt_if_exist_->generate();
		table_name_ = new TableName();
		table_name_->generate();

	GENERATEEND
}



IR*  DropViewStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_if_exist_);
		auto tmp2= SAFETRANSLATE(view_name_);
		res = new IR(kDropViewStmt, OP3("DROP VIEW","",""), tmp1, tmp2);

	TRANSLATEEND
}

void DropViewStmt::deep_delete(){
	SAFEDELETE(view_name_);
	SAFEDELETE(opt_if_exist_);
	delete this;
};

void DropViewStmt::generate(){
	GENERATESTART(1)

		opt_if_exist_ = new OptIfExist();
		opt_if_exist_->generate();
		view_name_ = new ViewName();
		view_name_->generate();

	GENERATEEND
}



IR*  InsertStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_with_clause_);
		auto tmp2= SAFETRANSLATE(table_name_);
		auto tmp3= SAFETRANSLATE(insert_rest_);
		auto tmp4= SAFETRANSLATE(opt_on_conflict_);
		auto tmp5 = new IR(kUnknown, OP3("","INSERT INTO",""), tmp1, tmp2);
		PUSH(tmp5);
		auto tmp6 = new IR(kUnknown, OP3("","",""), tmp5, tmp3);
		PUSH(tmp6);
		res = new IR(kInsertStmt, OP3("","",""), tmp6, tmp4);

	TRANSLATEEND
}

void InsertStmt::deep_delete(){
	SAFEDELETE(insert_rest_);
	SAFEDELETE(table_name_);
	SAFEDELETE(opt_on_conflict_);
	SAFEDELETE(opt_with_clause_);
	delete this;
};

void InsertStmt::generate(){
	GENERATESTART(1)

		opt_with_clause_ = new OptWithClause();
		opt_with_clause_->generate();
		table_name_ = new TableName();
		table_name_->generate();
		insert_rest_ = new InsertRest();
		insert_rest_->generate();
		opt_on_conflict_ = new OptOnConflict();
		opt_on_conflict_->generate();

	GENERATEEND
}



IR*  InsertRest::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(opt_column_name_list_p_);
		auto tmp2= SAFETRANSLATE(select_no_parens_);
		res = new IR(kInsertRest, OP3("","",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(opt_column_name_list_p_);
		res = new IR(kInsertRest, OP3("","DEFAULT VALUES",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(opt_column_name_list_p_);
		auto tmp2= SAFETRANSLATE(super_values_list_);
		res = new IR(kInsertRest, OP3("","VALUES",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void InsertRest::deep_delete(){
	SAFEDELETE(opt_column_name_list_p_);
	SAFEDELETE(super_values_list_);
	SAFEDELETE(select_no_parens_);
	delete this;
};

void InsertRest::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();
		CASEEND
		CASESTART(1)
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();
		CASEEND
		CASESTART(2)
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();
		super_values_list_ = new SuperValuesList();
		super_values_list_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  SuperValuesList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(values_list_);
		res = new IR(kSuperValuesList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(values_list_);
		auto tmp2= SAFETRANSLATE(super_values_list_);
		res = new IR(kSuperValuesList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void SuperValuesList::deep_delete(){
	SAFEDELETE(values_list_);
	SAFEDELETE(super_values_list_);
	delete this;
};

void SuperValuesList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		values_list_ = new ValuesList();
		values_list_->generate();
		CASEEND
		CASESTART(1)
		values_list_ = new ValuesList();
		values_list_->generate();
		super_values_list_ = new SuperValuesList();
		super_values_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		values_list_ = new ValuesList();
		values_list_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  ValuesList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(expr_list_);
		res = new IR(kValuesList, OP3("(",")",""), tmp1);

	TRANSLATEEND
}

void ValuesList::deep_delete(){
	SAFEDELETE(expr_list_);
	delete this;
};

void ValuesList::generate(){
	GENERATESTART(1)

		expr_list_ = new ExprList();
		expr_list_->generate();

	GENERATEEND
}



IR*  OptOnConflict::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(opt_conflict_expr_);
		res = new IR(kOptOnConflict, OP3("ON CONFLICT","DO NOTHING",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(opt_conflict_expr_);
		auto tmp2= SAFETRANSLATE(set_clause_list_);
		auto tmp3= SAFETRANSLATE(where_clause_);
		auto tmp4 = new IR(kUnknown, OP3("ON CONFLICT","DO UPDATE",""), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kOptOnConflict, OP3("","",""), tmp4, tmp3);
		CASEEND
		CASESTART(2)
		res = new IR(kOptOnConflict, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptOnConflict::deep_delete(){
	SAFEDELETE(opt_conflict_expr_);
	SAFEDELETE(set_clause_list_);
	SAFEDELETE(where_clause_);
	delete this;
};

void OptOnConflict::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		opt_conflict_expr_ = new OptConflictExpr();
		opt_conflict_expr_->generate();
		CASEEND
		CASESTART(1)
		opt_conflict_expr_ = new OptConflictExpr();
		opt_conflict_expr_->generate();
		set_clause_list_ = new SetClauseList();
		set_clause_list_->generate();
		where_clause_ = new WhereClause();
		where_clause_->generate();
		CASEEND
		CASESTART(2)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptConflictExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(indexed_column_list_);
		auto tmp2= SAFETRANSLATE(where_clause_);
		res = new IR(kOptConflictExpr, OP3("(",")",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		res = new IR(kOptConflictExpr, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptConflictExpr::deep_delete(){
	SAFEDELETE(indexed_column_list_);
	SAFEDELETE(where_clause_);
	delete this;
};

void OptConflictExpr::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		indexed_column_list_ = new IndexedColumnList();
		indexed_column_list_->generate();
		where_clause_ = new WhereClause();
		where_clause_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  IndexedColumnList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(indexed_column_);
		res = new IR(kIndexedColumnList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(indexed_column_);
		auto tmp2= SAFETRANSLATE(indexed_column_list_);
		res = new IR(kIndexedColumnList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void IndexedColumnList::deep_delete(){
	SAFEDELETE(indexed_column_);
	SAFEDELETE(indexed_column_list_);
	delete this;
};

void IndexedColumnList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		indexed_column_ = new IndexedColumn();
		indexed_column_->generate();
		CASEEND
		CASESTART(1)
		indexed_column_ = new IndexedColumn();
		indexed_column_->generate();
		indexed_column_list_ = new IndexedColumnList();
		indexed_column_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		indexed_column_ = new IndexedColumn();
		indexed_column_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  IndexedColumn::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(expr_);
		auto tmp2= SAFETRANSLATE(opt_order_behavior_);
		res = new IR(kIndexedColumn, OP3("","",""), tmp1, tmp2);

	TRANSLATEEND
}

void IndexedColumn::deep_delete(){
	SAFEDELETE(expr_);
	SAFEDELETE(opt_order_behavior_);
	delete this;
};

void IndexedColumn::generate(){
	GENERATESTART(1)

		expr_ = new Expr();
		expr_->generate();
		opt_order_behavior_ = new OptOrderBehavior();
		opt_order_behavior_->generate();

	GENERATEEND
}



IR*  UpdateStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_with_clause_);
		auto tmp2= SAFETRANSLATE(table_name_);
		auto tmp3= SAFETRANSLATE(set_clause_list_);
		auto tmp4= SAFETRANSLATE(opt_where_clause_);
		auto tmp5 = new IR(kUnknown, OP3("","UPDATE","SET"), tmp1, tmp2);
		PUSH(tmp5);
		auto tmp6 = new IR(kUnknown, OP3("","",""), tmp5, tmp3);
		PUSH(tmp6);
		res = new IR(kUpdateStmt, OP3("","",""), tmp6, tmp4);

	TRANSLATEEND
}

void UpdateStmt::deep_delete(){
	SAFEDELETE(table_name_);
	SAFEDELETE(set_clause_list_);
	SAFEDELETE(opt_with_clause_);
	SAFEDELETE(opt_where_clause_);
	delete this;
};

void UpdateStmt::generate(){
	GENERATESTART(1)

		opt_with_clause_ = new OptWithClause();
		opt_with_clause_->generate();
		table_name_ = new TableName();
		table_name_->generate();
		set_clause_list_ = new SetClauseList();
		set_clause_list_->generate();
		opt_where_clause_ = new OptWhereClause();
		opt_where_clause_->generate();

	GENERATEEND
}



IR*  ReindexStmt::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(table_name_);
		res = new IR(kReindexStmt, OP3("REINDEX TABLE","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(table_name_);
		res = new IR(kReindexStmt, OP3("REINDEX INDEX","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void ReindexStmt::deep_delete(){
	SAFEDELETE(table_name_);
	delete this;
};

void ReindexStmt::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		table_name_ = new TableName();
		table_name_->generate();
		CASEEND
		CASESTART(1)
		table_name_ = new TableName();
		table_name_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  AlterAction::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(table_name_);
		res = new IR(kAlterAction, OP3("RENAME TO","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(opt_column_);
		auto tmp2= SAFETRANSLATE(column_name_1_);
		auto tmp3= SAFETRANSLATE(column_name_2_);
		auto tmp4 = new IR(kUnknown, OP3("RENAME","","TO"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kAlterAction, OP3("","",""), tmp4, tmp3);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(opt_column_);
		auto tmp2= SAFETRANSLATE(column_def_);
		res = new IR(kAlterAction, OP3("ADD","",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void AlterAction::deep_delete(){
	SAFEDELETE(column_def_);
	SAFEDELETE(opt_column_);
	SAFEDELETE(table_name_);
	SAFEDELETE(column_name_1_);
	SAFEDELETE(column_name_2_);
	delete this;
};

void AlterAction::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		table_name_ = new TableName();
		table_name_->generate();
		CASEEND
		CASESTART(1)
		opt_column_ = new OptColumn();
		opt_column_->generate();
		column_name_1_ = new ColumnName();
		column_name_1_->generate();
		column_name_2_ = new ColumnName();
		column_name_2_->generate();
		CASEEND
		CASESTART(2)
		opt_column_ = new OptColumn();
		opt_column_->generate();
		column_def_ = new ColumnDef();
		column_def_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ColumnDefList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(column_def_);
		res = new IR(kColumnDefList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(column_def_);
		auto tmp2= SAFETRANSLATE(column_def_list_);
		res = new IR(kColumnDefList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void ColumnDefList::deep_delete(){
	SAFEDELETE(column_def_);
	SAFEDELETE(column_def_list_);
	delete this;
};

void ColumnDefList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		column_def_ = new ColumnDef();
		column_def_->generate();
		CASEEND
		CASESTART(1)
		column_def_ = new ColumnDef();
		column_def_->generate();
		column_def_list_ = new ColumnDefList();
		column_def_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		column_def_ = new ColumnDef();
		column_def_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  ColumnDef::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(identifier_);
		auto tmp2= SAFETRANSLATE(type_name_);
		auto tmp3= SAFETRANSLATE(opt_column_constraint_list_);
		auto tmp4 = new IR(kUnknown, OP3("","",""), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kColumnDef, OP3("","",""), tmp4, tmp3);

	TRANSLATEEND
}

void ColumnDef::deep_delete(){
	SAFEDELETE(type_name_);
	SAFEDELETE(identifier_);
	SAFEDELETE(opt_column_constraint_list_);
	delete this;
};

void ColumnDef::generate(){
	GENERATESTART(1)

		identifier_ = new Identifier();
		identifier_->generate();
		type_name_ = new TypeName();
		type_name_->generate();
		opt_column_constraint_list_ = new OptColumnConstraintList();
		opt_column_constraint_list_->generate();

	GENERATEEND
}



IR*  OptColumnConstraintList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(column_constraint_list_);
		res = new IR(kOptColumnConstraintList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptColumnConstraintList, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptColumnConstraintList::deep_delete(){
	SAFEDELETE(column_constraint_list_);
	delete this;
};

void OptColumnConstraintList::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		column_constraint_list_ = new ColumnConstraintList();
		column_constraint_list_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ColumnConstraintList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(column_constraint_);
		res = new IR(kColumnConstraintList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(column_constraint_);
		auto tmp2= SAFETRANSLATE(column_constraint_list_);
		res = new IR(kColumnConstraintList, OP3("","",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void ColumnConstraintList::deep_delete(){
	SAFEDELETE(column_constraint_list_);
	SAFEDELETE(column_constraint_);
	delete this;
};

void ColumnConstraintList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		column_constraint_ = new ColumnConstraint();
		column_constraint_->generate();
		CASEEND
		CASESTART(1)
		column_constraint_ = new ColumnConstraint();
		column_constraint_->generate();
		column_constraint_list_ = new ColumnConstraintList();
		column_constraint_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		column_constraint_ = new ColumnConstraint();
		column_constraint_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  ColumnConstraint::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(constraint_type_);
		res = new IR(kColumnConstraint, OP3("","",""), tmp1);

	TRANSLATEEND
}

void ColumnConstraint::deep_delete(){
	SAFEDELETE(constraint_type_);
	delete this;
};

void ColumnConstraint::generate(){
	GENERATESTART(1)

		constraint_type_ = new ConstraintType();
		constraint_type_->generate();

	GENERATEEND
}



IR*  ConstraintType::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kConstraintType, OP3("PRIMARY KEY","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kConstraintType, OP3("NOT NULL","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kConstraintType, OP3("UNIQUE","",""));
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(expr_);
		res = new IR(kConstraintType, OP3("CHECK (",")",""), tmp1);
		CASEEND
		CASESTART(4)
		auto tmp1= SAFETRANSLATE(foreign_clause_);
		res = new IR(kConstraintType, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void ConstraintType::deep_delete(){
	SAFEDELETE(expr_);
	SAFEDELETE(foreign_clause_);
	delete this;
};

void ConstraintType::generate(){
	GENERATESTART(5)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		expr_ = new Expr();
		expr_->generate();
		CASEEND
		CASESTART(4)
		foreign_clause_ = new ForeignClause();
		foreign_clause_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ForeignClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(table_name_);
		auto tmp2= SAFETRANSLATE(opt_column_name_list_p_);
		auto tmp3= SAFETRANSLATE(opt_foreign_key_actions_);
		auto tmp4= SAFETRANSLATE(opt_constraint_attribute_spec_);
		auto tmp5 = new IR(kUnknown, OP3("REFERENCES","",""), tmp1, tmp2);
		PUSH(tmp5);
		auto tmp6 = new IR(kUnknown, OP3("","",""), tmp5, tmp3);
		PUSH(tmp6);
		res = new IR(kForeignClause, OP3("","",""), tmp6, tmp4);

	TRANSLATEEND
}

void ForeignClause::deep_delete(){
	SAFEDELETE(opt_constraint_attribute_spec_);
	SAFEDELETE(opt_column_name_list_p_);
	SAFEDELETE(table_name_);
	SAFEDELETE(opt_foreign_key_actions_);
	delete this;
};

void ForeignClause::generate(){
	GENERATESTART(1)

		table_name_ = new TableName();
		table_name_->generate();
		opt_column_name_list_p_ = new OptColumnNameListP();
		opt_column_name_list_p_->generate();
		opt_foreign_key_actions_ = new OptForeignKeyActions();
		opt_foreign_key_actions_->generate();
		opt_constraint_attribute_spec_ = new OptConstraintAttributeSpec();
		opt_constraint_attribute_spec_->generate();

	GENERATEEND
}



IR*  OptForeignKeyActions::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(foreign_key_actions_);
		res = new IR(kOptForeignKeyActions, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptForeignKeyActions, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptForeignKeyActions::deep_delete(){
	SAFEDELETE(foreign_key_actions_);
	delete this;
};

void OptForeignKeyActions::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		foreign_key_actions_ = new ForeignKeyActions();
		foreign_key_actions_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ForeignKeyActions::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kForeignKeyActions, OP3("MATCH FULL","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kForeignKeyActions, OP3("MATCH PARTIAL","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kForeignKeyActions, OP3("MATCH SIMPLE","",""));
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(key_actions_);
		res = new IR(kForeignKeyActions, OP3("ON UPDATE","",""), tmp1);
		CASEEND
		CASESTART(4)
		auto tmp1= SAFETRANSLATE(key_actions_);
		res = new IR(kForeignKeyActions, OP3("ON DELETE","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void ForeignKeyActions::deep_delete(){
	SAFEDELETE(key_actions_);
	delete this;
};

void ForeignKeyActions::generate(){
	GENERATESTART(5)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		key_actions_ = new KeyActions();
		key_actions_->generate();
		CASEEND
		CASESTART(4)
		key_actions_ = new KeyActions();
		key_actions_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  KeyActions::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kKeyActions, OP3("SET NULL","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kKeyActions, OP3("SET DEFAULT","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kKeyActions, OP3("CASCADE","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kKeyActions, OP3("RESTRICT","",""));
		CASEEND
		CASESTART(4)
		res = new IR(kKeyActions, OP3("NO ACTION","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void KeyActions::deep_delete(){
	delete this;
};

void KeyActions::generate(){
	GENERATESTART(5)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		CASEEND
		CASESTART(4)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptConstraintAttributeSpec::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(opt_initial_time_);
		res = new IR(kOptConstraintAttributeSpec, OP3("DEFFERRABLE","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(opt_initial_time_);
		res = new IR(kOptConstraintAttributeSpec, OP3("NOT DEFFERRABLE","",""), tmp1);
		CASEEND
		CASESTART(2)
		res = new IR(kOptConstraintAttributeSpec, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptConstraintAttributeSpec::deep_delete(){
	SAFEDELETE(opt_initial_time_);
	delete this;
};

void OptConstraintAttributeSpec::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		opt_initial_time_ = new OptInitialTime();
		opt_initial_time_->generate();
		CASEEND
		CASESTART(1)
		opt_initial_time_ = new OptInitialTime();
		opt_initial_time_->generate();
		CASEEND
		CASESTART(2)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptInitialTime::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptInitialTime, OP3("INITIALLY DEFERRED","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptInitialTime, OP3("INITIALLY IMMEDIATE","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kOptInitialTime, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptInitialTime::deep_delete(){
	delete this;
};

void OptInitialTime::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ConstraintName::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(name_);
		res = new IR(kConstraintName, OP3("CONSTRAINT","",""), tmp1);

	TRANSLATEEND
}

void ConstraintName::deep_delete(){
	SAFEDELETE(name_);
	delete this;
};

void ConstraintName::generate(){
	GENERATESTART(1)

		name_ = new Name();
		name_->generate();

	GENERATEEND
}



IR*  OptTemp::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptTemp, OP3("TEMPORARY","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptTemp, OP3("TEMP","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kOptTemp, OP3("LOCAL TEMPORARY","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kOptTemp, OP3("LOCAL TEMP","",""));
		CASEEND
		CASESTART(4)
		res = new IR(kOptTemp, OP3("GLOBAL TEMPORARY","",""));
		CASEEND
		CASESTART(5)
		res = new IR(kOptTemp, OP3("GLOBAL TEMP","",""));
		CASEEND
		CASESTART(6)
		res = new IR(kOptTemp, OP3("UNLOGGED","",""));
		CASEEND
		CASESTART(7)
		res = new IR(kOptTemp, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptTemp::deep_delete(){
	delete this;
};

void OptTemp::generate(){
	GENERATESTART(8)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		CASEEND
		CASESTART(4)
		CASEEND
		CASESTART(5)
		CASEEND
		CASESTART(6)
		CASEEND
		CASESTART(7)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptCheckOption::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptCheckOption, OP3("WITH CHECK OPTION","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptCheckOption, OP3("WITH CASCADED CHECK OPTION","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kOptCheckOption, OP3("WITH LOCAL CHECK OPTION","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kOptCheckOption, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptCheckOption::deep_delete(){
	delete this;
};

void OptCheckOption::generate(){
	GENERATESTART(4)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptColumnNameListP::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(column_name_list_);
		res = new IR(kOptColumnNameListP, OP3("(",")",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptColumnNameListP, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptColumnNameListP::deep_delete(){
	SAFEDELETE(column_name_list_);
	delete this;
};

void OptColumnNameListP::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		column_name_list_ = new ColumnNameList();
		column_name_list_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  SetClauseList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(set_clause_);
		res = new IR(kSetClauseList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(set_clause_);
		auto tmp2= SAFETRANSLATE(set_clause_list_);
		res = new IR(kSetClauseList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void SetClauseList::deep_delete(){
	SAFEDELETE(set_clause_);
	SAFEDELETE(set_clause_list_);
	delete this;
};

void SetClauseList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		set_clause_ = new SetClause();
		set_clause_->generate();
		CASEEND
		CASESTART(1)
		set_clause_ = new SetClause();
		set_clause_->generate();
		set_clause_list_ = new SetClauseList();
		set_clause_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		set_clause_ = new SetClause();
		set_clause_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  SetClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(column_name_);
		auto tmp2= SAFETRANSLATE(expr_);
		res = new IR(kSetClause, OP3("","=",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(column_name_list_);
		auto tmp2= SAFETRANSLATE(expr_);
		res = new IR(kSetClause, OP3("(",") =",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void SetClause::deep_delete(){
	SAFEDELETE(expr_);
	SAFEDELETE(column_name_list_);
	SAFEDELETE(column_name_);
	delete this;
};

void SetClause::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		column_name_ = new ColumnName();
		column_name_->generate();
		expr_ = new Expr();
		expr_->generate();
		CASEEND
		CASESTART(1)
		column_name_list_ = new ColumnNameList();
		column_name_list_->generate();
		expr_ = new Expr();
		expr_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  Expr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(operand_);
		res = new IR(kExpr, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(between_expr_);
		res = new IR(kExpr, OP3("","",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(exists_expr_);
		res = new IR(kExpr, OP3("","",""), tmp1);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(in_expr_);
		res = new IR(kExpr, OP3("","",""), tmp1);
		CASEEND
		CASESTART(4)
		auto tmp1= SAFETRANSLATE(cast_expr_);
		res = new IR(kExpr, OP3("","",""), tmp1);
		CASEEND
		CASESTART(5)
		auto tmp1= SAFETRANSLATE(logic_expr_);
		res = new IR(kExpr, OP3("","",""), tmp1);
		CASEEND
		CASESTART(6)
		auto tmp1= SAFETRANSLATE(func_expr_);
		res = new IR(kExpr, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void Expr::deep_delete(){
	SAFEDELETE(cast_expr_);
	SAFEDELETE(in_expr_);
	SAFEDELETE(between_expr_);
	SAFEDELETE(operand_);
	SAFEDELETE(exists_expr_);
	SAFEDELETE(logic_expr_);
	SAFEDELETE(func_expr_);
	delete this;
};

void Expr::generate(){
	GENERATESTART(7)

	SWITCHSTART
		CASESTART(0)
		operand_ = new Operand();
		operand_->generate();
		CASEEND
		CASESTART(1)
		between_expr_ = new BetweenExpr();
		between_expr_->generate();
		CASEEND
		CASESTART(2)
		exists_expr_ = new ExistsExpr();
		exists_expr_->generate();
		CASEEND
		CASESTART(3)
		in_expr_ = new InExpr();
		in_expr_->generate();
		CASEEND
		CASESTART(4)
		cast_expr_ = new CastExpr();
		cast_expr_->generate();
		CASEEND
		CASESTART(5)
		logic_expr_ = new LogicExpr();
		logic_expr_->generate();
		CASEEND
		CASESTART(6)
		func_expr_ = new FuncExpr();
		func_expr_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  Operand::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_list_);
		res = new IR(kOperand, OP3("(",")",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(array_index_);
		res = new IR(kOperand, OP3("","",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(scalar_expr_);
		res = new IR(kOperand, OP3("","",""), tmp1);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(unary_expr_);
		res = new IR(kOperand, OP3("","",""), tmp1);
		CASEEND
		CASESTART(4)
		auto tmp1= SAFETRANSLATE(binary_expr_);
		res = new IR(kOperand, OP3("","",""), tmp1);
		CASEEND
		CASESTART(5)
		auto tmp1= SAFETRANSLATE(case_expr_);
		res = new IR(kOperand, OP3("","",""), tmp1);
		CASEEND
		CASESTART(6)
		auto tmp1= SAFETRANSLATE(extract_expr_);
		res = new IR(kOperand, OP3("","",""), tmp1);
		CASEEND
		CASESTART(7)
		auto tmp1= SAFETRANSLATE(select_no_parens_);
		res = new IR(kOperand, OP3("(",")",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void Operand::deep_delete(){
	SAFEDELETE(unary_expr_);
	SAFEDELETE(expr_list_);
	SAFEDELETE(case_expr_);
	SAFEDELETE(select_no_parens_);
	SAFEDELETE(extract_expr_);
	SAFEDELETE(array_index_);
	SAFEDELETE(binary_expr_);
	SAFEDELETE(scalar_expr_);
	delete this;
};

void Operand::generate(){
	GENERATESTART(8)

	SWITCHSTART
		CASESTART(0)
		expr_list_ = new ExprList();
		expr_list_->generate();
		CASEEND
		CASESTART(1)
		array_index_ = new ArrayIndex();
		array_index_->generate();
		CASEEND
		CASESTART(2)
		scalar_expr_ = new ScalarExpr();
		scalar_expr_->generate();
		CASEEND
		CASESTART(3)
		unary_expr_ = new UnaryExpr();
		unary_expr_->generate();
		CASEEND
		CASESTART(4)
		binary_expr_ = new BinaryExpr();
		binary_expr_->generate();
		CASEEND
		CASESTART(5)
		case_expr_ = new CaseExpr();
		case_expr_->generate();
		CASEEND
		CASESTART(6)
		extract_expr_ = new ExtractExpr();
		extract_expr_->generate();
		CASEEND
		CASESTART(7)
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  CastExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(expr_);
		auto tmp2= SAFETRANSLATE(type_name_);
		res = new IR(kCastExpr, OP3("CAST (","AS",")"), tmp1, tmp2);

	TRANSLATEEND
}

void CastExpr::deep_delete(){
	SAFEDELETE(expr_);
	SAFEDELETE(type_name_);
	delete this;
};

void CastExpr::generate(){
	GENERATESTART(1)

		expr_ = new Expr();
		expr_->generate();
		type_name_ = new TypeName();
		type_name_->generate();

	GENERATEEND
}



IR*  ScalarExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(column_name_);
		res = new IR(kScalarExpr, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(literal_);
		res = new IR(kScalarExpr, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void ScalarExpr::deep_delete(){
	SAFEDELETE(literal_);
	SAFEDELETE(column_name_);
	delete this;
};

void ScalarExpr::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		column_name_ = new ColumnName();
		column_name_->generate();
		CASEEND
		CASESTART(1)
		literal_ = new Literal();
		literal_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  UnaryExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(operand_);
		res = new IR(kUnaryExpr, OP3("-","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(operand_);
		res = new IR(kUnaryExpr, OP3("NOT","",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(operand_);
		res = new IR(kUnaryExpr, OP3("","ISNULL",""), tmp1);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(operand_);
		res = new IR(kUnaryExpr, OP3("","IS NULL",""), tmp1);
		CASEEND
		CASESTART(4)
		auto tmp1= SAFETRANSLATE(operand_);
		res = new IR(kUnaryExpr, OP3("","IS NOT NULL",""), tmp1);
		CASEEND
		CASESTART(5)
		res = new IR(kUnaryExpr, OP3("NULL","",""));
		CASEEND
		CASESTART(6)
		res = new IR(kUnaryExpr, OP3("*","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void UnaryExpr::deep_delete(){
	SAFEDELETE(operand_);
	delete this;
};

void UnaryExpr::generate(){
	GENERATESTART(7)

	SWITCHSTART
		CASESTART(0)
		operand_ = new Operand();
		operand_->generate();
		CASEEND
		CASESTART(1)
		operand_ = new Operand();
		operand_->generate();
		CASEEND
		CASESTART(2)
		operand_ = new Operand();
		operand_->generate();
		CASEEND
		CASESTART(3)
		operand_ = new Operand();
		operand_->generate();
		CASEEND
		CASESTART(4)
		operand_ = new Operand();
		operand_->generate();
		CASEEND
		CASESTART(5)
		CASEEND
		CASESTART(6)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  BinaryExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(comp_expr_);
		res = new IR(kBinaryExpr, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(binary_op_);
		auto tmp3= SAFETRANSLATE(operand_2_);
		auto tmp4 = new IR(kUnknown, OP3("","",""), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kBinaryExpr, OP3("","",""), tmp4, tmp3);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		res = new IR(kBinaryExpr, OP3("","LIKE",""), tmp1, tmp2);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		res = new IR(kBinaryExpr, OP3("","NOT LIKE",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void BinaryExpr::deep_delete(){
	SAFEDELETE(operand_1_);
	SAFEDELETE(operand_2_);
	SAFEDELETE(binary_op_);
	SAFEDELETE(comp_expr_);
	delete this;
};

void BinaryExpr::generate(){
	GENERATESTART(4)

	SWITCHSTART
		CASESTART(0)
		comp_expr_ = new CompExpr();
		comp_expr_->generate();
		CASEEND
		CASESTART(1)
		operand_1_ = new Operand();
		operand_1_->generate();
		binary_op_ = new BinaryOp();
		binary_op_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
		CASESTART(2)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
		CASESTART(3)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  LogicExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_1_);
		auto tmp2= SAFETRANSLATE(expr_2_);
		res = new IR(kLogicExpr, OP3("","AND",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(expr_1_);
		auto tmp2= SAFETRANSLATE(expr_2_);
		res = new IR(kLogicExpr, OP3("","OR",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void LogicExpr::deep_delete(){
	SAFEDELETE(expr_1_);
	SAFEDELETE(expr_2_);
	delete this;
};

void LogicExpr::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		expr_1_ = new Expr();
		expr_1_->generate();
		expr_2_ = new Expr();
		expr_2_->generate();
		CASEEND
		CASESTART(1)
		expr_1_ = new Expr();
		expr_1_->generate();
		expr_2_ = new Expr();
		expr_2_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  InExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(operand_);
		auto tmp2= SAFETRANSLATE(opt_not_);
		auto tmp3= SAFETRANSLATE(select_no_parens_);
		auto tmp4 = new IR(kUnknown, OP3("","","IN"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kInExpr, OP3("","(",")"), tmp4, tmp3);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(operand_);
		auto tmp2= SAFETRANSLATE(opt_not_);
		auto tmp3= SAFETRANSLATE(expr_list_);
		auto tmp4 = new IR(kUnknown, OP3("","","IN"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kInExpr, OP3("","(",")"), tmp4, tmp3);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(operand_);
		auto tmp2= SAFETRANSLATE(opt_not_);
		auto tmp3= SAFETRANSLATE(table_name_);
		auto tmp4 = new IR(kUnknown, OP3("","","IN"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kInExpr, OP3("","",""), tmp4, tmp3);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void InExpr::deep_delete(){
	SAFEDELETE(operand_);
	SAFEDELETE(expr_list_);
	SAFEDELETE(opt_not_);
	SAFEDELETE(table_name_);
	SAFEDELETE(select_no_parens_);
	delete this;
};

void InExpr::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		operand_ = new Operand();
		operand_->generate();
		opt_not_ = new OptNot();
		opt_not_->generate();
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();
		CASEEND
		CASESTART(1)
		operand_ = new Operand();
		operand_->generate();
		opt_not_ = new OptNot();
		opt_not_->generate();
		expr_list_ = new ExprList();
		expr_list_->generate();
		CASEEND
		CASESTART(2)
		operand_ = new Operand();
		operand_->generate();
		opt_not_ = new OptNot();
		opt_not_->generate();
		table_name_ = new TableName();
		table_name_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  CaseExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(expr_1_);
		auto tmp2= SAFETRANSLATE(case_list_);
		res = new IR(kCaseExpr, OP3("CASE","","END"), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(case_list_);
		res = new IR(kCaseExpr, OP3("CASE","END",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(expr_1_);
		auto tmp2= SAFETRANSLATE(case_list_);
		auto tmp3= SAFETRANSLATE(expr_2_);
		auto tmp4 = new IR(kUnknown, OP3("CASE","","ELSE"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kCaseExpr, OP3("","","END"), tmp4, tmp3);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(case_list_);
		auto tmp2= SAFETRANSLATE(expr_1_);
		res = new IR(kCaseExpr, OP3("CASE","ELSE","END"), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CaseExpr::deep_delete(){
	SAFEDELETE(expr_1_);
	SAFEDELETE(expr_2_);
	SAFEDELETE(case_list_);
	delete this;
};

void CaseExpr::generate(){
	GENERATESTART(4)

	SWITCHSTART
		CASESTART(0)
		expr_1_ = new Expr();
		expr_1_->generate();
		case_list_ = new CaseList();
		case_list_->generate();
		CASEEND
		CASESTART(1)
		case_list_ = new CaseList();
		case_list_->generate();
		CASEEND
		CASESTART(2)
		expr_1_ = new Expr();
		expr_1_->generate();
		case_list_ = new CaseList();
		case_list_->generate();
		expr_2_ = new Expr();
		expr_2_->generate();
		CASEEND
		CASESTART(3)
		case_list_ = new CaseList();
		case_list_->generate();
		expr_1_ = new Expr();
		expr_1_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}


IR*  FuncExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1 = SAFETRANSLATE(expr_list_);
		res = new IR(kFuncExpr, OP3("COUNT (", ")", ""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1 = SAFETRANSLATE(expr_list_);
		res = new IR(kFuncExpr, OP3("COALESCE (", ")", ""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1 = SAFETRANSLATE(expr_list_);
		res = new IR(kFuncExpr, OP3("SUM (", ")", ""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void FuncExpr::deep_delete(){
	SAFEDELETE(expr_list_);
	delete this;
};

void FuncExpr::generate(){
	return;
};

IR* OptCast::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART
	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptCast, OP3(":: INT", "", ""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptCast, OP0());
		CASEEND
	SWITCHEND
	TRANSLATEEND
}

void OptCast::deep_delete(){
	delete this;
};

void OptCast::generate(){
	return;
}

IR* OptAlias::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1 = SAFETRANSLATE(iden_);
		res = new IR(kOptAlias, OP3("AS", "", ""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptAlias, OP0());
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptAlias::deep_delete(){
	SAFEDELETE(iden_);
	delete this;
};

void OptAlias::generate(){
	return;
}


IR*  BetweenExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		auto tmp3= SAFETRANSLATE(operand_3_);
		auto tmp4 = new IR(kUnknown, OP3("","BETWEEN","AND"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kBetweenExpr, OP3("","",""), tmp4, tmp3);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		auto tmp3= SAFETRANSLATE(operand_3_);
		auto tmp4 = new IR(kUnknown, OP3("","NOT BETWEEN","AND"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kBetweenExpr, OP3("","",""), tmp4, tmp3);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void BetweenExpr::deep_delete(){
	SAFEDELETE(operand_1_);
	SAFEDELETE(operand_2_);
	SAFEDELETE(operand_3_);
	delete this;
};

void BetweenExpr::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		operand_3_ = new Operand();
		operand_3_->generate();
		CASEEND
		CASESTART(1)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		operand_3_ = new Operand();
		operand_3_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ExistsExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(opt_not_);
		auto tmp2= SAFETRANSLATE(select_no_parens_);
		res = new IR(kExistsExpr, OP3("","EXISTS (",")"), tmp1, tmp2);

	TRANSLATEEND
}

void ExistsExpr::deep_delete(){
	SAFEDELETE(opt_not_);
	SAFEDELETE(select_no_parens_);
	delete this;
};

void ExistsExpr::generate(){
	GENERATESTART(1)

		opt_not_ = new OptNot();
		opt_not_->generate();
		select_no_parens_ = new SelectNoParens();
		select_no_parens_->generate();

	GENERATEEND
}



IR*  CaseList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(case_clause_);
		res = new IR(kCaseList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(case_clause_);
		auto tmp2= SAFETRANSLATE(case_list_);
		res = new IR(kCaseList, OP3("","",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CaseList::deep_delete(){
	SAFEDELETE(case_list_);
	SAFEDELETE(case_clause_);
	delete this;
};

void CaseList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		case_clause_ = new CaseClause();
		case_clause_->generate();
		CASEEND
		CASESTART(1)
		case_clause_ = new CaseClause();
		case_clause_->generate();
		case_list_ = new CaseList();
		case_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		case_clause_ = new CaseClause();
		case_clause_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  CaseClause::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(expr_1_);
		auto tmp2= SAFETRANSLATE(expr_2_);
		res = new IR(kCaseClause, OP3("WHEN","THEN",""), tmp1, tmp2);

	TRANSLATEEND
}

void CaseClause::deep_delete(){
	SAFEDELETE(expr_1_);
	SAFEDELETE(expr_2_);
	delete this;
};

void CaseClause::generate(){
	GENERATESTART(1)

		expr_1_ = new Expr();
		expr_1_->generate();
		expr_2_ = new Expr();
		expr_2_->generate();

	GENERATEEND
}



IR*  CompExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		res = new IR(kCompExpr, OP3("","=",""), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		res = new IR(kCompExpr, OP3("","!=",""), tmp1, tmp2);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		res = new IR(kCompExpr, OP3("",">",""), tmp1, tmp2);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		res = new IR(kCompExpr, OP3("","<",""), tmp1, tmp2);
		CASEEND
		CASESTART(4)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		res = new IR(kCompExpr, OP3("","<=",""), tmp1, tmp2);
		CASEEND
		CASESTART(5)
		auto tmp1= SAFETRANSLATE(operand_1_);
		auto tmp2= SAFETRANSLATE(operand_2_);
		res = new IR(kCompExpr, OP3("",">=",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CompExpr::deep_delete(){
	SAFEDELETE(operand_1_);
	SAFEDELETE(operand_2_);
	delete this;
};

void CompExpr::generate(){
	GENERATESTART(6)

	SWITCHSTART
		CASESTART(0)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
		CASESTART(1)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
		CASESTART(2)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
		CASESTART(3)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
		CASESTART(4)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
		CASESTART(5)
		operand_1_ = new Operand();
		operand_1_->generate();
		operand_2_ = new Operand();
		operand_2_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ExtractExpr::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(datetime_field_);
		auto tmp2= SAFETRANSLATE(expr_);
		res = new IR(kExtractExpr, OP3("EXTRACT (","FROM",")"), tmp1, tmp2);

	TRANSLATEEND
}

void ExtractExpr::deep_delete(){
	SAFEDELETE(datetime_field_);
	SAFEDELETE(expr_);
	delete this;
};

void ExtractExpr::generate(){
	GENERATESTART(1)

		datetime_field_ = new DatetimeField();
		datetime_field_->generate();
		expr_ = new Expr();
		expr_->generate();

	GENERATEEND
}



IR*  DatetimeField::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kDatetimeField, OP3("SECOND","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kDatetimeField, OP3("MINUTE","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kDatetimeField, OP3("HOUR","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kDatetimeField, OP3("DAY","",""));
		CASEEND
		CASESTART(4)
		res = new IR(kDatetimeField, OP3("MONTH","",""));
		CASEEND
		CASESTART(5)
		res = new IR(kDatetimeField, OP3("YEAR","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void DatetimeField::deep_delete(){
	delete this;
};

void DatetimeField::generate(){
	GENERATESTART(6)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		CASEEND
		CASESTART(4)
		CASEEND
		CASESTART(5)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ArrayIndex::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(operand_);
		auto tmp2= SAFETRANSLATE(int_literal_);
		res = new IR(kArrayIndex, OP3("","[","]"), tmp1, tmp2);

	TRANSLATEEND
}

void ArrayIndex::deep_delete(){
	SAFEDELETE(operand_);
	SAFEDELETE(int_literal_);
	delete this;
};

void ArrayIndex::generate(){
	GENERATESTART(1)

		operand_ = new Operand();
		operand_->generate();
		int_literal_ = new IntLiteral();
		int_literal_->generate();

	GENERATEEND
}



IR*  Literal::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(string_literal_);
		res = new IR(kLiteral, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(bool_literal_);
		res = new IR(kLiteral, OP3("","",""), tmp1);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(num_literal_);
		res = new IR(kLiteral, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void Literal::deep_delete(){
	SAFEDELETE(bool_literal_);
	SAFEDELETE(string_literal_);
	SAFEDELETE(num_literal_);
	delete this;
};

void Literal::generate(){
	GENERATESTART(3)

	SWITCHSTART
		CASESTART(0)
		string_literal_ = new StringLiteral();
		string_literal_->generate();
		CASEEND
		CASESTART(1)
		bool_literal_ = new BoolLiteral();
		bool_literal_->generate();
		CASEEND
		CASESTART(2)
		num_literal_ = new NumLiteral();
		num_literal_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  StringLiteral::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		res = new IR(kStringLiteral, string_val_, data_type_, scope_, data_flag_);

	TRANSLATEEND
}

void StringLiteral::deep_delete(){
	delete this;
};

void StringLiteral::generate(){
	GENERATESTART(1)

		string_val_ = gen_string();

	GENERATEEND
}



IR*  BoolLiteral::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kBoolLiteral, OP3("TRUE","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kBoolLiteral, OP3("FALSE","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void BoolLiteral::deep_delete(){
	delete this;
};

void BoolLiteral::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  NumLiteral::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(int_literal_);
		res = new IR(kNumLiteral, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(float_literal_);
		res = new IR(kNumLiteral, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void NumLiteral::deep_delete(){
	SAFEDELETE(int_literal_);
	SAFEDELETE(float_literal_);
	delete this;
};

void NumLiteral::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		int_literal_ = new IntLiteral();
		int_literal_->generate();
		CASEEND
		CASESTART(1)
		float_literal_ = new FloatLiteral();
		float_literal_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  IntLiteral::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		res = new IR(kIntLiteral, int_val_, data_type_, scope_, data_flag_);

	TRANSLATEEND
}

void IntLiteral::deep_delete(){
	delete this;
};

void IntLiteral::generate(){
	GENERATESTART(1)

		int_val_ = gen_int();

	GENERATEEND
}



IR*  FloatLiteral::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		res = new IR(kFloatLiteral, float_val_, data_type_, scope_, data_flag_);

	TRANSLATEEND
}

void FloatLiteral::deep_delete(){
	delete this;
};

void FloatLiteral::generate(){
	GENERATESTART(1)

		float_val_ = gen_float();

	GENERATEEND
}



IR*  OptColumn::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptColumn, OP3("COLUMN","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptColumn, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptColumn::deep_delete(){
	delete this;
};

void OptColumn::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptIfNotExist::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptIfNotExist, OP3("IF NOT EXISTS","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptIfNotExist, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptIfNotExist::deep_delete(){
	delete this;
};

void OptIfNotExist::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptIfExist::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptIfExist, OP3("IF EXISTS","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptIfExist, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptIfExist::deep_delete(){
	delete this;
};

void OptIfExist::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  Identifier::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		res = new IR(kIdentifier, string_val_, data_type_, scope_, data_flag_);

	TRANSLATEEND
}

void Identifier::deep_delete(){
	delete this;
};

void Identifier::generate(){
	GENERATESTART(1)

		string_val_ = gen_string();

	GENERATEEND
}



IR*  TableName::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(identifier_);
		res = new IR(kTableName, OP3("","",""), tmp1);

	TRANSLATEEND
}

void TableName::deep_delete(){
	SAFEDELETE(identifier_);
	delete this;
};

void TableName::generate(){
	GENERATESTART(1)

		identifier_ = new Identifier();
		identifier_->generate();

	GENERATEEND
}



IR*  ColumnName::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(identifier_);
		res = new IR(kColumnName, OP3("","",""), tmp1);

	TRANSLATEEND
}

void ColumnName::deep_delete(){
	SAFEDELETE(identifier_);
	delete this;
};

void ColumnName::generate(){
	GENERATESTART(1)

		identifier_ = new Identifier();
		identifier_->generate();

	GENERATEEND
}



IR*  OptUnique::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptUnique, OP3("UNIQUE","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptUnique, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptUnique::deep_delete(){
	delete this;
};

void OptUnique::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  ViewName::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(identifier_);
		res = new IR(kViewName, OP3("","",""), tmp1);

	TRANSLATEEND
}

void ViewName::deep_delete(){
	SAFEDELETE(identifier_);
	delete this;
};

void ViewName::generate(){
	GENERATESTART(1)

		identifier_ = new Identifier();
		identifier_->generate();

	GENERATEEND
}



IR*  BinaryOp::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kBinaryOp, OP3("+","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kBinaryOp, OP3("-","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kBinaryOp, OP3("/","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kBinaryOp, OP3("%","",""));
		CASEEND
		CASESTART(4)
		res = new IR(kBinaryOp, OP3("*","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void BinaryOp::deep_delete(){
	delete this;
};

void BinaryOp::generate(){
	GENERATESTART(5)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		CASEEND
		CASESTART(4)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptNot::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptNot, OP3("NOT","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptNot, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptNot::deep_delete(){
	delete this;
};

void OptNot::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  Name::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(identifier_);
		res = new IR(kName, OP3("","",""), tmp1);

	TRANSLATEEND
}

void Name::deep_delete(){
	SAFEDELETE(identifier_);
	delete this;
};

void Name::generate(){
	GENERATESTART(1)

		identifier_ = new Identifier();
		identifier_->generate();

	GENERATEEND
}



IR*  TypeName::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(numeric_type_);
		res = new IR(kTypeName, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(character_type_);
		res = new IR(kTypeName, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void TypeName::deep_delete(){
	SAFEDELETE(numeric_type_);
	SAFEDELETE(character_type_);
	delete this;
};

void TypeName::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		numeric_type_ = new NumericType();
		numeric_type_->generate();
		CASEEND
		CASESTART(1)
		character_type_ = new CharacterType();
		character_type_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  CharacterType::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(character_with_length_);
		res = new IR(kCharacterType, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(character_without_length_);
		res = new IR(kCharacterType, OP3("","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CharacterType::deep_delete(){
	SAFEDELETE(character_with_length_);
	SAFEDELETE(character_without_length_);
	delete this;
};

void CharacterType::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		character_with_length_ = new CharacterWithLength();
		character_with_length_->generate();
		CASEEND
		CASESTART(1)
		character_without_length_ = new CharacterWithoutLength();
		character_without_length_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  CharacterWithLength::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(character_conflicta_);
		auto tmp2= SAFETRANSLATE(int_literal_);
		res = new IR(kCharacterWithLength, OP3("","(",")"), tmp1, tmp2);

	TRANSLATEEND
}

void CharacterWithLength::deep_delete(){
	SAFEDELETE(character_conflicta_);
	SAFEDELETE(int_literal_);
	delete this;
};

void CharacterWithLength::generate(){
	GENERATESTART(1)

		character_conflicta_ = new CharacterConflicta();
		character_conflicta_->generate();
		int_literal_ = new IntLiteral();
		int_literal_->generate();

	GENERATEEND
}



IR*  CharacterWithoutLength::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

		auto tmp1= SAFETRANSLATE(character_conflicta_);
		res = new IR(kCharacterWithoutLength, OP3("","",""), tmp1);

	TRANSLATEEND
}

void CharacterWithoutLength::deep_delete(){
	SAFEDELETE(character_conflicta_);
	delete this;
};

void CharacterWithoutLength::generate(){
	GENERATESTART(1)

		character_conflicta_ = new CharacterConflicta();
		character_conflicta_->generate();

	GENERATEEND
}



IR*  CharacterConflicta::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(opt_varying_);
		res = new IR(kCharacterConflicta, OP3("CHARACTER","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(opt_varying_);
		res = new IR(kCharacterConflicta, OP3("CHAR","",""), tmp1);
		CASEEND
		CASESTART(2)
		res = new IR(kCharacterConflicta, OP3("VARCHAR","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kCharacterConflicta, OP3("TEXT","",""));
		CASEEND
		CASESTART(4)
		auto tmp1= SAFETRANSLATE(opt_varying_);
		res = new IR(kCharacterConflicta, OP3("NATIONAL CHARACTER","",""), tmp1);
		CASEEND
		CASESTART(5)
		auto tmp1= SAFETRANSLATE(opt_varying_);
		res = new IR(kCharacterConflicta, OP3("NATIONAL CHAR","",""), tmp1);
		CASEEND
		CASESTART(6)
		auto tmp1= SAFETRANSLATE(opt_varying_);
		res = new IR(kCharacterConflicta, OP3("NCHAR","",""), tmp1);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void CharacterConflicta::deep_delete(){
	SAFEDELETE(opt_varying_);
	delete this;
};

void CharacterConflicta::generate(){
	GENERATESTART(7)

	SWITCHSTART
		CASESTART(0)
		opt_varying_ = new OptVarying();
		opt_varying_->generate();
		CASEEND
		CASESTART(1)
		opt_varying_ = new OptVarying();
		opt_varying_->generate();
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		CASEEND
		CASESTART(4)
		opt_varying_ = new OptVarying();
		opt_varying_->generate();
		CASEEND
		CASESTART(5)
		opt_varying_ = new OptVarying();
		opt_varying_->generate();
		CASEEND
		CASESTART(6)
		opt_varying_ = new OptVarying();
		opt_varying_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptVarying::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kOptVarying, OP3("VARYING","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kOptVarying, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptVarying::deep_delete(){
	delete this;
};

void OptVarying::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  NumericType::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		res = new IR(kNumericType, OP3("INT","",""));
		CASEEND
		CASESTART(1)
		res = new IR(kNumericType, OP3("INTEGER","",""));
		CASEEND
		CASESTART(2)
		res = new IR(kNumericType, OP3("SMALLINT","",""));
		CASEEND
		CASESTART(3)
		res = new IR(kNumericType, OP3("BIGINT","",""));
		CASEEND
		CASESTART(4)
		res = new IR(kNumericType, OP3("REAL","",""));
		CASEEND
		CASESTART(5)
		res = new IR(kNumericType, OP3("FLOAT","",""));
		CASEEND
		CASESTART(6)
		res = new IR(kNumericType, OP3("DOUBLE PRECISION","",""));
		CASEEND
		CASESTART(7)
		res = new IR(kNumericType, OP3("DECIMAL","",""));
		CASEEND
		CASESTART(8)
		res = new IR(kNumericType, OP3("DEC","",""));
		CASEEND
		CASESTART(9)
		res = new IR(kNumericType, OP3("NUMERIC","",""));
		CASEEND
		CASESTART(10)
		res = new IR(kNumericType, OP3("BOOLEAN","",""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void NumericType::deep_delete(){
	delete this;
};

void NumericType::generate(){
	GENERATESTART(11)

	SWITCHSTART
		CASESTART(0)
		CASEEND
		CASESTART(1)
		CASEEND
		CASESTART(2)
		CASEEND
		CASESTART(3)
		CASEEND
		CASESTART(4)
		CASEEND
		CASESTART(5)
		CASEEND
		CASESTART(6)
		CASEEND
		CASESTART(7)
		CASEEND
		CASESTART(8)
		CASEEND
		CASESTART(9)
		CASEEND
		CASESTART(10)
		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  OptTableConstraintList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(table_constraint_list_);
		res = new IR(kOptTableConstraintList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		res = new IR(kOptTableConstraintList, string(""));
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void OptTableConstraintList::deep_delete(){
	SAFEDELETE(table_constraint_list_);
	delete this;
};

void OptTableConstraintList::generate(){
	GENERATESTART(2)

	SWITCHSTART
		CASESTART(0)
		table_constraint_list_ = new TableConstraintList();
		table_constraint_list_->generate();
		CASEEND
		CASESTART(1)

		CASEEND
	SWITCHEND

	GENERATEEND
}



IR*  TableConstraintList::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(table_constraint_);
		res = new IR(kTableConstraintList, OP3("","",""), tmp1);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(table_constraint_);
		auto tmp2= SAFETRANSLATE(table_constraint_list_);
		res = new IR(kTableConstraintList, OP3("",",",""), tmp1, tmp2);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void TableConstraintList::deep_delete(){
	SAFEDELETE(table_constraint_);
	SAFEDELETE(table_constraint_list_);
	delete this;
};

void TableConstraintList::generate(){
	GENERATESTART(200)

	SWITCHSTART
		CASESTART(0)
		table_constraint_ = new TableConstraint();
		table_constraint_->generate();
		CASEEND
		CASESTART(1)
		table_constraint_ = new TableConstraint();
		table_constraint_->generate();
		table_constraint_list_ = new TableConstraintList();
		table_constraint_list_->generate();
		CASEEND

    default:{
        int tmp_case_idx = rand() % 1;
        switch(tmp_case_idx){
            CASESTART(0)
		table_constraint_ = new TableConstraint();
		table_constraint_->generate();
case_idx_ = 0;
CASEEND

        }
    }
}

	GENERATEEND
}



IR*  TableConstraint::translate(vector<IR *> &v_ir_collector){
	TRANSLATESTART

	SWITCHSTART
		CASESTART(0)
		auto tmp1= SAFETRANSLATE(constraint_name_);
		auto tmp2= SAFETRANSLATE(indexed_column_list_);
		res = new IR(kTableConstraint, OP3("","PRIMARY KEY (",")"), tmp1, tmp2);
		CASEEND
		CASESTART(1)
		auto tmp1= SAFETRANSLATE(constraint_name_);
		auto tmp2= SAFETRANSLATE(indexed_column_list_);
		res = new IR(kTableConstraint, OP3("","UNIQUE (",")"), tmp1, tmp2);
		CASEEND
		CASESTART(2)
		auto tmp1= SAFETRANSLATE(constraint_name_);
		auto tmp2= SAFETRANSLATE(expr_);
		res = new IR(kTableConstraint, OP3("","CHECK (",")"), tmp1, tmp2);
		CASEEND
		CASESTART(3)
		auto tmp1= SAFETRANSLATE(constraint_name_);
		auto tmp2= SAFETRANSLATE(column_name_list_);
		auto tmp3= SAFETRANSLATE(foreign_clause_);
		auto tmp4 = new IR(kUnknown, OP3("","FOREIGN KEY (",")"), tmp1, tmp2);
		PUSH(tmp4);
		res = new IR(kTableConstraint, OP3("","",""), tmp4, tmp3);
		CASEEND
	SWITCHEND

	TRANSLATEEND
}

void TableConstraint::deep_delete(){
	SAFEDELETE(expr_);
	SAFEDELETE(indexed_column_list_);
	SAFEDELETE(foreign_clause_);
	SAFEDELETE(constraint_name_);
	SAFEDELETE(column_name_list_);
	delete this;
};

void TableConstraint::generate(){
	GENERATESTART(4)

	SWITCHSTART
		CASESTART(0)
		constraint_name_ = new ConstraintName();
		constraint_name_->generate();
		indexed_column_list_ = new IndexedColumnList();
		indexed_column_list_->generate();
		CASEEND
		CASESTART(1)
		constraint_name_ = new ConstraintName();
		constraint_name_->generate();
		indexed_column_list_ = new IndexedColumnList();
		indexed_column_list_->generate();
		CASEEND
		CASESTART(2)
		constraint_name_ = new ConstraintName();
		constraint_name_->generate();
		expr_ = new Expr();
		expr_->generate();
		CASEEND
		CASESTART(3)
		constraint_name_ = new ConstraintName();
		constraint_name_->generate();
		column_name_list_ = new ColumnNameList();
		column_name_list_->generate();
		foreign_clause_ = new ForeignClause();
		foreign_clause_->generate();
		CASEEND
	SWITCHEND

	GENERATEEND
}


