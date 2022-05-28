/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 2

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Substitute the type names.  */
#define YYSTYPE         FF_STYPE
#define YYLTYPE         FF_LTYPE
/* Substitute the variable and function names.  */
#define yyparse         ff_parse
#define yylex           ff_lex
#define yyerror         ff_error
#define yydebug         ff_debug
#define yynerrs         ff_nerrs

/* First part of user prologue.  */
#line 1 "bison.y"

#include "bison_parser.h"
#include "flex_lexer.h"
#include <stdio.h>
#include <string.h>
int yyerror(YYLTYPE* llocp, Program * result, yyscan_t scanner, const char *msg) { return 0; }

#line 85 "bison_parser.cpp"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_FF_BISON_PARSER_H_INCLUDED
# define YY_FF_BISON_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef FF_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define FF_DEBUG 1
#  else
#   define FF_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define FF_DEBUG 0
# endif /* ! defined YYDEBUG */
#endif  /* ! defined FF_DEBUG */
#if FF_DEBUG
extern int ff_debug;
#endif
/* "%code requires" blocks.  */
#line 8 "bison.y"

#include "../include/ast.h"
#include "parser_typedef.h"

#line 141 "bison_parser.cpp"

/* Token type.  */
#ifndef FF_TOKENTYPE
# define FF_TOKENTYPE
  enum ff_tokentype
  {
    SQL_OP_NOTEQUAL = 258,
    SQL_ENABLE = 259,
    SQL_SIMPLE = 260,
    SQL_TEXT = 261,
    SQL_OVER = 262,
    SQL_YEAR = 263,
    SQL_INSERT_METHOD = 264,
    SQL_OP_SEMI = 265,
    SQL_BIGINT = 266,
    SQL_LIMIT = 267,
    SQL_OP_GREATERTHAN = 268,
    SQL_WITH = 269,
    SQL_ORDER = 270,
    SQL_OPTION = 271,
    SQL_LAST = 272,
    SQL_UNBOUNDED = 273,
    SQL_PRECEDING = 274,
    SQL_EXCEPT = 275,
    SQL_NUMERIC = 276,
    SQL_OP_LESSTHAN = 277,
    SQL_ACTION = 278,
    SQL_BEFORE = 279,
    SQL_OP_GREATEREQ = 280,
    SQL_CHECK = 281,
    SQL_COMPACT = 282,
    SQL_FULL = 283,
    SQL_NATURAL = 284,
    SQL_BINARY = 285,
    SQL_NATIONAL = 286,
    SQL_ENUM = 287,
    SQL_REDUNDANT = 288,
    SQL_OP_ADD = 289,
    SQL_CURRENT = 290,
    SQL_MERGE = 291,
    SQL_TRIGGER = 292,
    SQL_COMPRESSED = 293,
    SQL_OP_SUB = 294,
    SQL_FALSE = 295,
    SQL_UNIQUE = 296,
    SQL_WHERE = 297,
    SQL_MINUTE = 298,
    SQL_FIRST = 299,
    SQL_ON = 300,
    SQL_PARTIAL = 301,
    SQL_DOUBLE = 302,
    SQL_AFTER = 303,
    SQL_PRIMARY = 304,
    SQL_MONTH = 305,
    SQL_DEFERRED = 306,
    SQL_VALUES = 307,
    SQL_LONGTEXT = 308,
    SQL_SQL = 309,
    SQL_SHARED = 310,
    SQL_VALIDATION = 311,
    SQL_OR = 312,
    SQL_VIEW = 313,
    SQL_INDEX = 314,
    SQL_GROUP = 315,
    SQL_OP_MUL = 316,
    SQL_INPLACE = 317,
    SQL_FOREIGN = 318,
    SQL_RESTRICT = 319,
    SQL_SPATIAL = 320,
    SQL_FOLLOWING = 321,
    SQL_DEC = 322,
    SQL_SELECT = 323,
    SQL_NONE = 324,
    SQL_DISTINCT = 325,
    SQL_TRUE = 326,
    SQL_DYNAMIC = 327,
    SQL_BY = 328,
    SQL_OP_MOD = 329,
    SQL_INTEGER = 330,
    SQL_SECURITY = 331,
    SQL_IS = 332,
    SQL_DEFINER = 333,
    SQL_ROW = 334,
    SQL_ENFORCED = 335,
    SQL_END = 336,
    SQL_RECURSIVE = 337,
    SQL_FOR = 338,
    SQL_TEMPTABLE = 339,
    SQL_UNION = 340,
    SQL_NULLS = 341,
    SQL_UPDATE = 342,
    SQL_ELSE = 343,
    SQL_RANGE = 344,
    SQL_SET = 345,
    SQL_INVOKER = 346,
    SQL_OFFSET = 347,
    SQL_INDEXED = 348,
    SQL_FORCE = 349,
    SQL_NCHAR = 350,
    SQL_AND = 351,
    SQL_INITIALLY = 352,
    SQL_PRECISION = 353,
    SQL_FILTER = 354,
    SQL_WITHOUT = 355,
    SQL_NOT = 356,
    SQL_DELETE = 357,
    SQL_DEFFERRABLE = 358,
    SQL_REAL = 359,
    SQL_THEN = 360,
    SQL_UNDEFINED = 361,
    SQL_DEFAULT = 362,
    SQL_CROSS = 363,
    SQL_CHAR = 364,
    SQL_REFERENCES = 365,
    SQL_OP_XOR = 366,
    SQL_CASE = 367,
    SQL_FIXED = 368,
    SQL_HOUR = 369,
    SQL_NO = 370,
    SQL_COLUMN = 371,
    SQL_LOCAL = 372,
    SQL_DROP = 373,
    SQL_REPLACE = 374,
    SQL_ASC = 375,
    SQL_OP_COMMA = 376,
    SQL_DISABLE = 377,
    SQL_TABLE = 378,
    SQL_ARRAY = 379,
    SQL_IF = 380,
    SQL_EXTRACT = 381,
    SQL_LEFT = 382,
    SQL_FULLTEXT = 383,
    SQL_HASH = 384,
    SQL_ALGORITHM = 385,
    SQL_LOCK = 386,
    SQL_DECIMAL = 387,
    SQL_PARTITION = 388,
    SQL_CASCADE = 389,
    SQL_ADD = 390,
    SQL_BETWEEN = 391,
    SQL_OP_LESSEQ = 392,
    SQL_MATCH = 393,
    SQL_ALL = 394,
    SQL_ROWS = 395,
    SQL_JOIN = 396,
    SQL_LIKE = 397,
    SQL_OP_RP = 398,
    SQL_IGNORE = 399,
    SQL_INT = 400,
    SQL_UNSIGNED = 401,
    SQL_MEDIUMTEXT = 402,
    SQL_BOOLEAN = 403,
    SQL_KEY = 404,
    SQL_EACH = 405,
    SQL_USING = 406,
    SQL_RENAME = 407,
    SQL_DO = 408,
    SQL_OP_LP = 409,
    SQL_CHARACTER = 410,
    SQL_UMINUS = 411,
    SQL_CAST = 412,
    SQL_COALESCE = 413,
    SQL_GROUPS = 414,
    SQL_OUTER = 415,
    SQL_NULL = 416,
    SQL_SMALLINT = 417,
    SQL_EXCLUSIVE = 418,
    SQL_TEMPORARY = 419,
    SQL_CONSTRAINT = 420,
    SQL_CREATE = 421,
    SQL_OP_LBRACKET = 422,
    SQL_WHEN = 423,
    SQL_IMMEDIATE = 424,
    SQL_TO = 425,
    SQL_BTREE = 426,
    SQL_DAY = 427,
    SQL_CONFLICT = 428,
    SQL_ROW_FORMAT = 429,
    SQL_OP_RBRACKET = 430,
    SQL_EXISTS = 431,
    SQL_INSERT = 432,
    SQL_KEYS = 433,
    SQL_INTO = 434,
    SQL_OP_DIVIDE = 435,
    SQL_CASCADED = 436,
    SQL_ISNULL = 437,
    SQL_AS = 438,
    SQL_INNER = 439,
    SQL_INTERSECT = 440,
    SQL_IN = 441,
    SQL_OP_EQUAL = 442,
    SQL_VARCHAR = 443,
    SQL_COPY = 444,
    SQL_ALTER = 445,
    SQL_DESC = 446,
    SQL_FROM = 447,
    SQL_TINYTEXT = 448,
    SQL_FLOAT = 449,
    SQL_SECOND = 450,
    SQL_WINDOW = 451,
    SQL_NOTHING = 452,
    SQL_HAVING = 453,
    SQL_MAX = 454,
    SQL_MIN = 455,
    SQL_DOT = 456,
    SQL_INTLITERAL = 457,
    SQL_FLOATLITERAL = 458,
    SQL_IDENTIFIER = 459,
    SQL_STRINGLITERAL = 460
  };
#endif

/* Value type.  */
#if ! defined FF_STYPE && ! defined FF_STYPE_IS_DECLARED
#line 30 "bison.y"
union FF_STYPE
{
#line 30 "bison.y"

	long	ival;
	char*	sval;
	double	fval;
	Program *	program_t;
	Stmtlist *	stmtlist_t;
	Stmt *	stmt_t;
	CreateStmt *	create_stmt_t;
	DropStmt *	drop_stmt_t;
	AlterStmt *	alter_stmt_t;
	SelectStmt *	select_stmt_t;
	SelectWithParens *	select_with_parens_t;
	SelectNoParens *	select_no_parens_t;
	SelectClauseList *	select_clause_list_t;
	SelectClause *	select_clause_t;
	CombineClause *	combine_clause_t;
	OptFromClause *	opt_from_clause_t;
	SelectTarget *	select_target_t;
	OptWindowClause *	opt_window_clause_t;
	WindowClause *	window_clause_t;
	WindowDefList *	window_def_list_t;
	WindowDef *	window_def_t;
	WindowName *	window_name_t;
	Window *	window_t;
	OptPartition *	opt_partition_t;
	OptFrameClause *	opt_frame_clause_t;
	RangeOrRows *	range_or_rows_t;
	FrameBoundStart *	frame_bound_start_t;
	FrameBoundEnd *	frame_bound_end_t;
	FrameBound *	frame_bound_t;
	OptExistWindowName *	opt_exist_window_name_t;
	OptGroupClause *	opt_group_clause_t;
	OptHavingClause *	opt_having_clause_t;
	OptWhereClause *	opt_where_clause_t;
	WhereClause *	where_clause_t;
	FromClause *	from_clause_t;
	TableRef *	table_ref_t;
	OptIndex *	opt_index_t;
	OptOn *	opt_on_t;
	OptUsing *	opt_using_t;
	ColumnNameList *	column_name_list_t;
	OptTablePrefix *	opt_table_prefix_t;
	JoinOp *	join_op_t;
	OptJoinType *	opt_join_type_t;
	ExprList *	expr_list_t;
	OptLimitClause *	opt_limit_clause_t;
	LimitClause *	limit_clause_t;
	OptLimitRowCount *	opt_limit_row_count_t;
	OptOrderClause *	opt_order_clause_t;
	OptOrderNulls *	opt_order_nulls_t;
	OrderItemList *	order_item_list_t;
	OrderItem *	order_item_t;
	OptOrderBehavior *	opt_order_behavior_t;
	OptWithClause *	opt_with_clause_t;
	CteTableList *	cte_table_list_t;
	CteTable *	cte_table_t;
	CteTableName *	cte_table_name_t;
	OptAllOrDistinct *	opt_all_or_distinct_t;
	CreateTableStmt *	create_table_stmt_t;
	CreateIndexStmt *	create_index_stmt_t;
	CreateTriggerStmt *	create_trigger_stmt_t;
	CreateViewStmt *	create_view_stmt_t;
	OptTableOptionList *	opt_table_option_list_t;
	TableOptionList *	table_option_list_t;
	TableOption *	table_option_t;
	OptOpComma *	opt_op_comma_t;
	OptIgnoreOrReplace *	opt_ignore_or_replace_t;
	OptViewAlgorithm *	opt_view_algorithm_t;
	OptSqlSecurity *	opt_sql_security_t;
	OptIndexOption *	opt_index_option_t;
	OptExtraOption *	opt_extra_option_t;
	IndexAlgorithmOption *	index_algorithm_option_t;
	LockOption *	lock_option_t;
	OptOpEqual *	opt_op_equal_t;
	TriggerEvents *	trigger_events_t;
	TriggerName *	trigger_name_t;
	TriggerActionTime *	trigger_action_time_t;
	DropIndexStmt *	drop_index_stmt_t;
	DropTableStmt *	drop_table_stmt_t;
	OptRestrictOrCascade *	opt_restrict_or_cascade_t;
	DropTriggerStmt *	drop_trigger_stmt_t;
	DropViewStmt *	drop_view_stmt_t;
	InsertStmt *	insert_stmt_t;
	InsertRest *	insert_rest_t;
	SuperValuesList *	super_values_list_t;
	ValuesList *	values_list_t;
	OptOnConflict *	opt_on_conflict_t;
	OptConflictExpr *	opt_conflict_expr_t;
	IndexedColumnList *	indexed_column_list_t;
	IndexedColumn *	indexed_column_t;
	UpdateStmt *	update_stmt_t;
	AlterAction *	alter_action_t;
	AlterConstantAction *	alter_constant_action_t;
	ColumnDefList *	column_def_list_t;
	ColumnDef *	column_def_t;
	OptColumnConstraintList *	opt_column_constraint_list_t;
	ColumnConstraintList *	column_constraint_list_t;
	ColumnConstraint *	column_constraint_t;
	OptReferenceClause *	opt_reference_clause_t;
	OptCheck *	opt_check_t;
	ConstraintType *	constraint_type_t;
	ReferenceClause *	reference_clause_t;
	OptForeignKey *	opt_foreign_key_t;
	OptForeignKeyActions *	opt_foreign_key_actions_t;
	ForeignKeyActions *	foreign_key_actions_t;
	KeyActions *	key_actions_t;
	OptConstraintAttributeSpec *	opt_constraint_attribute_spec_t;
	OptInitialTime *	opt_initial_time_t;
	ConstraintName *	constraint_name_t;
	OptTemp *	opt_temp_t;
	OptCheckOption *	opt_check_option_t;
	OptColumnNameListP *	opt_column_name_list_p_t;
	SetClauseList *	set_clause_list_t;
	SetClause *	set_clause_t;
	OptAsAlias *	opt_as_alias_t;
	Expr *	expr_t;
	Operand *	operand_t;
	CastExpr *	cast_expr_t;
	CoalesceExpr *   coalesce_expr_t; 
	MaxExpr *  max_expr_t;
	MinExpr *  min_expr_t;
	ScalarExpr *	scalar_expr_t;
	UnaryExpr *	unary_expr_t;
	BinaryExpr *	binary_expr_t;
	LogicExpr *	logic_expr_t;
	InExpr *	in_expr_t;
	CaseExpr *	case_expr_t;
	BetweenExpr *	between_expr_t;
	ExistsExpr *	exists_expr_t;
	FunctionExpr *	function_expr_t;
	OptDistinct *	opt_distinct_t;
	OptFilterClause *	opt_filter_clause_t;
	OptOverClause *	opt_over_clause_t;
	CaseList *	case_list_t;
	CaseClause *	case_clause_t;
	CompExpr *	comp_expr_t;
	ExtractExpr *	extract_expr_t;
	DatetimeField *	datetime_field_t;
	ArrayExpr *	array_expr_t;
	ArrayIndex *	array_index_t;
	Literal *	literal_t;
	StringLiteral *	string_literal_t;
	BoolLiteral *	bool_literal_t;
	NumLiteral *	num_literal_t;
	IntLiteral *	int_literal_t;
	FloatLiteral *	float_literal_t;
	OptColumn *	opt_column_t;
	TriggerBody *	trigger_body_t;
	OptIfNotExist *	opt_if_not_exist_t;
	OptIfExist *	opt_if_exist_t;
	Identifier *	identifier_t;
	AsAlias *	as_alias_t;
	TableName *	table_name_t;
	ColumnName *	column_name_t;
	OptIndexKeyword *	opt_index_keyword_t;
	ViewName *	view_name_t;
	FunctionName *	function_name_t;
	BinaryOp *	binary_op_t;
	OptNot *	opt_not_t;
	Name *	name_t;
	TypeName *	type_name_t;
	TypeNameList *  type_name_list_t;
	CharacterType *	character_type_t;
	CharacterWithLength *	character_with_length_t;
	CharacterWithoutLength *	character_without_length_t;
	CharacterConflicta *	character_conflicta_t;
	NumericType *	numeric_type_t;
	OptTableConstraintList *	opt_table_constraint_list_t;
	TableConstraintList *	table_constraint_list_t;
	TableConstraint *	table_constraint_t;
	OptEnforced *	opt_enforced_t;

#line 532 "bison_parser.cpp"

};
#line 30 "bison.y"
typedef union FF_STYPE FF_STYPE;
# define FF_STYPE_IS_TRIVIAL 1
# define FF_STYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined FF_LTYPE && ! defined FF_LTYPE_IS_DECLARED
typedef struct FF_LTYPE FF_LTYPE;
struct FF_LTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define FF_LTYPE_IS_DECLARED 1
# define FF_LTYPE_IS_TRIVIAL 1
#endif



int ff_parse (Program* result, yyscan_t scanner);

#endif /* !YY_FF_BISON_PARSER_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_int16 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined FF_LTYPE_IS_TRIVIAL && FF_LTYPE_IS_TRIVIAL \
             && defined FF_STYPE_IS_TRIVIAL && FF_STYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE) \
             + YYSIZEOF (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  54
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   1141

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  206
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  166
/* YYNRULES -- Number of rules.  */
#define YYNRULES  419
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  753

#define YYUNDEFTOK  2
#define YYMAXUTOK   460


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   112,   113,   114,
     115,   116,   117,   118,   119,   120,   121,   122,   123,   124,
     125,   126,   127,   128,   129,   130,   131,   132,   133,   134,
     135,   136,   137,   138,   139,   140,   141,   142,   143,   144,
     145,   146,   147,   148,   149,   150,   151,   152,   153,   154,
     155,   156,   157,   158,   159,   160,   161,   162,   163,   164,
     165,   166,   167,   168,   169,   170,   171,   172,   173,   174,
     175,   176,   177,   178,   179,   180,   181,   182,   183,   184,
     185,   186,   187,   188,   189,   190,   191,   192,   193,   194,
     195,   196,   197,   198,   199,   200,   201,   202,   203,   204,
     205
};

#if FF_DEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   433,   433,   443,   450,   459,   465,   471,   477,   483,
     489,   498,   504,   510,   516,   525,   531,   537,   543,   552,
     562,   568,   577,   583,   592,   604,   610,   621,   630,   644,
     649,   654,   659,   666,   672,   689,   695,   703,   712,   718,
     728,   750,   759,   771,   777,   785,   792,   800,   808,   813,
     818,   826,   832,   840,   846,   854,   860,   866,   874,   889,
     897,   904,   912,   918,   926,   932,   940,   949,   958,   969,
     980,   990,  1003,  1009,  1014,  1022,  1028,  1036,  1042,  1050,
    1056,  1066,  1073,  1081,  1086,  1091,  1100,  1105,  1110,  1115,
    1120,  1128,  1136,  1146,  1152,  1160,  1166,  1173,  1183,  1189,
    1197,  1203,  1211,  1216,  1221,  1229,  1235,  1245,  1256,  1261,
    1266,  1274,  1280,  1286,  1294,  1300,  1310,  1320,  1348,  1371,
    1413,  1451,  1488,  1530,  1575,  1581,  1589,  1595,  1606,  1612,
    1618,  1624,  1630,  1636,  1642,  1648,  1654,  1663,  1668,  1676,
    1681,  1686,  1694,  1699,  1704,  1709,  1717,  1722,  1727,  1735,
    1740,  1745,  1753,  1759,  1765,  1773,  1779,  1785,  1794,  1800,
    1806,  1812,  1821,  1826,  1834,  1839,  1844,  1852,  1861,  1866,
    1874,  1896,  1920,  1925,  1930,  1938,  1960,  1983,  1996,  2003,
    2009,  2019,  2025,  2035,  2044,  2050,  2058,  2066,  2073,  2081,
    2087,  2097,  2107,  2118,  2132,  2150,  2182,  2201,  2220,  2229,
    2234,  2239,  2244,  2249,  2255,  2260,  2268,  2274,  2284,  2304,
    2312,  2320,  2326,  2336,  2345,  2352,  2360,  2367,  2375,  2380,
    2385,  2391,  2399,  2442,  2447,  2455,  2461,  2469,  2474,  2479,
    2484,  2490,  2499,  2504,  2509,  2514,  2519,  2527,  2533,  2539,
    2547,  2552,  2557,  2565,  2574,  2579,  2587,  2592,  2597,  2602,
    2610,  2616,  2624,  2630,  2640,  2647,  2657,  2663,  2671,  2677,
    2683,  2689,  2695,  2701,  2707,  2712,  2717,  2725,  2731,  2737,
    2743,  2749,  2755,  2761,  2767,  2773,  2779,  2788,  2798,  2803,
    2811,  2819,  2827,  2833,  2842,  2848,  2854,  2860,  2866,  2872,
    2877,  2885,  2891,  2899,  2906,  2916,  2923,  2933,  2941,  2949,
    2960,  2967,  2973,  2981,  2991,  2999,  3010,  3020,  3028,  3041,
    3046,  3054,  3060,  3068,  3074,  3080,  3088,  3094,  3104,  3114,
    3121,  3128,  3135,  3142,  3149,  3159,  3169,  3174,  3179,  3184,
    3189,  3194,  3202,  3211,  3221,  3227,  3233,  3242,  3251,  3256,
    3264,  3270,  3279,  3287,  3295,  3300,  3308,  3314,  3320,  3326,
    3335,  3340,  3348,  3353,  3361,  3370,  3388,  3406,  3422,  3439,
    3444,  3449,  3454,  3462,  3471,  3489,  3494,  3499,  3504,  3509,
    3514,  3522,  3527,  3535,  3544,  3550,  3559,  3564,  3572,  3578,
    3587,  3597,  3603,  3608,  3613,  3621,  3626,  3631,  3636,  3641,
    3646,  3651,  3656,  3661,  3666,  3674,  3679,  3684,  3689,  3694,
    3699,  3704,  3709,  3714,  3719,  3724,  3729,  3734,  3739,  3747,
    3753,  3761,  3767,  3777,  3784,  3791,  3799,  3826,  3831,  3836
};
#endif

#if FF_DEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "OP_NOTEQUAL", "ENABLE", "SIMPLE",
  "TEXT", "OVER", "YEAR", "INSERT_METHOD", "OP_SEMI", "BIGINT", "LIMIT",
  "OP_GREATERTHAN", "WITH", "ORDER", "OPTION", "LAST", "UNBOUNDED",
  "PRECEDING", "EXCEPT", "NUMERIC", "OP_LESSTHAN", "ACTION", "BEFORE",
  "OP_GREATEREQ", "CHECK", "COMPACT", "FULL", "NATURAL", "BINARY",
  "NATIONAL", "ENUM", "REDUNDANT", "OP_ADD", "CURRENT", "MERGE", "TRIGGER",
  "COMPRESSED", "OP_SUB", "FALSE", "UNIQUE", "WHERE", "MINUTE", "FIRST",
  "ON", "PARTIAL", "DOUBLE", "AFTER", "PRIMARY", "MONTH", "DEFERRED",
  "VALUES", "LONGTEXT", "SQL", "SHARED", "VALIDATION", "OR", "VIEW",
  "INDEX", "GROUP", "OP_MUL", "INPLACE", "FOREIGN", "RESTRICT", "SPATIAL",
  "FOLLOWING", "DEC", "SELECT", "NONE", "DISTINCT", "TRUE", "DYNAMIC",
  "BY", "OP_MOD", "INTEGER", "SECURITY", "IS", "DEFINER", "ROW",
  "ENFORCED", "END", "RECURSIVE", "FOR", "TEMPTABLE", "UNION", "NULLS",
  "UPDATE", "ELSE", "RANGE", "SET", "INVOKER", "OFFSET", "INDEXED",
  "FORCE", "NCHAR", "AND", "INITIALLY", "PRECISION", "FILTER", "WITHOUT",
  "NOT", "DELETE", "DEFFERRABLE", "REAL", "THEN", "UNDEFINED", "DEFAULT",
  "CROSS", "CHAR", "REFERENCES", "OP_XOR", "CASE", "FIXED", "HOUR", "NO",
  "COLUMN", "LOCAL", "DROP", "REPLACE", "ASC", "OP_COMMA", "DISABLE",
  "TABLE", "ARRAY", "IF", "EXTRACT", "LEFT", "FULLTEXT", "HASH",
  "ALGORITHM", "LOCK", "DECIMAL", "PARTITION", "CASCADE", "ADD", "BETWEEN",
  "OP_LESSEQ", "MATCH", "ALL", "ROWS", "JOIN", "LIKE", "OP_RP", "IGNORE",
  "INT", "UNSIGNED", "MEDIUMTEXT", "BOOLEAN", "KEY", "EACH", "USING",
  "RENAME", "DO", "OP_LP", "CHARACTER", "UMINUS", "CAST", "COALESCE",
  "GROUPS", "OUTER", "NULL", "SMALLINT", "EXCLUSIVE", "TEMPORARY",
  "CONSTRAINT", "CREATE", "OP_LBRACKET", "WHEN", "IMMEDIATE", "TO",
  "BTREE", "DAY", "CONFLICT", "ROW_FORMAT", "OP_RBRACKET", "EXISTS",
  "INSERT", "KEYS", "INTO", "OP_DIVIDE", "CASCADED", "ISNULL", "AS",
  "INNER", "INTERSECT", "IN", "OP_EQUAL", "VARCHAR", "COPY", "ALTER",
  "DESC", "FROM", "TINYTEXT", "FLOAT", "SECOND", "WINDOW", "NOTHING",
  "HAVING", "MAX", "MIN", "DOT", "INTLITERAL", "FLOATLITERAL",
  "IDENTIFIER", "STRINGLITERAL", "$accept", "program", "stmtlist", "stmt",
  "create_stmt", "drop_stmt", "alter_stmt", "select_stmt",
  "select_with_parens", "select_no_parens", "select_clause_list",
  "select_clause", "combine_clause", "opt_from_clause",
  "opt_window_clause", "window_clause", "window_def_list", "window_def",
  "window_name", "window", "opt_partition", "opt_frame_clause",
  "range_or_rows", "frame_bound_start", "frame_bound_end", "frame_bound",
  "opt_exist_window_name", "opt_group_clause", "opt_having_clause",
  "opt_where_clause", "where_clause", "from_clause", "table_ref",
  "opt_index", "opt_on", "opt_using", "column_name_list",
  "opt_table_prefix", "join_op", "opt_join_type", "expr_list",
  "opt_limit_clause", "limit_clause", "opt_limit_row_count",
  "opt_order_clause", "opt_order_nulls", "order_item_list", "order_item",
  "opt_order_behavior", "opt_with_clause", "cte_table_list", "cte_table",
  "cte_table_name", "create_table_stmt", "create_index_stmt",
  "create_trigger_stmt", "create_view_stmt", "opt_table_option_list",
  "table_option_list", "table_option", "opt_op_comma",
  "opt_ignore_or_replace", "opt_view_algorithm", "opt_sql_security",
  "opt_index_option", "opt_extra_option", "index_algorithm_option",
  "lock_option", "opt_op_equal", "trigger_events", "trigger_name",
  "trigger_action_time", "drop_index_stmt", "drop_table_stmt",
  "opt_restrict_or_cascade", "drop_trigger_stmt", "drop_view_stmt",
  "insert_stmt", "insert_rest", "super_values_list", "values_list",
  "opt_on_conflict", "opt_conflict_expr", "indexed_column_list",
  "indexed_column", "update_stmt", "alter_action", "alter_constant_action",
  "column_def_list", "column_def", "opt_column_constraint_list",
  "column_constraint_list", "column_constraint", "opt_reference_clause",
  "opt_check", "constraint_type", "reference_clause", "opt_foreign_key",
  "opt_foreign_key_actions", "foreign_key_actions", "key_actions",
  "opt_constraint_attribute_spec", "opt_initial_time", "constraint_name",
  "opt_temp", "opt_check_option", "opt_column_name_list_p",
  "set_clause_list", "set_clause", "opt_as_alias", "expr", "operand",
  "cast_expr", "coalesce_expr", "max_expr", "min_expr", "scalar_expr",
  "unary_expr", "binary_expr", "logic_expr", "in_expr", "case_expr",
  "between_expr", "exists_expr", "function_expr", "opt_distinct",
  "opt_filter_clause", "opt_over_clause", "case_list", "case_clause",
  "comp_expr", "extract_expr", "datetime_field", "array_expr",
  "array_index", "literal", "string_literal", "bool_literal",
  "num_literal", "int_literal", "float_literal", "opt_column",
  "trigger_body", "opt_if_not_exist", "opt_if_exist", "identifier",
  "as_alias", "table_name", "column_name", "opt_index_keyword",
  "view_name", "function_name", "binary_op", "opt_not", "name",
  "type_name", "type_name_list", "character_type", "character_with_length",
  "character_without_length", "character_conflicta", "numeric_type",
  "opt_table_constraint_list", "table_constraint_list", "table_constraint",
  "opt_enforced", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323,   324,
     325,   326,   327,   328,   329,   330,   331,   332,   333,   334,
     335,   336,   337,   338,   339,   340,   341,   342,   343,   344,
     345,   346,   347,   348,   349,   350,   351,   352,   353,   354,
     355,   356,   357,   358,   359,   360,   361,   362,   363,   364,
     365,   366,   367,   368,   369,   370,   371,   372,   373,   374,
     375,   376,   377,   378,   379,   380,   381,   382,   383,   384,
     385,   386,   387,   388,   389,   390,   391,   392,   393,   394,
     395,   396,   397,   398,   399,   400,   401,   402,   403,   404,
     405,   406,   407,   408,   409,   410,   411,   412,   413,   414,
     415,   416,   417,   418,   419,   420,   421,   422,   423,   424,
     425,   426,   427,   428,   429,   430,   431,   432,   433,   434,
     435,   436,   437,   438,   439,   440,   441,   442,   443,   444,
     445,   446,   447,   448,   449,   450,   451,   452,   453,   454,
     455,   456,   457,   458,   459,   460
};
# endif

#define YYPACT_NINF (-371)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-373)

#define yytable_value_is_error(Yyn) \
  ((Yyn) == YYTABLE_NINF)

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      47,   -58,  -108,    69,     7,   223,   -69,   169,  -371,   239,
    -371,  -371,  -371,  -371,  -371,  -371,   -21,  -371,  -371,  -371,
    -371,  -371,  -371,  -371,  -371,  -371,  -371,    68,  -371,  -371,
     208,   150,  -371,   184,    68,   203,   268,   268,    68,  -371,
     290,   271,   277,   329,    68,  -371,   298,  -371,  -371,   237,
     371,   312,   379,    68,  -371,    13,   -49,   257,   424,     0,
    -371,    68,   287,    68,  -371,   203,    68,   352,  -371,   270,
      68,    68,   240,   268,  -371,  -371,   358,  -371,   314,   199,
     372,   391,   325,    68,   134,  -371,   269,  -371,   310,    68,
     387,   456,  -371,   330,  -371,   329,  -371,     7,   328,   273,
     278,   357,   382,  -371,   137,  -371,  -371,  -371,    10,   293,
     293,  -371,  -371,  -371,    68,  -371,  -371,    45,   371,  -371,
    -371,  -371,   -32,    68,   380,    68,   437,   305,   428,  -371,
     429,    93,   308,   388,   -29,  -371,  -371,  -371,  -371,   446,
    -371,   333,   203,   333,   333,  -371,  -371,  -371,  -371,   350,
    -371,    68,    68,   137,    68,   446,   374,   322,  -371,  -371,
    -371,  -371,   -23,   171,    10,  -371,  -371,  -371,   461,   452,
    -371,  -371,   184,   338,    14,    68,  -371,  -371,  -371,   366,
    -371,    68,  -371,    68,    68,    68,   125,   144,   333,   457,
    -371,   351,  -371,  -371,  -371,   351,   912,   360,   376,   297,
     389,   390,  -371,   392,   393,  -371,  -371,  -371,   385,    -7,
     728,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,
    -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,
    -371,  -371,  -371,  -371,   146,  -371,   394,   355,   184,  -371,
     413,   -19,   236,  -371,  -371,  -371,   446,   398,   424,   137,
     333,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,    68,
      68,   359,  -371,   293,    68,   293,   261,  -371,    42,   395,
    -371,  -371,  -371,   492,  -371,   399,   -41,  -371,  -371,  -371,
      44,   396,   203,   403,   306,   479,   362,   351,   130,   910,
     333,    24,    83,   397,   333,    67,   417,   418,   333,   333,
     333,   333,   203,   333,   333,   441,   351,   351,   351,   351,
    -371,  -371,  -371,  -371,   143,   274,  -371,   351,   351,   351,
     361,  -371,  -371,   351,   351,   378,    -4,   414,   525,    26,
     333,  -371,  -371,   486,   333,   333,   424,   401,   562,  -371,
     306,   493,   184,     7,    63,   410,   458,   252,  -371,  -371,
     400,  -371,    19,   333,  -371,  -371,  -371,  -371,   121,  -371,
     480,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,
    -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,   492,
     254,  -371,  -371,  -371,   423,  -371,    68,  -371,   420,  -371,
     440,   442,    16,   295,   333,   333,    68,  -371,  -371,   448,
     303,   228,  -371,   333,  -371,   409,  -371,  -371,  -371,  -371,
    -371,  -371,   402,  -371,  -371,    34,   450,   -25,   151,   172,
     269,   495,  -371,   333,   954,   653,   653,   653,   434,  -371,
     351,   351,   779,   653,   954,   425,   954,   130,   152,  -371,
     499,   333,   585,   430,  -371,   453,   552,  -371,  -371,   318,
    -371,   306,   306,   562,   333,   333,  -371,   459,   431,   594,
    -371,  -371,  -371,    68,   377,   470,  -371,   494,    68,  -371,
    -371,  -371,  -371,  -371,  -371,     7,  -371,   473,   496,   -19,
    -371,  -371,  -371,  -371,  -371,   469,   460,   333,  -371,   593,
     254,  -371,   361,  -371,  -371,  -371,   203,   203,   547,   530,
     580,   483,   432,  -371,   506,   445,  -371,   333,  -371,   333,
     285,  -371,   333,   492,  -371,  -371,  -371,  -371,   446,  -371,
    -371,   859,   954,   351,  -371,   297,  -371,   475,   627,   500,
     502,   481,   333,  -371,   515,  -371,  -371,  -371,  -371,   306,
     306,   567,     7,    -8,  -371,  -371,  -371,   498,   501,   504,
     507,    19,   410,  -371,  -371,   497,   333,  -371,  -371,  -371,
     306,   505,   244,  -371,   521,   580,   580,    68,  -371,   333,
     514,   203,   333,  -371,    68,   513,   306,   319,  -371,   174,
     526,   457,   351,   863,   527,   531,   607,   160,  -371,   499,
    -371,   333,   523,   536,   453,     8,   594,   634,   662,   663,
     333,   333,   537,   539,  -371,  -371,   -81,   240,  -371,   333,
     541,  -371,   586,  -371,   514,   514,  -371,   306,   544,  -371,
     580,   306,  -371,    68,  -371,  -371,  -371,   362,   910,  -371,
    -371,   333,    68,  -371,   627,   556,   -52,  -371,  -371,  -371,
    -371,   524,  -371,  -371,  -371,  -371,  -371,   684,   686,   179,
     561,   333,    68,  -371,  -371,  -371,   188,  -371,    68,  -371,
    -371,  -371,    68,   514,   563,   572,  -371,  -371,   196,   565,
    -371,   446,   137,  -371,  -371,  -371,    35,  -371,   566,   568,
      35,   184,   569,  -371,  -371,   637,   424,  -371,  -371,  -371,
     446,  -371,   635,  -371,  -371,   586,  -371,   -15,  -371,   333,
     149,  -371,  -371,  -371,   -46,   373,   327,  -371,  -371,  -371,
    -371,  -371,  -371,   571,   235,   235,  -371,  -371,  -371,   613,
     620,  -371,   699,   640,   623,  -371,  -371,   283,  -371,   135,
     697,  -371,  -371,  -371,   620,   -20,  -371,  -371,  -371,   625,
    -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,   642,   656,
    -371,  -371,  -371
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int16 yydefact[] =
{
     113,     0,     0,   245,   113,   145,     0,     0,     2,     0,
       5,     6,    10,     7,    21,    20,     0,    11,    12,    13,
      14,    15,    16,    17,    18,     9,     8,     0,   354,   111,
     114,     0,   356,   251,     0,   257,   353,   353,     0,   244,
       0,     0,     0,     0,     0,   359,     0,   361,   360,     0,
     148,     0,     0,     0,     1,   113,     0,     0,   101,    25,
     112,     0,     0,     0,   117,   257,     0,     0,   256,     0,
       0,     0,   154,   353,    23,    22,     0,   167,   145,     0,
       0,     0,   351,     0,     0,     3,    34,   364,     0,     0,
       0,    94,    31,    29,    30,     0,   115,   113,     0,   357,
       0,    79,     0,   355,     0,   352,   175,   363,   174,   163,
     163,   170,   152,   153,     0,   168,   169,     0,   148,   143,
     144,   142,     0,     0,     0,     0,     0,     0,     0,   200,
       0,   345,     0,   345,   345,   203,    19,   198,    82,    65,
      33,   372,   257,   372,   372,    24,    93,    32,    26,     0,
     250,     0,     0,     0,     0,    65,   252,     0,   172,   173,
     176,   162,     0,     0,   174,   166,   164,   165,     0,     0,
     146,   147,   251,     0,   125,     0,   202,   204,   205,     0,
     344,     0,   201,     0,     0,     0,    67,     0,   372,    61,
      64,     0,   339,   290,   338,   371,   372,     0,     0,   113,
       0,     0,   289,     0,     0,   342,   343,   337,     0,   257,
     258,   262,   264,   265,   266,   269,   270,   271,   263,   261,
     272,   259,   260,   275,   291,   273,   274,   268,   283,   334,
     335,   336,   340,   341,   357,   282,     0,     0,   251,   100,
     105,   110,    95,   116,   358,    80,    65,     0,   101,     0,
     372,   156,   155,   157,   160,   159,   158,   161,   171,     0,
       0,     0,   350,   163,     0,   163,   141,   124,   126,     0,
     199,   197,   196,     0,   194,     0,    90,    83,    84,    81,
      82,   356,   257,     0,    66,     0,    36,     0,   284,   285,
     372,     0,     0,   316,   372,     0,     0,     0,   372,   372,
     372,   372,   257,   372,   372,    92,     0,     0,     0,     0,
     365,   366,   369,   368,     0,   371,   370,     0,     0,     0,
       0,   367,   286,     0,     0,     0,   310,     0,   186,   113,
     372,   108,   109,   104,   372,   372,   101,     0,    99,   253,
     254,     0,   251,   113,     0,   410,   206,     0,   140,   139,
       0,   137,     0,   372,   388,   398,   406,   384,     0,   383,
     402,   391,   405,   396,   382,   394,   399,   386,   401,   404,
     395,   408,   390,   407,   385,   397,   387,   389,   400,   376,
     210,   375,   378,   379,   381,   374,     0,    89,    86,    88,
       0,     0,     0,    74,   372,   372,     0,    27,    35,     0,
       0,     0,   301,   372,   317,     0,   331,   327,   330,   328,
     329,   326,     0,   276,   267,     0,     0,   257,     0,     0,
      34,   296,   295,   372,   320,   321,   322,   324,     0,   287,
       0,     0,     0,   323,   293,     0,   319,   292,     0,   309,
     312,   372,   113,     0,   177,     0,     0,   178,   106,     0,
     107,    96,    97,    99,   372,   372,   193,     0,     0,   249,
     130,   129,   128,     0,     0,     0,   409,   411,     0,   136,
     135,   134,   132,   131,   133,   113,   127,     0,   189,   110,
     393,   392,   403,   377,   220,     0,     0,   372,   208,   217,
     211,   213,     0,   195,    87,    85,   257,   257,     0,     0,
      76,     0,    63,    37,    38,     0,    41,   372,   300,   372,
       0,   332,   372,     0,   279,   278,   280,   281,    65,    91,
     288,     0,   294,     0,   333,   113,   299,     0,   315,     0,
       0,   188,   372,   180,   181,   179,   103,   102,   192,   255,
      98,     0,   113,     0,   122,   373,   243,     0,     0,     0,
       0,   125,     0,   207,   118,   151,   372,   191,   218,   219,
     221,     0,   215,   212,     0,    76,    76,     0,    73,   372,
      78,   257,   372,    60,     0,     0,   318,     0,   303,     0,
       0,    61,     0,   304,     0,     0,     0,     0,   307,   312,
     306,   372,     0,     0,     0,   113,   249,     0,     0,     0,
     372,   372,     0,     0,   119,   412,     0,   154,   190,   372,
       0,   209,     0,   380,    78,    78,    72,    75,     0,    68,
      76,    62,    39,    59,   302,   325,   277,    36,   305,   297,
     298,   372,    59,   314,   315,     0,     0,   183,   182,   346,
     349,     0,   348,   347,   121,   123,   246,     0,     0,     0,
       0,   372,     0,   150,   149,   120,     0,   223,     0,   214,
      70,    71,     0,    78,     0,    44,    58,    28,     0,     0,
     308,     0,     0,   184,   248,   247,   419,   414,     0,     0,
     419,   251,     0,    69,    40,     0,   101,   311,   313,   187,
       0,   417,     0,   415,   413,     0,   216,   226,    77,   372,
      47,   185,   418,   416,     0,     0,   239,   225,    43,    48,
      49,    50,    42,   372,     0,     0,   229,   227,   228,     0,
     242,   222,     0,     0,   372,    45,    51,     0,   235,     0,
       0,   234,   230,   231,   242,     0,   237,    52,    57,     0,
      55,    56,   233,   232,   236,   238,   240,   241,   372,     0,
      46,    53,    54
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -371,  -371,   668,  -371,  -371,   131,   138,   -86,   730,     1,
     641,  -371,  -371,   317,   111,  -371,   165,  -371,   153,   110,
    -371,  -371,  -371,    20,  -371,    -3,  -371,   167,  -371,  -141,
    -370,  -371,   466,  -371,  -253,  -271,  -144,  -371,  -371,  -371,
    -180,  -371,  -371,   299,  -239,  -371,   421,  -371,   276,     2,
     260,  -371,  -371,  -371,  -371,  -371,  -371,   205,   405,  -371,
    -371,  -371,   680,   643,  -371,   156,  -371,   675,   -38,  -371,
     690,  -371,  -371,  -371,   601,  -371,  -371,   177,  -371,   175,
    -371,  -371,  -371,  -324,  -371,   183,  -371,  -371,   311,   600,
    -371,   296,  -371,  -371,  -371,  -371,    90,  -371,  -371,  -371,
      72,  -371,    54,  -371,   786,   197,  -165,  -147,  -371,   -31,
     -80,  -112,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,
    -371,  -371,  -371,  -371,  -371,  -371,   206,   163,   140,  -371,
    -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -371,  -305,
    -371,   250,  -371,  -371,    62,    -1,  -371,    15,   -60,  -371,
     -98,   -27,  -371,   584,  -371,   294,   419,  -371,  -371,  -371,
    -371,  -371,  -371,   256,  -371,   126
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     7,     8,     9,    10,    11,    12,    13,    14,    15,
      58,    59,    95,   139,   397,   398,   503,   504,   505,   664,
     686,   712,   713,   725,   750,   726,   665,   286,   573,   189,
     190,   140,   186,   500,   570,   619,    98,   187,   279,   390,
     208,   145,   146,   456,    91,   450,   239,   240,   333,    43,
      29,    30,    31,    17,    18,    19,    20,   266,   267,   268,
     352,   350,    50,    81,   607,   111,   112,   113,   162,   168,
      76,   117,    21,    22,   160,    23,    24,    25,   328,   533,
     534,   444,   592,   477,   478,    26,   136,   137,   345,   346,
     488,   489,   490,   611,   562,   491,   659,   612,   706,   707,
     732,   721,   736,   464,    40,   544,    64,   155,   156,   305,
     209,   210,   211,   212,   213,   214,   215,   216,   217,   218,
     219,   220,   221,   222,   223,   441,   528,   588,   292,   293,
     224,   225,   412,   226,   227,   228,   229,   230,   231,   232,
     233,   181,   644,   125,    70,   234,    68,   100,   235,    52,
     108,   236,   324,   237,   546,   379,   380,   381,   382,   383,
     384,   385,   465,   466,   467,   693
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
      32,    32,    16,   101,    67,    42,   246,   261,   245,   338,
     247,   149,    86,    -4,   248,   435,    33,    35,   597,   297,
      92,     1,     1,   263,    27,   172,    32,     1,   263,    88,
     704,   746,   303,    32,   102,   672,    34,    32,   303,   251,
       1,   714,    33,    77,   157,   276,   170,    56,   653,    65,
     303,  -138,    32,    72,    53,    87,   715,    16,     1,   171,
      32,     1,    99,   241,   242,   103,   439,   387,    84,    77,
     107,   304,   163,   329,   158,   406,    33,   304,   445,   288,
     460,   303,    32,   289,   252,    93,   388,   180,    32,   304,
     654,   303,   101,   157,   101,     2,    28,   453,   126,    71,
       2,   331,   339,    99,   142,   336,    36,   461,   284,   598,
     407,   238,  -113,    32,   405,   691,   291,   408,   515,   416,
     304,   271,   107,   705,    32,   275,     3,    37,    38,   164,
     304,     3,   165,   446,     2,   114,   692,   277,   127,   440,
     174,   184,   179,   389,   159,   673,    28,   166,   128,   747,
     244,    99,    99,    99,   276,    28,    57,   278,    66,   497,
     283,     4,   342,   351,   402,     3,   253,     4,   264,    54,
     340,   403,   332,   599,    32,   289,    66,   458,   462,     5,
      99,   409,   273,    32,    99,    94,   281,   564,   265,   157,
     269,   312,   290,   265,   424,   425,   426,   427,     6,   274,
     296,     4,   282,     6,   313,   432,   433,   434,   303,   180,
     400,   436,   437,     5,   501,   502,  -138,   513,   415,   417,
     418,   419,   167,   421,   422,   344,   254,   347,   129,   303,
     480,   303,   608,    39,   130,   119,   303,     6,   709,   410,
     255,   316,   742,   519,   428,   303,   277,   304,    99,    55,
     241,   393,   131,   303,   451,   452,   132,   459,    32,   107,
      44,   529,   411,   273,    45,   110,   278,   635,   304,   133,
     304,   420,    28,   479,   341,   304,   481,   650,   256,   469,
      46,   391,  -362,   120,   304,   470,   134,    60,    47,   710,
     471,   154,   304,   303,   516,   484,   743,   320,   280,   728,
    -364,   689,   740,   485,   429,   121,   525,   610,   711,   508,
     321,     1,   614,   615,   632,   517,   509,   625,   521,   522,
     701,    96,   676,   510,   472,   729,   493,   678,   334,    61,
     447,   680,   304,    62,   257,   536,   191,   192,    63,   687,
     303,    28,   303,   660,   661,   585,  -245,  -356,    28,   741,
     730,    48,   593,    49,  -224,   486,    28,   335,   193,   473,
     303,   487,   537,   303,    28,   474,   578,   663,   194,   731,
     109,   110,   191,   192,   539,   540,   303,   581,   716,   304,
     348,   304,   115,   183,   185,    99,    66,    39,   498,   554,
     191,   192,   683,    69,   193,   506,   499,    56,   195,   304,
     624,   717,   304,   547,   194,   349,   116,   560,   507,   196,
     430,   583,   193,    73,    74,   304,   431,    78,   548,   718,
      75,   197,   194,   198,    79,    80,   549,   576,   719,   577,
     720,   401,   579,   404,   195,    82,    89,    32,    83,    90,
     550,    97,   104,   530,    49,   196,   105,   700,   122,   123,
     124,   199,   287,   526,   200,   201,   596,   197,   202,   198,
     143,   138,   545,   196,   141,   565,   566,   273,   144,   147,
     628,   150,   153,  -372,  -356,   197,   479,   198,   152,   151,
     161,   173,   175,   176,   177,   178,   182,   199,   188,   617,
     200,   201,   621,   243,   202,   249,   203,   204,   354,   205,
     206,    28,   207,   355,   180,   199,   259,   616,   679,   250,
     260,   479,   202,   356,   262,   270,   697,   285,   682,   708,
     649,   479,   357,   358,   359,   690,   584,   294,   302,   656,
     295,   327,   203,   204,   330,   205,   206,    28,   207,   360,
     620,   337,   343,   298,   299,   361,   300,   301,   326,   353,
    -364,   668,   395,   205,   206,    28,   207,   394,   396,   362,
     413,   414,   423,   205,   438,   290,    99,   363,   442,   386,
     443,   479,   449,   506,   455,   463,   457,   492,   482,   468,
     494,   495,   364,   475,   511,   496,   506,   365,   454,   722,
     431,   304,   101,   514,   512,   520,   366,   641,   527,     1,
     524,   367,   101,   531,   535,   368,   723,   532,   543,   541,
     191,   192,   157,   551,   542,   552,   555,   556,   558,   561,
     567,   559,   666,   568,   369,   569,   571,   574,   575,   586,
     572,   666,   193,   727,   587,   591,   594,   370,   371,   372,
     373,   722,   194,   589,   727,   590,   595,   374,   606,   631,
     646,    99,   600,   602,   375,   601,   603,    32,   723,   609,
     749,    99,   191,   192,   613,   618,  -373,   623,   727,   626,
     629,    99,   195,   681,   630,  -373,   636,   723,  -373,   637,
     376,   191,   192,   196,   193,   377,   378,   310,   647,   648,
     657,   651,   311,   652,   194,   197,   658,   198,   662,   671,
     674,    57,   675,   193,   677,   685,   684,   724,   688,   694,
     699,   695,   698,   194,   312,   702,   734,   735,   737,   738,
     744,   748,   752,    85,   195,   199,   639,   313,   200,   201,
     314,   306,   202,   640,    41,   196,   148,   518,   667,   622,
     633,   307,   669,   195,   739,   751,   392,   197,   627,   198,
     308,   448,   538,   309,   196,   557,   604,   476,   118,   135,
     106,   169,   310,   655,   316,   258,   197,   311,   198,   638,
     203,   204,   642,   205,   206,    28,   207,   199,   643,   553,
     200,   201,   306,   272,   202,   703,   563,   733,   745,   312,
    -373,    51,   307,   645,   325,   634,   199,   670,   483,   200,
     201,   308,   313,   202,   309,   314,   696,   580,   605,     0,
       0,     0,     0,   310,     0,     0,     0,     0,   311,     0,
     320,     0,   203,   204,     0,   205,   206,    28,   207,   315,
       0,     0,     0,   321,     0,   322,     0,     0,     0,   316,
     312,   203,   204,     0,   205,   206,    28,   207,     0,     0,
       0,     0,     0,   313,     0,     0,   314,     0,     0,     0,
       0,     0,   306,     0,   317,   318,   306,     0,     0,     0,
     319,     0,   307,     0,     0,   523,   307,     0,     0,     0,
     399,   308,     0,     0,   309,   308,     0,     0,   309,     0,
     316,     0,     0,   310,     0,   320,     0,   310,   311,     0,
       0,     0,   311,     0,     0,     0,     0,     0,   321,     0,
     322,     0,     0,   306,  -372,   323,   318,     0,     0,     0,
     312,   319,     0,   307,   312,     0,     0,     0,     0,     0,
       0,     0,   308,   313,     0,   309,   314,   313,     0,     0,
     314,     0,     0,     0,   310,     0,   320,     0,     0,   311,
       0,   191,   192,     0,     0,   582,     0,  -373,     0,   321,
     399,   322,     0,     0,   399,     0,   323,   307,     0,     0,
     316,   312,     0,   193,   316,     0,   308,     0,     0,   309,
       0,     0,     0,   194,   313,     0,     0,   314,   310,     0,
       0,     0,     0,   311,     0,     0,   318,     0,     0,     0,
     318,   319,     0,     0,     0,   319,     0,     0,     0,     0,
       0,     0,     0,   195,     0,   312,     0,     0,     0,     0,
       0,   316,     0,     0,   196,     0,   320,     0,   313,     0,
     320,   314,     0,     0,     0,     0,   197,     0,   198,   321,
       0,   322,     0,   321,     0,   322,   323,   318,     0,     0,
     323,     0,   319,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   316,   199,     0,     0,   200,
     201,     0,     0,   202,     0,     0,     0,   320,     0,     0,
     290,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     321,   318,   322,     0,     0,     0,  -373,   323,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,   203,   204,     0,   205,   206,    28,   207,     0,     0,
       0,   320,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,   321,     0,   322,     0,     0,     0,
       0,  -373
};

static const yytype_int16 yycheck[] =
{
       1,     2,     0,    63,    35,     4,   153,   172,   152,   248,
     154,    97,    61,     0,   155,   320,     1,     2,    26,   199,
      20,    14,    14,     9,    82,   123,    27,    14,     9,    56,
      45,    51,    57,    34,    65,    87,   144,    38,    57,    62,
      14,    87,    27,    44,   104,    29,    78,    68,   129,    34,
      57,     9,    53,    38,   123,    56,   102,    55,    14,    91,
      61,    14,    63,   143,   144,    66,    70,   108,    53,    70,
      71,    96,   110,   238,    64,     8,    61,    96,    52,   191,
      17,    57,    83,   195,   107,    85,   127,   116,    89,    96,
     171,    57,   152,   153,   154,    87,   204,   336,    83,    37,
      87,   120,   249,   104,    89,   246,    37,    44,   188,   117,
      43,   142,    68,   114,   294,    80,   196,    50,   143,   299,
      96,   181,   123,   138,   125,   185,   118,    58,    59,   114,
      96,   118,    87,   107,    87,    73,   101,   121,     4,   143,
     125,   170,    49,   184,   134,   197,   204,   102,    14,   169,
     151,   152,   153,   154,    29,   204,   177,   141,   183,   143,
     187,   154,   260,   121,    81,   118,   189,   154,   154,     0,
     250,    88,   191,   181,   175,   287,   183,   342,   115,   166,
     181,   114,   183,   184,   185,   185,   187,   492,   174,   249,
     175,    61,   168,   174,   306,   307,   308,   309,   190,   184,
     199,   154,   187,   190,    74,   317,   318,   319,    57,   116,
     290,   323,   324,   166,   394,   395,   174,   183,   298,   299,
     300,   301,   177,   303,   304,   263,    55,   265,    94,    57,
     109,    57,   556,   164,   100,    36,    57,   190,    89,   172,
      69,   111,   107,   423,   101,    57,   121,    96,   249,    10,
     330,   282,   118,    57,   334,   335,   122,   343,   259,   260,
      37,   441,   195,   264,    41,   131,   141,   591,    96,   135,
      96,   302,   204,   353,   259,    96,   155,   601,   107,    27,
      57,   280,    59,    84,    96,    33,   152,    27,    65,   140,
      38,   154,    96,    57,   143,    41,   161,   167,   154,    64,
     154,   671,    19,    49,   161,   106,   154,    63,   159,    81,
     180,    14,   565,   566,   154,   143,    88,   143,   430,   431,
     690,    61,   143,   403,    72,    90,   386,   651,    92,   121,
     329,   143,    96,   183,   163,    17,    39,    40,   154,   143,
      57,   204,    57,   614,   615,   525,   123,   201,   204,    66,
     115,   128,   532,   130,   110,   101,   204,   121,    61,   107,
      57,   107,    44,    57,   204,   113,    81,   620,    71,   134,
     130,   131,    39,    40,   454,   455,    57,   518,     5,    96,
     119,    96,    24,   133,   134,   386,   183,   164,    93,   475,
      39,    40,   663,   125,    61,   396,   101,    68,   101,    96,
      81,    28,    96,    26,    71,   144,    48,   487,   105,   112,
     136,   523,    61,   123,   143,    96,   142,   119,    41,    46,
     143,   124,    71,   126,   187,    54,    49,   507,   101,   509,
     103,   291,   512,   293,   101,   123,   179,   438,    59,    15,
      63,   154,    90,   442,   130,   112,   176,   686,    76,    58,
     125,   154,   101,   438,   157,   158,   542,   124,   161,   126,
      73,   192,   463,   112,   154,   496,   497,   468,    12,   139,
     582,   143,    90,   176,   201,   124,   556,   126,   121,   201,
     187,   101,    45,   178,    56,    56,   178,   154,    42,   569,
     157,   158,   572,   143,   161,   121,   199,   200,     6,   202,
     203,   204,   205,    11,   116,   154,    45,   567,   652,   187,
      58,   591,   161,    21,   176,   149,   681,    60,   662,   699,
     600,   601,    30,    31,    32,   672,   525,   167,   143,   609,
     154,   176,   199,   200,   121,   202,   203,   204,   205,    47,
     571,   143,   183,   154,   154,    53,   154,   154,   154,   154,
     154,   631,    73,   202,   203,   204,   205,   154,   196,    67,
     143,   143,   121,   202,   186,   168,   567,    75,   154,   170,
      45,   651,    86,   574,    12,   165,    83,   154,    98,   121,
     160,   141,    90,   183,   175,   143,   587,    95,   187,    18,
     142,    96,   652,   143,   192,   161,   104,   595,    99,    14,
     175,   109,   662,   173,    52,   113,    35,   154,    14,   150,
      39,    40,   672,   143,   183,   121,   143,   121,   149,    26,
      73,   161,   623,    93,   132,    45,   143,   121,   183,   154,
     198,   632,    61,   713,     7,   154,   121,   145,   146,   147,
     148,    18,    71,   143,   724,   143,    79,   155,   151,    42,
      16,   652,   154,   149,   162,   154,   149,   658,    35,   154,
      18,   662,    39,    40,   143,   151,    13,   154,   748,   143,
     143,   672,   101,   658,   143,    22,   153,    35,    25,   143,
     188,    39,    40,   112,    61,   193,   194,    34,    26,    26,
     149,   154,    39,   154,    71,   124,   110,   126,   154,   143,
      16,   177,    16,    61,   143,   133,   143,   136,   143,   143,
      73,   143,   143,    71,    61,    80,   103,    97,    19,    79,
      23,    96,    66,    55,   101,   154,   595,    74,   157,   158,
      77,     3,   161,   595,     4,   112,    95,   420,   627,   574,
     587,    13,   632,   101,   724,   748,   280,   124,   581,   126,
      22,   330,   453,    25,   112,   479,   551,   352,    78,    84,
      70,   118,    34,   607,   111,   164,   124,    39,   126,   594,
     199,   200,   595,   202,   203,   204,   205,   154,   595,   468,
     157,   158,     3,   183,   161,   695,   490,   715,   734,    61,
     137,     5,    13,   596,   210,   589,   154,   634,   379,   157,
     158,    22,    74,   161,    25,    77,   680,   513,   552,    -1,
      -1,    -1,    -1,    34,    -1,    -1,    -1,    -1,    39,    -1,
     167,    -1,   199,   200,    -1,   202,   203,   204,   205,   101,
      -1,    -1,    -1,   180,    -1,   182,    -1,    -1,    -1,   111,
      61,   199,   200,    -1,   202,   203,   204,   205,    -1,    -1,
      -1,    -1,    -1,    74,    -1,    -1,    77,    -1,    -1,    -1,
      -1,    -1,     3,    -1,   136,   137,     3,    -1,    -1,    -1,
     142,    -1,    13,    -1,    -1,    96,    13,    -1,    -1,    -1,
     101,    22,    -1,    -1,    25,    22,    -1,    -1,    25,    -1,
     111,    -1,    -1,    34,    -1,   167,    -1,    34,    39,    -1,
      -1,    -1,    39,    -1,    -1,    -1,    -1,    -1,   180,    -1,
     182,    -1,    -1,     3,   186,   187,   137,    -1,    -1,    -1,
      61,   142,    -1,    13,    61,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    22,    74,    -1,    25,    77,    74,    -1,    -1,
      77,    -1,    -1,    -1,    34,    -1,   167,    -1,    -1,    39,
      -1,    39,    40,    -1,    -1,    96,    -1,     3,    -1,   180,
     101,   182,    -1,    -1,   101,    -1,   187,    13,    -1,    -1,
     111,    61,    -1,    61,   111,    -1,    22,    -1,    -1,    25,
      -1,    -1,    -1,    71,    74,    -1,    -1,    77,    34,    -1,
      -1,    -1,    -1,    39,    -1,    -1,   137,    -1,    -1,    -1,
     137,   142,    -1,    -1,    -1,   142,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,   101,    -1,    61,    -1,    -1,    -1,    -1,
      -1,   111,    -1,    -1,   112,    -1,   167,    -1,    74,    -1,
     167,    77,    -1,    -1,    -1,    -1,   124,    -1,   126,   180,
      -1,   182,    -1,   180,    -1,   182,   187,   137,    -1,    -1,
     187,    -1,   142,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,   111,   154,    -1,    -1,   157,
     158,    -1,    -1,   161,    -1,    -1,    -1,   167,    -1,    -1,
     168,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
     180,   137,   182,    -1,    -1,    -1,   142,   187,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,   199,   200,    -1,   202,   203,   204,   205,    -1,    -1,
      -1,   167,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,   180,    -1,   182,    -1,    -1,    -1,
      -1,   187
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int16 yystos[] =
{
       0,    14,    87,   118,   154,   166,   190,   207,   208,   209,
     210,   211,   212,   213,   214,   215,   255,   259,   260,   261,
     262,   278,   279,   281,   282,   283,   291,    82,   204,   256,
     257,   258,   351,   353,   144,   353,    37,    58,    59,   164,
     310,   214,   215,   255,    37,    41,    57,    65,   128,   130,
     268,   310,   355,   123,     0,    10,    68,   177,   216,   217,
     256,   121,   183,   154,   312,   353,   183,   315,   352,   125,
     350,   350,   353,   123,   143,   143,   276,   351,   119,   187,
      54,   269,   123,    59,   353,   208,    61,   351,   357,   179,
      15,   250,    20,    85,   185,   218,   256,   154,   242,   351,
     353,   354,   315,   351,    90,   176,   276,   351,   356,   130,
     131,   271,   272,   273,   350,    24,    48,   277,   268,    36,
      84,   106,    76,    58,   125,   349,   353,     4,    14,    94,
     100,   118,   122,   135,   152,   273,   292,   293,   192,   219,
     237,   154,   353,    73,    12,   247,   248,   139,   216,   213,
     143,   201,   121,    90,   154,   313,   314,   354,    64,   134,
     280,   187,   274,   274,   353,    87,   102,   177,   275,   269,
      78,    91,   356,   101,   353,    45,   178,    56,    56,    49,
     116,   347,   178,   347,   170,   347,   238,   243,    42,   235,
     236,    39,    40,    61,    71,   101,   112,   124,   126,   154,
     157,   158,   161,   199,   200,   202,   203,   205,   246,   316,
     317,   318,   319,   320,   321,   322,   323,   324,   325,   326,
     327,   328,   329,   330,   336,   337,   339,   340,   341,   342,
     343,   344,   345,   346,   351,   354,   357,   359,   315,   252,
     253,   316,   316,   143,   351,   242,   313,   242,   235,   121,
     187,    62,   107,   189,    55,    69,   107,   163,   280,    45,
      58,   312,   176,     9,   154,   174,   263,   264,   265,   353,
     149,   354,   295,   351,   353,   354,    29,   121,   141,   244,
     154,   351,   353,   357,   316,    60,   233,   101,   317,   317,
     168,   316,   334,   335,   167,   154,   215,   246,   154,   154,
     154,   154,   143,    57,    96,   315,     3,    13,    22,    25,
      34,    39,    61,    74,    77,   101,   111,   136,   137,   142,
     167,   180,   182,   187,   358,   359,   154,   176,   284,   312,
     121,   120,   191,   254,    92,   121,   235,   143,   250,   313,
     316,   353,   356,   183,   274,   294,   295,   274,   119,   144,
     267,   121,   266,   154,     6,    11,    21,    30,    31,    32,
      47,    53,    67,    75,    90,    95,   104,   109,   113,   132,
     145,   146,   147,   148,   155,   162,   188,   193,   194,   361,
     362,   363,   364,   365,   366,   367,   170,   108,   127,   184,
     245,   215,   238,   315,   154,    73,   196,   220,   221,   101,
     316,   334,    81,    88,   334,   246,     8,    43,    50,   114,
     172,   195,   338,   143,   143,   316,   246,   316,   316,   316,
     315,   316,   316,   121,   317,   317,   317,   317,   101,   161,
     136,   142,   317,   317,   317,   345,   317,   317,   186,    70,
     143,   331,   154,    45,   287,    52,   107,   215,   252,    86,
     251,   316,   316,   250,   187,    12,   249,    83,   312,   213,
      17,    44,   115,   165,   309,   368,   369,   370,   121,    27,
      33,    38,    72,   107,   113,   183,   264,   289,   290,   316,
     109,   155,    98,   362,    41,    49,   101,   107,   296,   297,
     298,   301,   154,   354,   160,   141,   143,   143,    93,   101,
     239,   246,   246,   222,   223,   224,   351,   105,    81,    88,
     316,   175,   192,   183,   143,   143,   143,   143,   219,   246,
     161,   317,   317,    96,   175,   154,   353,    99,   332,   246,
     215,   173,   154,   285,   286,    52,    17,    44,   249,   316,
     316,   150,   183,    14,   311,   351,   360,    26,    41,    49,
      63,   143,   121,   294,   213,   143,   121,   254,   149,   161,
     316,    26,   300,   297,   345,   315,   315,    73,    93,    45,
     240,   143,   198,   234,   121,   183,   316,   316,    81,   316,
     361,   235,    96,   317,   215,   246,   154,     7,   333,   143,
     143,   154,   288,   246,   121,    79,   213,    26,   117,   181,
     154,   154,   149,   149,   263,   369,   151,   270,   289,   154,
      63,   299,   303,   143,   240,   240,   354,   316,   151,   241,
     315,   316,   222,   154,    81,   143,   143,   233,   317,   143,
     143,    42,   154,   224,   332,   289,   153,   143,   285,   211,
     212,   255,   283,   291,   348,   311,    16,    26,    26,   316,
     289,   154,   154,   129,   171,   271,   316,   149,   110,   302,
     241,   241,   154,   240,   225,   232,   351,   220,   316,   225,
     333,   143,    87,   197,    16,    16,   143,   143,   289,   242,
     143,   353,   242,   241,   143,   133,   226,   143,   143,   236,
     313,    80,   101,   371,   143,   143,   371,   312,   143,    73,
     250,   236,    80,   302,    45,   138,   304,   305,   246,    89,
     140,   159,   227,   228,    87,   102,     5,    28,    46,   101,
     103,   307,    18,    35,   136,   229,   231,   316,    64,    90,
     115,   134,   306,   306,   103,    97,   308,    19,    79,   229,
      19,    66,   107,   161,    23,   308,    51,   169,    96,    18,
     230,   231,    66
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int16 yyr1[] =
{
       0,   206,   207,   208,   208,   209,   209,   209,   209,   209,
     209,   210,   210,   210,   210,   211,   211,   211,   211,   212,
     213,   213,   214,   214,   215,   216,   216,   217,   217,   218,
     218,   218,   218,   219,   219,   220,   220,   221,   222,   222,
     223,   224,   225,   226,   226,   227,   227,   227,   228,   228,
     228,   229,   229,   230,   230,   231,   231,   231,   232,   232,
     233,   233,   234,   234,   235,   235,   236,   237,   238,   238,
     238,   238,   239,   239,   239,   240,   240,   241,   241,   242,
     242,   243,   243,   244,   244,   244,   245,   245,   245,   245,
     245,   246,   246,   247,   247,   248,   248,   248,   249,   249,
     250,   250,   251,   251,   251,   252,   252,   253,   254,   254,
     254,   255,   255,   255,   256,   256,   257,   258,   259,   259,
     260,   261,   262,   262,   263,   263,   264,   264,   265,   265,
     265,   265,   265,   265,   265,   265,   265,   266,   266,   267,
     267,   267,   268,   268,   268,   268,   269,   269,   269,   270,
     270,   270,   271,   271,   271,   272,   272,   272,   273,   273,
     273,   273,   274,   274,   275,   275,   275,   276,   277,   277,
     278,   279,   280,   280,   280,   281,   282,   283,   284,   284,
     284,   285,   285,   286,   287,   287,   287,   288,   288,   289,
     289,   290,   291,   291,   292,   292,   292,   292,   292,   293,
     293,   293,   293,   293,   293,   293,   294,   294,   295,   296,
     296,   297,   297,   298,   299,   299,   300,   300,   301,   301,
     301,   301,   302,   303,   303,   304,   304,   305,   305,   305,
     305,   305,   306,   306,   306,   306,   306,   307,   307,   307,
     308,   308,   308,   309,   310,   310,   311,   311,   311,   311,
     312,   312,   313,   313,   314,   314,   315,   315,   316,   316,
     316,   316,   316,   316,   316,   316,   316,   317,   317,   317,
     317,   317,   317,   317,   317,   317,   317,   318,   319,   319,
     320,   321,   322,   322,   323,   323,   323,   323,   323,   323,
     323,   324,   324,   324,   324,   325,   325,   326,   326,   326,
     327,   327,   327,   327,   328,   328,   329,   330,   330,   331,
     331,   332,   332,   333,   333,   333,   334,   334,   335,   336,
     336,   336,   336,   336,   336,   337,   338,   338,   338,   338,
     338,   338,   339,   340,   341,   341,   341,   342,   343,   343,
     344,   344,   345,   346,   347,   347,   348,   348,   348,   348,
     349,   349,   350,   350,   351,   352,   353,   354,   354,   355,
     355,   355,   355,   356,   357,   358,   358,   358,   358,   358,
     358,   359,   359,   360,   361,   361,   362,   362,   363,   363,
     364,   365,   365,   365,   365,   366,   366,   366,   366,   366,
     366,   366,   366,   366,   366,   367,   367,   367,   367,   367,
     367,   367,   367,   367,   367,   367,   367,   367,   367,   368,
     368,   369,   369,   370,   370,   370,   370,   371,   371,   371
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     3,     2,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     4,
       1,     1,     3,     3,     4,     1,     3,     6,    10,     1,
       1,     1,     2,     1,     0,     1,     0,     2,     1,     3,
       5,     1,     4,     3,     0,     2,     5,     0,     1,     1,
       1,     1,     2,     1,     2,     2,     2,     2,     1,     0,
       4,     0,     2,     0,     1,     0,     2,     2,     6,     8,
       7,     7,     3,     2,     0,     2,     0,     4,     0,     1,
       3,     2,     0,     1,     1,     3,     1,     2,     1,     1,
       0,     4,     2,     1,     0,     2,     4,     4,     2,     0,
       3,     0,     2,     2,     0,     1,     3,     3,     1,     1,
       0,     2,     3,     0,     1,     3,     5,     2,     9,    10,
      11,    11,     9,    11,     1,     0,     1,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     1,     0,     1,
       1,     0,     3,     3,     3,     0,     3,     3,     0,     2,
       2,     0,     1,     1,     0,     3,     3,     3,     3,     3,
       3,     3,     1,     0,     1,     1,     1,     1,     1,     1,
       4,     6,     1,     1,     0,     4,     5,     7,     2,     3,
       3,     1,     3,     3,     5,     7,     0,     4,     0,     1,
       3,     2,     9,     8,     3,     5,     3,     3,     1,     3,
       1,     2,     2,     1,     2,     2,     1,     3,     3,     3,
       0,     1,     2,     1,     2,     0,     5,     0,     2,     2,
       1,     2,     5,     2,     0,     1,     0,     2,     2,     2,
       3,     3,     2,     2,     1,     1,     2,     2,     3,     0,
       2,     2,     0,     2,     1,     0,     3,     4,     4,     0,
       3,     0,     1,     3,     3,     5,     1,     0,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     3,     1,     1,
       1,     1,     1,     1,     1,     1,     3,     6,     4,     4,
       4,     4,     1,     1,     2,     2,     2,     3,     4,     1,
       1,     1,     3,     3,     4,     3,     3,     6,     6,     4,
       4,     3,     6,     5,     5,     6,     5,     5,     7,     1,
       0,     5,     0,     4,     2,     0,     1,     2,     4,     3,
       3,     3,     3,     3,     3,     6,     1,     1,     1,     1,
       1,     1,     4,     4,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     0,     1,     1,     1,     1,
       3,     0,     2,     0,     1,     2,     1,     1,     3,     1,
       1,     1,     0,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     0,     1,     1,     1,     1,     2,     1,     1,
       4,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     2,     2,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     2,     1,     1,     1,     1,     1,     1,
       0,     1,     3,     6,     5,     6,     7,     1,     2,     0
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (&yylloc, result, scanner, YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (N)                                                            \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (0)
#endif

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* Enable debugging if requested.  */
#if FF_DEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined FF_LTYPE_IS_TRIVIAL && FF_LTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

YY_ATTRIBUTE_UNUSED
static int
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
{
  int res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += YYFPRINTF (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += YYFPRINTF (yyo, "-%d", end_col);
    }
  return res;
 }

#  define YY_LOCATION_PRINT(File, Loc)          \
  yy_location_print_ (File, &(Loc))

# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value, Location, result, scanner); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, Program* result, yyscan_t scanner)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  YYUSE (yylocationp);
  YYUSE (result);
  YYUSE (scanner);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, Program* result, yyscan_t scanner)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  YY_LOCATION_PRINT (yyo, *yylocationp);
  YYFPRINTF (yyo, ": ");
  yy_symbol_value_print (yyo, yytype, yyvaluep, yylocationp, result, scanner);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule, Program* result, yyscan_t scanner)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                       , &(yylsp[(yyi + 1) - (yynrhs)])                       , result, scanner);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule, result, scanner); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !FF_DEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !FF_DEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp, Program* result, yyscan_t scanner)
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);
  YYUSE (result);
  YYUSE (scanner);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  switch (yytype)
    {
    case 202: /* INTLITERAL  */
#line 425 "bison.y"
           {
	 
}
#line 2249 "bison_parser.cpp"
        break;

    case 203: /* FLOATLITERAL  */
#line 425 "bison.y"
           {
	 
}
#line 2257 "bison_parser.cpp"
        break;

    case 204: /* IDENTIFIER  */
#line 421 "bison.y"
           {
	free( (((*yyvaluep).sval)) );
}
#line 2265 "bison_parser.cpp"
        break;

    case 205: /* STRINGLITERAL  */
#line 421 "bison.y"
           {
	free( (((*yyvaluep).sval)) );
}
#line 2273 "bison_parser.cpp"
        break;

    case 207: /* program  */
#line 429 "bison.y"
            { if(((*yyvaluep).program_t)!=NULL)((*yyvaluep).program_t)->deep_delete(); }
#line 2279 "bison_parser.cpp"
        break;

    case 208: /* stmtlist  */
#line 429 "bison.y"
            { if(((*yyvaluep).stmtlist_t)!=NULL)((*yyvaluep).stmtlist_t)->deep_delete(); }
#line 2285 "bison_parser.cpp"
        break;

    case 209: /* stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).stmt_t)!=NULL)((*yyvaluep).stmt_t)->deep_delete(); }
#line 2291 "bison_parser.cpp"
        break;

    case 210: /* create_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).create_stmt_t)!=NULL)((*yyvaluep).create_stmt_t)->deep_delete(); }
#line 2297 "bison_parser.cpp"
        break;

    case 211: /* drop_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).drop_stmt_t)!=NULL)((*yyvaluep).drop_stmt_t)->deep_delete(); }
#line 2303 "bison_parser.cpp"
        break;

    case 212: /* alter_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).alter_stmt_t)!=NULL)((*yyvaluep).alter_stmt_t)->deep_delete(); }
#line 2309 "bison_parser.cpp"
        break;

    case 213: /* select_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).select_stmt_t)!=NULL)((*yyvaluep).select_stmt_t)->deep_delete(); }
#line 2315 "bison_parser.cpp"
        break;

    case 214: /* select_with_parens  */
#line 429 "bison.y"
            { if(((*yyvaluep).select_with_parens_t)!=NULL)((*yyvaluep).select_with_parens_t)->deep_delete(); }
#line 2321 "bison_parser.cpp"
        break;

    case 215: /* select_no_parens  */
#line 429 "bison.y"
            { if(((*yyvaluep).select_no_parens_t)!=NULL)((*yyvaluep).select_no_parens_t)->deep_delete(); }
#line 2327 "bison_parser.cpp"
        break;

    case 216: /* select_clause_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).select_clause_list_t)!=NULL)((*yyvaluep).select_clause_list_t)->deep_delete(); }
#line 2333 "bison_parser.cpp"
        break;

    case 217: /* select_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).select_clause_t)!=NULL)((*yyvaluep).select_clause_t)->deep_delete(); }
#line 2339 "bison_parser.cpp"
        break;

    case 218: /* combine_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).combine_clause_t)!=NULL)((*yyvaluep).combine_clause_t)->deep_delete(); }
#line 2345 "bison_parser.cpp"
        break;

    case 219: /* opt_from_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_from_clause_t)!=NULL)((*yyvaluep).opt_from_clause_t)->deep_delete(); }
#line 2351 "bison_parser.cpp"
        break;

    case 220: /* opt_window_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_window_clause_t)!=NULL)((*yyvaluep).opt_window_clause_t)->deep_delete(); }
#line 2357 "bison_parser.cpp"
        break;

    case 221: /* window_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).window_clause_t)!=NULL)((*yyvaluep).window_clause_t)->deep_delete(); }
#line 2363 "bison_parser.cpp"
        break;

    case 222: /* window_def_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).window_def_list_t)!=NULL)((*yyvaluep).window_def_list_t)->deep_delete(); }
#line 2369 "bison_parser.cpp"
        break;

    case 223: /* window_def  */
#line 429 "bison.y"
            { if(((*yyvaluep).window_def_t)!=NULL)((*yyvaluep).window_def_t)->deep_delete(); }
#line 2375 "bison_parser.cpp"
        break;

    case 224: /* window_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).window_name_t)!=NULL)((*yyvaluep).window_name_t)->deep_delete(); }
#line 2381 "bison_parser.cpp"
        break;

    case 225: /* window  */
#line 429 "bison.y"
            { if(((*yyvaluep).window_t)!=NULL)((*yyvaluep).window_t)->deep_delete(); }
#line 2387 "bison_parser.cpp"
        break;

    case 226: /* opt_partition  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_partition_t)!=NULL)((*yyvaluep).opt_partition_t)->deep_delete(); }
#line 2393 "bison_parser.cpp"
        break;

    case 227: /* opt_frame_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_frame_clause_t)!=NULL)((*yyvaluep).opt_frame_clause_t)->deep_delete(); }
#line 2399 "bison_parser.cpp"
        break;

    case 228: /* range_or_rows  */
#line 429 "bison.y"
            { if(((*yyvaluep).range_or_rows_t)!=NULL)((*yyvaluep).range_or_rows_t)->deep_delete(); }
#line 2405 "bison_parser.cpp"
        break;

    case 229: /* frame_bound_start  */
#line 429 "bison.y"
            { if(((*yyvaluep).frame_bound_start_t)!=NULL)((*yyvaluep).frame_bound_start_t)->deep_delete(); }
#line 2411 "bison_parser.cpp"
        break;

    case 230: /* frame_bound_end  */
#line 429 "bison.y"
            { if(((*yyvaluep).frame_bound_end_t)!=NULL)((*yyvaluep).frame_bound_end_t)->deep_delete(); }
#line 2417 "bison_parser.cpp"
        break;

    case 231: /* frame_bound  */
#line 429 "bison.y"
            { if(((*yyvaluep).frame_bound_t)!=NULL)((*yyvaluep).frame_bound_t)->deep_delete(); }
#line 2423 "bison_parser.cpp"
        break;

    case 232: /* opt_exist_window_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_exist_window_name_t)!=NULL)((*yyvaluep).opt_exist_window_name_t)->deep_delete(); }
#line 2429 "bison_parser.cpp"
        break;

    case 233: /* opt_group_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_group_clause_t)!=NULL)((*yyvaluep).opt_group_clause_t)->deep_delete(); }
#line 2435 "bison_parser.cpp"
        break;

    case 234: /* opt_having_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_having_clause_t)!=NULL)((*yyvaluep).opt_having_clause_t)->deep_delete(); }
#line 2441 "bison_parser.cpp"
        break;

    case 235: /* opt_where_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_where_clause_t)!=NULL)((*yyvaluep).opt_where_clause_t)->deep_delete(); }
#line 2447 "bison_parser.cpp"
        break;

    case 236: /* where_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).where_clause_t)!=NULL)((*yyvaluep).where_clause_t)->deep_delete(); }
#line 2453 "bison_parser.cpp"
        break;

    case 237: /* from_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).from_clause_t)!=NULL)((*yyvaluep).from_clause_t)->deep_delete(); }
#line 2459 "bison_parser.cpp"
        break;

    case 238: /* table_ref  */
#line 429 "bison.y"
            { if(((*yyvaluep).table_ref_t)!=NULL)((*yyvaluep).table_ref_t)->deep_delete(); }
#line 2465 "bison_parser.cpp"
        break;

    case 239: /* opt_index  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_index_t)!=NULL)((*yyvaluep).opt_index_t)->deep_delete(); }
#line 2471 "bison_parser.cpp"
        break;

    case 240: /* opt_on  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_on_t)!=NULL)((*yyvaluep).opt_on_t)->deep_delete(); }
#line 2477 "bison_parser.cpp"
        break;

    case 241: /* opt_using  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_using_t)!=NULL)((*yyvaluep).opt_using_t)->deep_delete(); }
#line 2483 "bison_parser.cpp"
        break;

    case 242: /* column_name_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).column_name_list_t)!=NULL)((*yyvaluep).column_name_list_t)->deep_delete(); }
#line 2489 "bison_parser.cpp"
        break;

    case 243: /* opt_table_prefix  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_table_prefix_t)!=NULL)((*yyvaluep).opt_table_prefix_t)->deep_delete(); }
#line 2495 "bison_parser.cpp"
        break;

    case 244: /* join_op  */
#line 429 "bison.y"
            { if(((*yyvaluep).join_op_t)!=NULL)((*yyvaluep).join_op_t)->deep_delete(); }
#line 2501 "bison_parser.cpp"
        break;

    case 245: /* opt_join_type  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_join_type_t)!=NULL)((*yyvaluep).opt_join_type_t)->deep_delete(); }
#line 2507 "bison_parser.cpp"
        break;

    case 246: /* expr_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).expr_list_t)!=NULL)((*yyvaluep).expr_list_t)->deep_delete(); }
#line 2513 "bison_parser.cpp"
        break;

    case 247: /* opt_limit_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_limit_clause_t)!=NULL)((*yyvaluep).opt_limit_clause_t)->deep_delete(); }
#line 2519 "bison_parser.cpp"
        break;

    case 248: /* limit_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).limit_clause_t)!=NULL)((*yyvaluep).limit_clause_t)->deep_delete(); }
#line 2525 "bison_parser.cpp"
        break;

    case 249: /* opt_limit_row_count  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_limit_row_count_t)!=NULL)((*yyvaluep).opt_limit_row_count_t)->deep_delete(); }
#line 2531 "bison_parser.cpp"
        break;

    case 250: /* opt_order_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_order_clause_t)!=NULL)((*yyvaluep).opt_order_clause_t)->deep_delete(); }
#line 2537 "bison_parser.cpp"
        break;

    case 251: /* opt_order_nulls  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_order_nulls_t)!=NULL)((*yyvaluep).opt_order_nulls_t)->deep_delete(); }
#line 2543 "bison_parser.cpp"
        break;

    case 252: /* order_item_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).order_item_list_t)!=NULL)((*yyvaluep).order_item_list_t)->deep_delete(); }
#line 2549 "bison_parser.cpp"
        break;

    case 253: /* order_item  */
#line 429 "bison.y"
            { if(((*yyvaluep).order_item_t)!=NULL)((*yyvaluep).order_item_t)->deep_delete(); }
#line 2555 "bison_parser.cpp"
        break;

    case 254: /* opt_order_behavior  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_order_behavior_t)!=NULL)((*yyvaluep).opt_order_behavior_t)->deep_delete(); }
#line 2561 "bison_parser.cpp"
        break;

    case 255: /* opt_with_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_with_clause_t)!=NULL)((*yyvaluep).opt_with_clause_t)->deep_delete(); }
#line 2567 "bison_parser.cpp"
        break;

    case 256: /* cte_table_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).cte_table_list_t)!=NULL)((*yyvaluep).cte_table_list_t)->deep_delete(); }
#line 2573 "bison_parser.cpp"
        break;

    case 257: /* cte_table  */
#line 429 "bison.y"
            { if(((*yyvaluep).cte_table_t)!=NULL)((*yyvaluep).cte_table_t)->deep_delete(); }
#line 2579 "bison_parser.cpp"
        break;

    case 258: /* cte_table_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).cte_table_name_t)!=NULL)((*yyvaluep).cte_table_name_t)->deep_delete(); }
#line 2585 "bison_parser.cpp"
        break;

    case 259: /* create_table_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).create_table_stmt_t)!=NULL)((*yyvaluep).create_table_stmt_t)->deep_delete(); }
#line 2591 "bison_parser.cpp"
        break;

    case 260: /* create_index_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).create_index_stmt_t)!=NULL)((*yyvaluep).create_index_stmt_t)->deep_delete(); }
#line 2597 "bison_parser.cpp"
        break;

    case 261: /* create_trigger_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).create_trigger_stmt_t)!=NULL)((*yyvaluep).create_trigger_stmt_t)->deep_delete(); }
#line 2603 "bison_parser.cpp"
        break;

    case 262: /* create_view_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).create_view_stmt_t)!=NULL)((*yyvaluep).create_view_stmt_t)->deep_delete(); }
#line 2609 "bison_parser.cpp"
        break;

    case 263: /* opt_table_option_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_table_option_list_t)!=NULL)((*yyvaluep).opt_table_option_list_t)->deep_delete(); }
#line 2615 "bison_parser.cpp"
        break;

    case 264: /* table_option_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).table_option_list_t)!=NULL)((*yyvaluep).table_option_list_t)->deep_delete(); }
#line 2621 "bison_parser.cpp"
        break;

    case 265: /* table_option  */
#line 429 "bison.y"
            { if(((*yyvaluep).table_option_t)!=NULL)((*yyvaluep).table_option_t)->deep_delete(); }
#line 2627 "bison_parser.cpp"
        break;

    case 266: /* opt_op_comma  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_op_comma_t)!=NULL)((*yyvaluep).opt_op_comma_t)->deep_delete(); }
#line 2633 "bison_parser.cpp"
        break;

    case 267: /* opt_ignore_or_replace  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_ignore_or_replace_t)!=NULL)((*yyvaluep).opt_ignore_or_replace_t)->deep_delete(); }
#line 2639 "bison_parser.cpp"
        break;

    case 268: /* opt_view_algorithm  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_view_algorithm_t)!=NULL)((*yyvaluep).opt_view_algorithm_t)->deep_delete(); }
#line 2645 "bison_parser.cpp"
        break;

    case 269: /* opt_sql_security  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_sql_security_t)!=NULL)((*yyvaluep).opt_sql_security_t)->deep_delete(); }
#line 2651 "bison_parser.cpp"
        break;

    case 270: /* opt_index_option  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_index_option_t)!=NULL)((*yyvaluep).opt_index_option_t)->deep_delete(); }
#line 2657 "bison_parser.cpp"
        break;

    case 271: /* opt_extra_option  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_extra_option_t)!=NULL)((*yyvaluep).opt_extra_option_t)->deep_delete(); }
#line 2663 "bison_parser.cpp"
        break;

    case 272: /* index_algorithm_option  */
#line 429 "bison.y"
            { if(((*yyvaluep).index_algorithm_option_t)!=NULL)((*yyvaluep).index_algorithm_option_t)->deep_delete(); }
#line 2669 "bison_parser.cpp"
        break;

    case 273: /* lock_option  */
#line 429 "bison.y"
            { if(((*yyvaluep).lock_option_t)!=NULL)((*yyvaluep).lock_option_t)->deep_delete(); }
#line 2675 "bison_parser.cpp"
        break;

    case 274: /* opt_op_equal  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_op_equal_t)!=NULL)((*yyvaluep).opt_op_equal_t)->deep_delete(); }
#line 2681 "bison_parser.cpp"
        break;

    case 275: /* trigger_events  */
#line 429 "bison.y"
            { if(((*yyvaluep).trigger_events_t)!=NULL)((*yyvaluep).trigger_events_t)->deep_delete(); }
#line 2687 "bison_parser.cpp"
        break;

    case 276: /* trigger_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).trigger_name_t)!=NULL)((*yyvaluep).trigger_name_t)->deep_delete(); }
#line 2693 "bison_parser.cpp"
        break;

    case 277: /* trigger_action_time  */
#line 429 "bison.y"
            { if(((*yyvaluep).trigger_action_time_t)!=NULL)((*yyvaluep).trigger_action_time_t)->deep_delete(); }
#line 2699 "bison_parser.cpp"
        break;

    case 278: /* drop_index_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).drop_index_stmt_t)!=NULL)((*yyvaluep).drop_index_stmt_t)->deep_delete(); }
#line 2705 "bison_parser.cpp"
        break;

    case 279: /* drop_table_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).drop_table_stmt_t)!=NULL)((*yyvaluep).drop_table_stmt_t)->deep_delete(); }
#line 2711 "bison_parser.cpp"
        break;

    case 280: /* opt_restrict_or_cascade  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_restrict_or_cascade_t)!=NULL)((*yyvaluep).opt_restrict_or_cascade_t)->deep_delete(); }
#line 2717 "bison_parser.cpp"
        break;

    case 281: /* drop_trigger_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).drop_trigger_stmt_t)!=NULL)((*yyvaluep).drop_trigger_stmt_t)->deep_delete(); }
#line 2723 "bison_parser.cpp"
        break;

    case 282: /* drop_view_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).drop_view_stmt_t)!=NULL)((*yyvaluep).drop_view_stmt_t)->deep_delete(); }
#line 2729 "bison_parser.cpp"
        break;

    case 283: /* insert_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).insert_stmt_t)!=NULL)((*yyvaluep).insert_stmt_t)->deep_delete(); }
#line 2735 "bison_parser.cpp"
        break;

    case 284: /* insert_rest  */
#line 429 "bison.y"
            { if(((*yyvaluep).insert_rest_t)!=NULL)((*yyvaluep).insert_rest_t)->deep_delete(); }
#line 2741 "bison_parser.cpp"
        break;

    case 285: /* super_values_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).super_values_list_t)!=NULL)((*yyvaluep).super_values_list_t)->deep_delete(); }
#line 2747 "bison_parser.cpp"
        break;

    case 286: /* values_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).values_list_t)!=NULL)((*yyvaluep).values_list_t)->deep_delete(); }
#line 2753 "bison_parser.cpp"
        break;

    case 287: /* opt_on_conflict  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_on_conflict_t)!=NULL)((*yyvaluep).opt_on_conflict_t)->deep_delete(); }
#line 2759 "bison_parser.cpp"
        break;

    case 288: /* opt_conflict_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_conflict_expr_t)!=NULL)((*yyvaluep).opt_conflict_expr_t)->deep_delete(); }
#line 2765 "bison_parser.cpp"
        break;

    case 289: /* indexed_column_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).indexed_column_list_t)!=NULL)((*yyvaluep).indexed_column_list_t)->deep_delete(); }
#line 2771 "bison_parser.cpp"
        break;

    case 290: /* indexed_column  */
#line 429 "bison.y"
            { if(((*yyvaluep).indexed_column_t)!=NULL)((*yyvaluep).indexed_column_t)->deep_delete(); }
#line 2777 "bison_parser.cpp"
        break;

    case 291: /* update_stmt  */
#line 429 "bison.y"
            { if(((*yyvaluep).update_stmt_t)!=NULL)((*yyvaluep).update_stmt_t)->deep_delete(); }
#line 2783 "bison_parser.cpp"
        break;

    case 292: /* alter_action  */
#line 429 "bison.y"
            { if(((*yyvaluep).alter_action_t)!=NULL)((*yyvaluep).alter_action_t)->deep_delete(); }
#line 2789 "bison_parser.cpp"
        break;

    case 293: /* alter_constant_action  */
#line 429 "bison.y"
            { if(((*yyvaluep).alter_constant_action_t)!=NULL)((*yyvaluep).alter_constant_action_t)->deep_delete(); }
#line 2795 "bison_parser.cpp"
        break;

    case 294: /* column_def_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).column_def_list_t)!=NULL)((*yyvaluep).column_def_list_t)->deep_delete(); }
#line 2801 "bison_parser.cpp"
        break;

    case 295: /* column_def  */
#line 429 "bison.y"
            { if(((*yyvaluep).column_def_t)!=NULL)((*yyvaluep).column_def_t)->deep_delete(); }
#line 2807 "bison_parser.cpp"
        break;

    case 296: /* opt_column_constraint_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_column_constraint_list_t)!=NULL)((*yyvaluep).opt_column_constraint_list_t)->deep_delete(); }
#line 2813 "bison_parser.cpp"
        break;

    case 297: /* column_constraint_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).column_constraint_list_t)!=NULL)((*yyvaluep).column_constraint_list_t)->deep_delete(); }
#line 2819 "bison_parser.cpp"
        break;

    case 298: /* column_constraint  */
#line 429 "bison.y"
            { if(((*yyvaluep).column_constraint_t)!=NULL)((*yyvaluep).column_constraint_t)->deep_delete(); }
#line 2825 "bison_parser.cpp"
        break;

    case 299: /* opt_reference_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_reference_clause_t)!=NULL)((*yyvaluep).opt_reference_clause_t)->deep_delete(); }
#line 2831 "bison_parser.cpp"
        break;

    case 300: /* opt_check  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_check_t)!=NULL)((*yyvaluep).opt_check_t)->deep_delete(); }
#line 2837 "bison_parser.cpp"
        break;

    case 301: /* constraint_type  */
#line 429 "bison.y"
            { if(((*yyvaluep).constraint_type_t)!=NULL)((*yyvaluep).constraint_type_t)->deep_delete(); }
#line 2843 "bison_parser.cpp"
        break;

    case 302: /* reference_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).reference_clause_t)!=NULL)((*yyvaluep).reference_clause_t)->deep_delete(); }
#line 2849 "bison_parser.cpp"
        break;

    case 303: /* opt_foreign_key  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_foreign_key_t)!=NULL)((*yyvaluep).opt_foreign_key_t)->deep_delete(); }
#line 2855 "bison_parser.cpp"
        break;

    case 304: /* opt_foreign_key_actions  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_foreign_key_actions_t)!=NULL)((*yyvaluep).opt_foreign_key_actions_t)->deep_delete(); }
#line 2861 "bison_parser.cpp"
        break;

    case 305: /* foreign_key_actions  */
#line 429 "bison.y"
            { if(((*yyvaluep).foreign_key_actions_t)!=NULL)((*yyvaluep).foreign_key_actions_t)->deep_delete(); }
#line 2867 "bison_parser.cpp"
        break;

    case 306: /* key_actions  */
#line 429 "bison.y"
            { if(((*yyvaluep).key_actions_t)!=NULL)((*yyvaluep).key_actions_t)->deep_delete(); }
#line 2873 "bison_parser.cpp"
        break;

    case 307: /* opt_constraint_attribute_spec  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_constraint_attribute_spec_t)!=NULL)((*yyvaluep).opt_constraint_attribute_spec_t)->deep_delete(); }
#line 2879 "bison_parser.cpp"
        break;

    case 308: /* opt_initial_time  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_initial_time_t)!=NULL)((*yyvaluep).opt_initial_time_t)->deep_delete(); }
#line 2885 "bison_parser.cpp"
        break;

    case 309: /* constraint_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).constraint_name_t)!=NULL)((*yyvaluep).constraint_name_t)->deep_delete(); }
#line 2891 "bison_parser.cpp"
        break;

    case 310: /* opt_temp  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_temp_t)!=NULL)((*yyvaluep).opt_temp_t)->deep_delete(); }
#line 2897 "bison_parser.cpp"
        break;

    case 311: /* opt_check_option  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_check_option_t)!=NULL)((*yyvaluep).opt_check_option_t)->deep_delete(); }
#line 2903 "bison_parser.cpp"
        break;

    case 312: /* opt_column_name_list_p  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_column_name_list_p_t)!=NULL)((*yyvaluep).opt_column_name_list_p_t)->deep_delete(); }
#line 2909 "bison_parser.cpp"
        break;

    case 313: /* set_clause_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).set_clause_list_t)!=NULL)((*yyvaluep).set_clause_list_t)->deep_delete(); }
#line 2915 "bison_parser.cpp"
        break;

    case 314: /* set_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).set_clause_t)!=NULL)((*yyvaluep).set_clause_t)->deep_delete(); }
#line 2921 "bison_parser.cpp"
        break;

    case 315: /* opt_as_alias  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_as_alias_t)!=NULL)((*yyvaluep).opt_as_alias_t)->deep_delete(); }
#line 2927 "bison_parser.cpp"
        break;

    case 316: /* expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).expr_t)!=NULL)((*yyvaluep).expr_t)->deep_delete(); }
#line 2933 "bison_parser.cpp"
        break;

    case 317: /* operand  */
#line 429 "bison.y"
            { if(((*yyvaluep).operand_t)!=NULL)((*yyvaluep).operand_t)->deep_delete(); }
#line 2939 "bison_parser.cpp"
        break;

    case 318: /* cast_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).cast_expr_t)!=NULL)((*yyvaluep).cast_expr_t)->deep_delete(); }
#line 2945 "bison_parser.cpp"
        break;

    case 319: /* coalesce_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).coalesce_expr_t)!=NULL)((*yyvaluep).coalesce_expr_t)->deep_delete(); }
#line 2951 "bison_parser.cpp"
        break;

    case 320: /* max_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).max_expr_t)!=NULL)((*yyvaluep).max_expr_t)->deep_delete(); }
#line 2957 "bison_parser.cpp"
        break;

    case 321: /* min_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).min_expr_t)!=NULL)((*yyvaluep).min_expr_t)->deep_delete(); }
#line 2963 "bison_parser.cpp"
        break;

    case 322: /* scalar_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).scalar_expr_t)!=NULL)((*yyvaluep).scalar_expr_t)->deep_delete(); }
#line 2969 "bison_parser.cpp"
        break;

    case 323: /* unary_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).unary_expr_t)!=NULL)((*yyvaluep).unary_expr_t)->deep_delete(); }
#line 2975 "bison_parser.cpp"
        break;

    case 324: /* binary_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).binary_expr_t)!=NULL)((*yyvaluep).binary_expr_t)->deep_delete(); }
#line 2981 "bison_parser.cpp"
        break;

    case 325: /* logic_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).logic_expr_t)!=NULL)((*yyvaluep).logic_expr_t)->deep_delete(); }
#line 2987 "bison_parser.cpp"
        break;

    case 326: /* in_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).in_expr_t)!=NULL)((*yyvaluep).in_expr_t)->deep_delete(); }
#line 2993 "bison_parser.cpp"
        break;

    case 327: /* case_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).case_expr_t)!=NULL)((*yyvaluep).case_expr_t)->deep_delete(); }
#line 2999 "bison_parser.cpp"
        break;

    case 328: /* between_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).between_expr_t)!=NULL)((*yyvaluep).between_expr_t)->deep_delete(); }
#line 3005 "bison_parser.cpp"
        break;

    case 329: /* exists_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).exists_expr_t)!=NULL)((*yyvaluep).exists_expr_t)->deep_delete(); }
#line 3011 "bison_parser.cpp"
        break;

    case 330: /* function_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).function_expr_t)!=NULL)((*yyvaluep).function_expr_t)->deep_delete(); }
#line 3017 "bison_parser.cpp"
        break;

    case 331: /* opt_distinct  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_distinct_t)!=NULL)((*yyvaluep).opt_distinct_t)->deep_delete(); }
#line 3023 "bison_parser.cpp"
        break;

    case 332: /* opt_filter_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_filter_clause_t)!=NULL)((*yyvaluep).opt_filter_clause_t)->deep_delete(); }
#line 3029 "bison_parser.cpp"
        break;

    case 333: /* opt_over_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_over_clause_t)!=NULL)((*yyvaluep).opt_over_clause_t)->deep_delete(); }
#line 3035 "bison_parser.cpp"
        break;

    case 334: /* case_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).case_list_t)!=NULL)((*yyvaluep).case_list_t)->deep_delete(); }
#line 3041 "bison_parser.cpp"
        break;

    case 335: /* case_clause  */
#line 429 "bison.y"
            { if(((*yyvaluep).case_clause_t)!=NULL)((*yyvaluep).case_clause_t)->deep_delete(); }
#line 3047 "bison_parser.cpp"
        break;

    case 336: /* comp_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).comp_expr_t)!=NULL)((*yyvaluep).comp_expr_t)->deep_delete(); }
#line 3053 "bison_parser.cpp"
        break;

    case 337: /* extract_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).extract_expr_t)!=NULL)((*yyvaluep).extract_expr_t)->deep_delete(); }
#line 3059 "bison_parser.cpp"
        break;

    case 338: /* datetime_field  */
#line 429 "bison.y"
            { if(((*yyvaluep).datetime_field_t)!=NULL)((*yyvaluep).datetime_field_t)->deep_delete(); }
#line 3065 "bison_parser.cpp"
        break;

    case 339: /* array_expr  */
#line 429 "bison.y"
            { if(((*yyvaluep).array_expr_t)!=NULL)((*yyvaluep).array_expr_t)->deep_delete(); }
#line 3071 "bison_parser.cpp"
        break;

    case 340: /* array_index  */
#line 429 "bison.y"
            { if(((*yyvaluep).array_index_t)!=NULL)((*yyvaluep).array_index_t)->deep_delete(); }
#line 3077 "bison_parser.cpp"
        break;

    case 341: /* literal  */
#line 429 "bison.y"
            { if(((*yyvaluep).literal_t)!=NULL)((*yyvaluep).literal_t)->deep_delete(); }
#line 3083 "bison_parser.cpp"
        break;

    case 342: /* string_literal  */
#line 429 "bison.y"
            { if(((*yyvaluep).string_literal_t)!=NULL)((*yyvaluep).string_literal_t)->deep_delete(); }
#line 3089 "bison_parser.cpp"
        break;

    case 343: /* bool_literal  */
#line 429 "bison.y"
            { if(((*yyvaluep).bool_literal_t)!=NULL)((*yyvaluep).bool_literal_t)->deep_delete(); }
#line 3095 "bison_parser.cpp"
        break;

    case 344: /* num_literal  */
#line 429 "bison.y"
            { if(((*yyvaluep).num_literal_t)!=NULL)((*yyvaluep).num_literal_t)->deep_delete(); }
#line 3101 "bison_parser.cpp"
        break;

    case 345: /* int_literal  */
#line 429 "bison.y"
            { if(((*yyvaluep).int_literal_t)!=NULL)((*yyvaluep).int_literal_t)->deep_delete(); }
#line 3107 "bison_parser.cpp"
        break;

    case 346: /* float_literal  */
#line 429 "bison.y"
            { if(((*yyvaluep).float_literal_t)!=NULL)((*yyvaluep).float_literal_t)->deep_delete(); }
#line 3113 "bison_parser.cpp"
        break;

    case 347: /* opt_column  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_column_t)!=NULL)((*yyvaluep).opt_column_t)->deep_delete(); }
#line 3119 "bison_parser.cpp"
        break;

    case 348: /* trigger_body  */
#line 429 "bison.y"
            { if(((*yyvaluep).trigger_body_t)!=NULL)((*yyvaluep).trigger_body_t)->deep_delete(); }
#line 3125 "bison_parser.cpp"
        break;

    case 349: /* opt_if_not_exist  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_if_not_exist_t)!=NULL)((*yyvaluep).opt_if_not_exist_t)->deep_delete(); }
#line 3131 "bison_parser.cpp"
        break;

    case 350: /* opt_if_exist  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_if_exist_t)!=NULL)((*yyvaluep).opt_if_exist_t)->deep_delete(); }
#line 3137 "bison_parser.cpp"
        break;

    case 351: /* identifier  */
#line 429 "bison.y"
            { if(((*yyvaluep).identifier_t)!=NULL)((*yyvaluep).identifier_t)->deep_delete(); }
#line 3143 "bison_parser.cpp"
        break;

    case 352: /* as_alias  */
#line 429 "bison.y"
            { if(((*yyvaluep).as_alias_t)!=NULL)((*yyvaluep).as_alias_t)->deep_delete(); }
#line 3149 "bison_parser.cpp"
        break;

    case 353: /* table_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).table_name_t)!=NULL)((*yyvaluep).table_name_t)->deep_delete(); }
#line 3155 "bison_parser.cpp"
        break;

    case 354: /* column_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).column_name_t)!=NULL)((*yyvaluep).column_name_t)->deep_delete(); }
#line 3161 "bison_parser.cpp"
        break;

    case 355: /* opt_index_keyword  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_index_keyword_t)!=NULL)((*yyvaluep).opt_index_keyword_t)->deep_delete(); }
#line 3167 "bison_parser.cpp"
        break;

    case 356: /* view_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).view_name_t)!=NULL)((*yyvaluep).view_name_t)->deep_delete(); }
#line 3173 "bison_parser.cpp"
        break;

    case 357: /* function_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).function_name_t)!=NULL)((*yyvaluep).function_name_t)->deep_delete(); }
#line 3179 "bison_parser.cpp"
        break;

    case 358: /* binary_op  */
#line 429 "bison.y"
            { if(((*yyvaluep).binary_op_t)!=NULL)((*yyvaluep).binary_op_t)->deep_delete(); }
#line 3185 "bison_parser.cpp"
        break;

    case 359: /* opt_not  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_not_t)!=NULL)((*yyvaluep).opt_not_t)->deep_delete(); }
#line 3191 "bison_parser.cpp"
        break;

    case 360: /* name  */
#line 429 "bison.y"
            { if(((*yyvaluep).name_t)!=NULL)((*yyvaluep).name_t)->deep_delete(); }
#line 3197 "bison_parser.cpp"
        break;

    case 361: /* type_name  */
#line 429 "bison.y"
            { if(((*yyvaluep).type_name_t)!=NULL)((*yyvaluep).type_name_t)->deep_delete(); }
#line 3203 "bison_parser.cpp"
        break;

    case 362: /* type_name_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).type_name_list_t)!=NULL)((*yyvaluep).type_name_list_t)->deep_delete(); }
#line 3209 "bison_parser.cpp"
        break;

    case 363: /* character_type  */
#line 429 "bison.y"
            { if(((*yyvaluep).character_type_t)!=NULL)((*yyvaluep).character_type_t)->deep_delete(); }
#line 3215 "bison_parser.cpp"
        break;

    case 364: /* character_with_length  */
#line 429 "bison.y"
            { if(((*yyvaluep).character_with_length_t)!=NULL)((*yyvaluep).character_with_length_t)->deep_delete(); }
#line 3221 "bison_parser.cpp"
        break;

    case 365: /* character_without_length  */
#line 429 "bison.y"
            { if(((*yyvaluep).character_without_length_t)!=NULL)((*yyvaluep).character_without_length_t)->deep_delete(); }
#line 3227 "bison_parser.cpp"
        break;

    case 366: /* character_conflicta  */
#line 429 "bison.y"
            { if(((*yyvaluep).character_conflicta_t)!=NULL)((*yyvaluep).character_conflicta_t)->deep_delete(); }
#line 3233 "bison_parser.cpp"
        break;

    case 367: /* numeric_type  */
#line 429 "bison.y"
            { if(((*yyvaluep).numeric_type_t)!=NULL)((*yyvaluep).numeric_type_t)->deep_delete(); }
#line 3239 "bison_parser.cpp"
        break;

    case 368: /* opt_table_constraint_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_table_constraint_list_t)!=NULL)((*yyvaluep).opt_table_constraint_list_t)->deep_delete(); }
#line 3245 "bison_parser.cpp"
        break;

    case 369: /* table_constraint_list  */
#line 429 "bison.y"
            { if(((*yyvaluep).table_constraint_list_t)!=NULL)((*yyvaluep).table_constraint_list_t)->deep_delete(); }
#line 3251 "bison_parser.cpp"
        break;

    case 370: /* table_constraint  */
#line 429 "bison.y"
            { if(((*yyvaluep).table_constraint_t)!=NULL)((*yyvaluep).table_constraint_t)->deep_delete(); }
#line 3257 "bison_parser.cpp"
        break;

    case 371: /* opt_enforced  */
#line 429 "bison.y"
            { if(((*yyvaluep).opt_enforced_t)!=NULL)((*yyvaluep).opt_enforced_t)->deep_delete(); }
#line 3263 "bison_parser.cpp"
        break;

      default:
        break;
    }
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/*----------.
| yyparse.  |
`----------*/

int
yyparse (Program* result, yyscan_t scanner)
{
/* The lookahead symbol.  */
int yychar;


/* The semantic value of the lookahead symbol.  */
/* Default value used for initialization, for pacifying older GCCs
   or non-GCC compilers.  */
YY_INITIAL_VALUE (static YYSTYPE yyval_default;)
YYSTYPE yylval YY_INITIAL_VALUE (= yyval_default);

/* Location data for the lookahead symbol.  */
static YYLTYPE yyloc_default
# if defined FF_LTYPE_IS_TRIVIAL && FF_LTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;
YYLTYPE yylloc = yyloc_default;

    /* Number of syntax errors so far.  */
    int yynerrs;

    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.
       'yyls': related to locations.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[3];

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yylsp = yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

/* User initialization code.  */
#line 18 "bison.y"
{
    // Initialize
    yylloc.first_column = 0;
    yylloc.last_column = 0;
    yylloc.first_line = 0;
    yylloc.last_line = 0;
    yylloc.total_column = 0;
    yylloc.string_length = 0;
}

#line 3381 "bison_parser.cpp"

  yylsp[0] = yylloc;
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;
        YYLTYPE *yyls1 = yyls;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yyls1, yysize * YYSIZEOF (*yylsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
        yyls = yyls1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
        YYSTACK_RELOCATE (yyls_alloc, yyls);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex (&yylval, &yylloc, scanner);
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location. */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  yyerror_range[1] = yyloc;
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 433 "bison.y"
                  {
		(yyval.program_t) = result;
		(yyval.program_t)->case_idx_ = CASE0;
		(yyval.program_t)->stmtlist_ = (yyvsp[0].stmtlist_t);
				(yyval.program_t) = NULL;

	}
#line 3586 "bison_parser.cpp"
    break;

  case 3:
#line 443 "bison.y"
                               {
		(yyval.stmtlist_t) = new Stmtlist();
		(yyval.stmtlist_t)->case_idx_ = CASE0;
		(yyval.stmtlist_t)->stmt_ = (yyvsp[-2].stmt_t);
		(yyval.stmtlist_t)->stmtlist_ = (yyvsp[0].stmtlist_t);
		
	}
#line 3598 "bison_parser.cpp"
    break;

  case 4:
#line 450 "bison.y"
                      {
		(yyval.stmtlist_t) = new Stmtlist();
		(yyval.stmtlist_t)->case_idx_ = CASE1;
		(yyval.stmtlist_t)->stmt_ = (yyvsp[-1].stmt_t);
		
	}
#line 3609 "bison_parser.cpp"
    break;

  case 5:
#line 459 "bison.y"
                     {
		(yyval.stmt_t) = new Stmt();
		(yyval.stmt_t)->case_idx_ = CASE0;
		(yyval.stmt_t)->create_stmt_ = (yyvsp[0].create_stmt_t);
		
	}
#line 3620 "bison_parser.cpp"
    break;

  case 6:
#line 465 "bison.y"
                   {
		(yyval.stmt_t) = new Stmt();
		(yyval.stmt_t)->case_idx_ = CASE1;
		(yyval.stmt_t)->drop_stmt_ = (yyvsp[0].drop_stmt_t);
		
	}
#line 3631 "bison_parser.cpp"
    break;

  case 7:
#line 471 "bison.y"
                     {
		(yyval.stmt_t) = new Stmt();
		(yyval.stmt_t)->case_idx_ = CASE2;
		(yyval.stmt_t)->select_stmt_ = (yyvsp[0].select_stmt_t);
		
	}
#line 3642 "bison_parser.cpp"
    break;

  case 8:
#line 477 "bison.y"
                     {
		(yyval.stmt_t) = new Stmt();
		(yyval.stmt_t)->case_idx_ = CASE3;
		(yyval.stmt_t)->update_stmt_ = (yyvsp[0].update_stmt_t);
		
	}
#line 3653 "bison_parser.cpp"
    break;

  case 9:
#line 483 "bison.y"
                     {
		(yyval.stmt_t) = new Stmt();
		(yyval.stmt_t)->case_idx_ = CASE4;
		(yyval.stmt_t)->insert_stmt_ = (yyvsp[0].insert_stmt_t);
		
	}
#line 3664 "bison_parser.cpp"
    break;

  case 10:
#line 489 "bison.y"
                    {
		(yyval.stmt_t) = new Stmt();
		(yyval.stmt_t)->case_idx_ = CASE5;
		(yyval.stmt_t)->alter_stmt_ = (yyvsp[0].alter_stmt_t);
		
	}
#line 3675 "bison_parser.cpp"
    break;

  case 11:
#line 498 "bison.y"
                           {
		(yyval.create_stmt_t) = new CreateStmt();
		(yyval.create_stmt_t)->case_idx_ = CASE0;
		(yyval.create_stmt_t)->create_table_stmt_ = (yyvsp[0].create_table_stmt_t);
		
	}
#line 3686 "bison_parser.cpp"
    break;

  case 12:
#line 504 "bison.y"
                           {
		(yyval.create_stmt_t) = new CreateStmt();
		(yyval.create_stmt_t)->case_idx_ = CASE1;
		(yyval.create_stmt_t)->create_index_stmt_ = (yyvsp[0].create_index_stmt_t);
		
	}
#line 3697 "bison_parser.cpp"
    break;

  case 13:
#line 510 "bison.y"
                             {
		(yyval.create_stmt_t) = new CreateStmt();
		(yyval.create_stmt_t)->case_idx_ = CASE2;
		(yyval.create_stmt_t)->create_trigger_stmt_ = (yyvsp[0].create_trigger_stmt_t);
		
	}
#line 3708 "bison_parser.cpp"
    break;

  case 14:
#line 516 "bison.y"
                          {
		(yyval.create_stmt_t) = new CreateStmt();
		(yyval.create_stmt_t)->case_idx_ = CASE3;
		(yyval.create_stmt_t)->create_view_stmt_ = (yyvsp[0].create_view_stmt_t);
		
	}
#line 3719 "bison_parser.cpp"
    break;

  case 15:
#line 525 "bison.y"
                         {
		(yyval.drop_stmt_t) = new DropStmt();
		(yyval.drop_stmt_t)->case_idx_ = CASE0;
		(yyval.drop_stmt_t)->drop_index_stmt_ = (yyvsp[0].drop_index_stmt_t);
		
	}
#line 3730 "bison_parser.cpp"
    break;

  case 16:
#line 531 "bison.y"
                         {
		(yyval.drop_stmt_t) = new DropStmt();
		(yyval.drop_stmt_t)->case_idx_ = CASE1;
		(yyval.drop_stmt_t)->drop_table_stmt_ = (yyvsp[0].drop_table_stmt_t);
		
	}
#line 3741 "bison_parser.cpp"
    break;

  case 17:
#line 537 "bison.y"
                           {
		(yyval.drop_stmt_t) = new DropStmt();
		(yyval.drop_stmt_t)->case_idx_ = CASE2;
		(yyval.drop_stmt_t)->drop_trigger_stmt_ = (yyvsp[0].drop_trigger_stmt_t);
		
	}
#line 3752 "bison_parser.cpp"
    break;

  case 18:
#line 543 "bison.y"
                        {
		(yyval.drop_stmt_t) = new DropStmt();
		(yyval.drop_stmt_t)->case_idx_ = CASE3;
		(yyval.drop_stmt_t)->drop_view_stmt_ = (yyvsp[0].drop_view_stmt_t);
		
	}
#line 3763 "bison_parser.cpp"
    break;

  case 19:
#line 552 "bison.y"
                                             {
		(yyval.alter_stmt_t) = new AlterStmt();
		(yyval.alter_stmt_t)->case_idx_ = CASE0;
		(yyval.alter_stmt_t)->table_name_ = (yyvsp[-1].table_name_t);
		(yyval.alter_stmt_t)->alter_action_ = (yyvsp[0].alter_action_t);
		
	}
#line 3775 "bison_parser.cpp"
    break;

  case 20:
#line 562 "bison.y"
                                      {
		(yyval.select_stmt_t) = new SelectStmt();
		(yyval.select_stmt_t)->case_idx_ = CASE0;
		(yyval.select_stmt_t)->select_no_parens_ = (yyvsp[0].select_no_parens_t);
		
	}
#line 3786 "bison_parser.cpp"
    break;

  case 21:
#line 568 "bison.y"
                                        {
		(yyval.select_stmt_t) = new SelectStmt();
		(yyval.select_stmt_t)->case_idx_ = CASE1;
		(yyval.select_stmt_t)->select_with_parens_ = (yyvsp[0].select_with_parens_t);
		
	}
#line 3797 "bison_parser.cpp"
    break;

  case 22:
#line 577 "bison.y"
                                      {
		(yyval.select_with_parens_t) = new SelectWithParens();
		(yyval.select_with_parens_t)->case_idx_ = CASE0;
		(yyval.select_with_parens_t)->select_no_parens_ = (yyvsp[-1].select_no_parens_t);
		
	}
#line 3808 "bison_parser.cpp"
    break;

  case 23:
#line 583 "bison.y"
                                        {
		(yyval.select_with_parens_t) = new SelectWithParens();
		(yyval.select_with_parens_t)->case_idx_ = CASE1;
		(yyval.select_with_parens_t)->select_with_parens_ = (yyvsp[-1].select_with_parens_t);
		
	}
#line 3819 "bison_parser.cpp"
    break;

  case 24:
#line 592 "bison.y"
                                                                              {
		(yyval.select_no_parens_t) = new SelectNoParens();
		(yyval.select_no_parens_t)->case_idx_ = CASE0;
		(yyval.select_no_parens_t)->opt_with_clause_ = (yyvsp[-3].opt_with_clause_t);
		(yyval.select_no_parens_t)->select_clause_list_ = (yyvsp[-2].select_clause_list_t);
		(yyval.select_no_parens_t)->opt_order_clause_ = (yyvsp[-1].opt_order_clause_t);
		(yyval.select_no_parens_t)->opt_limit_clause_ = (yyvsp[0].opt_limit_clause_t);
		
	}
#line 3833 "bison_parser.cpp"
    break;

  case 25:
#line 604 "bison.y"
                       {
		(yyval.select_clause_list_t) = new SelectClauseList();
		(yyval.select_clause_list_t)->case_idx_ = CASE0;
		(yyval.select_clause_list_t)->select_clause_ = (yyvsp[0].select_clause_t);
		
	}
#line 3844 "bison_parser.cpp"
    break;

  case 26:
#line 610 "bison.y"
                                                         {
		(yyval.select_clause_list_t) = new SelectClauseList();
		(yyval.select_clause_list_t)->case_idx_ = CASE1;
		(yyval.select_clause_list_t)->select_clause_ = (yyvsp[-2].select_clause_t);
		(yyval.select_clause_list_t)->combine_clause_ = (yyvsp[-1].combine_clause_t);
		(yyval.select_clause_list_t)->select_clause_list_ = (yyvsp[0].select_clause_list_t);
		
	}
#line 3857 "bison_parser.cpp"
    break;

  case 27:
#line 621 "bison.y"
                                                                                           {
		(yyval.select_clause_t) = new SelectClause();
		(yyval.select_clause_t)->case_idx_ = CASE0;
		(yyval.select_clause_t)->opt_from_clause_ = (yyvsp[-3].opt_from_clause_t);
		(yyval.select_clause_t)->opt_where_clause_ = (yyvsp[-2].opt_where_clause_t);
		(yyval.select_clause_t)->opt_group_clause_ = (yyvsp[-1].opt_group_clause_t);
		(yyval.select_clause_t)->opt_window_clause_ = (yyvsp[0].opt_window_clause_t);
		
	}
#line 3871 "bison_parser.cpp"
    break;

  case 28:
#line 630 "bison.y"
                                                                                                                                      {
		(yyval.select_clause_t) = new SelectClause();
		(yyval.select_clause_t)->case_idx_ = CASE1;
		(yyval.select_clause_t)->function_name_ = (yyvsp[-8].function_name_t);
		(yyval.select_clause_t)->expr_list_ = (yyvsp[-6].expr_list_t);
		(yyval.select_clause_t)->opt_as_alias_ = (yyvsp[-4].opt_as_alias_t);
		(yyval.select_clause_t)->opt_from_clause_ = (yyvsp[-3].opt_from_clause_t);
		(yyval.select_clause_t)->opt_where_clause_ = (yyvsp[-2].opt_where_clause_t);
		(yyval.select_clause_t)->opt_group_clause_ = (yyvsp[-1].opt_group_clause_t);
		(yyval.select_clause_t)->opt_window_clause_ = (yyvsp[0].opt_window_clause_t);
	}
#line 3887 "bison_parser.cpp"
    break;

  case 29:
#line 644 "bison.y"
               {
		(yyval.combine_clause_t) = new CombineClause();
		(yyval.combine_clause_t)->case_idx_ = CASE0;
		
	}
#line 3897 "bison_parser.cpp"
    break;

  case 30:
#line 649 "bison.y"
                   {
		(yyval.combine_clause_t) = new CombineClause();
		(yyval.combine_clause_t)->case_idx_ = CASE1;
		
	}
#line 3907 "bison_parser.cpp"
    break;

  case 31:
#line 654 "bison.y"
                {
		(yyval.combine_clause_t) = new CombineClause();
		(yyval.combine_clause_t)->case_idx_ = CASE2;
		
	}
#line 3917 "bison_parser.cpp"
    break;

  case 32:
#line 659 "bison.y"
                                  {
		(yyval.combine_clause_t) = new CombineClause();
		(yyval.combine_clause_t)->case_idx_ = CASE3;
	}
#line 3926 "bison_parser.cpp"
    break;

  case 33:
#line 666 "bison.y"
                     {
		(yyval.opt_from_clause_t) = new OptFromClause();
		(yyval.opt_from_clause_t)->case_idx_ = CASE0;
		(yyval.opt_from_clause_t)->from_clause_ = (yyvsp[0].from_clause_t);
		
	}
#line 3937 "bison_parser.cpp"
    break;

  case 34:
#line 672 "bison.y"
          {
		(yyval.opt_from_clause_t) = new OptFromClause();
		(yyval.opt_from_clause_t)->case_idx_ = CASE1;
		
	}
#line 3947 "bison_parser.cpp"
    break;

  case 35:
#line 689 "bison.y"
                       {
		(yyval.opt_window_clause_t) = new OptWindowClause();
		(yyval.opt_window_clause_t)->case_idx_ = CASE0;
		(yyval.opt_window_clause_t)->window_clause_ = (yyvsp[0].window_clause_t);
		
	}
#line 3958 "bison_parser.cpp"
    break;

  case 36:
#line 695 "bison.y"
          {
		(yyval.opt_window_clause_t) = new OptWindowClause();
		(yyval.opt_window_clause_t)->case_idx_ = CASE1;
		
	}
#line 3968 "bison_parser.cpp"
    break;

  case 37:
#line 703 "bison.y"
                                {
		(yyval.window_clause_t) = new WindowClause();
		(yyval.window_clause_t)->case_idx_ = CASE0;
		(yyval.window_clause_t)->window_def_list_ = (yyvsp[0].window_def_list_t);
		
	}
#line 3979 "bison_parser.cpp"
    break;

  case 38:
#line 712 "bison.y"
                    {
		(yyval.window_def_list_t) = new WindowDefList();
		(yyval.window_def_list_t)->case_idx_ = CASE0;
		(yyval.window_def_list_t)->window_def_ = (yyvsp[0].window_def_t);
		
	}
#line 3990 "bison_parser.cpp"
    break;

  case 39:
#line 718 "bison.y"
                                             {
		(yyval.window_def_list_t) = new WindowDefList();
		(yyval.window_def_list_t)->case_idx_ = CASE1;
		(yyval.window_def_list_t)->window_def_ = (yyvsp[-2].window_def_t);
		(yyval.window_def_list_t)->window_def_list_ = (yyvsp[0].window_def_list_t);
		
	}
#line 4002 "bison_parser.cpp"
    break;

  case 40:
#line 728 "bison.y"
                                           {
		(yyval.window_def_t) = new WindowDef();
		(yyval.window_def_t)->case_idx_ = CASE0;
		(yyval.window_def_t)->window_name_ = (yyvsp[-4].window_name_t);
		(yyval.window_def_t)->window_ = (yyvsp[-1].window_t);
		if((yyval.window_def_t)){
			auto tmp1 = (yyval.window_def_t)->window_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataWindowName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)1; 
				}
			}
		}


	}
#line 4026 "bison_parser.cpp"
    break;

  case 41:
#line 750 "bison.y"
                    {
		(yyval.window_name_t) = new WindowName();
		(yyval.window_name_t)->case_idx_ = CASE0;
		(yyval.window_name_t)->identifier_ = (yyvsp[0].identifier_t);
		
	}
#line 4037 "bison_parser.cpp"
    break;

  case 42:
#line 759 "bison.y"
                                                                               {
		(yyval.window_t) = new Window();
		(yyval.window_t)->case_idx_ = CASE0;
		(yyval.window_t)->opt_exist_window_name_ = (yyvsp[-3].opt_exist_window_name_t);
		(yyval.window_t)->opt_partition_ = (yyvsp[-2].opt_partition_t);
		(yyval.window_t)->opt_order_clause_ = (yyvsp[-1].opt_order_clause_t);
		(yyval.window_t)->opt_frame_clause_ = (yyvsp[0].opt_frame_clause_t);
		
	}
#line 4051 "bison_parser.cpp"
    break;

  case 43:
#line 771 "bison.y"
                                {
		(yyval.opt_partition_t) = new OptPartition();
		(yyval.opt_partition_t)->case_idx_ = CASE0;
		(yyval.opt_partition_t)->expr_list_ = (yyvsp[0].expr_list_t);
		
	}
#line 4062 "bison_parser.cpp"
    break;

  case 44:
#line 777 "bison.y"
          {
		(yyval.opt_partition_t) = new OptPartition();
		(yyval.opt_partition_t)->case_idx_ = CASE1;
		
	}
#line 4072 "bison_parser.cpp"
    break;

  case 45:
#line 785 "bison.y"
                                         {
		(yyval.opt_frame_clause_t) = new OptFrameClause();
		(yyval.opt_frame_clause_t)->case_idx_ = CASE0;
		(yyval.opt_frame_clause_t)->range_or_rows_ = (yyvsp[-1].range_or_rows_t);
		(yyval.opt_frame_clause_t)->frame_bound_start_ = (yyvsp[0].frame_bound_start_t);
		
	}
#line 4084 "bison_parser.cpp"
    break;

  case 46:
#line 792 "bison.y"
                                                                     {
		(yyval.opt_frame_clause_t) = new OptFrameClause();
		(yyval.opt_frame_clause_t)->case_idx_ = CASE1;
		(yyval.opt_frame_clause_t)->range_or_rows_ = (yyvsp[-4].range_or_rows_t);
		(yyval.opt_frame_clause_t)->frame_bound_start_ = (yyvsp[-2].frame_bound_start_t);
		(yyval.opt_frame_clause_t)->frame_bound_end_ = (yyvsp[0].frame_bound_end_t);
		
	}
#line 4097 "bison_parser.cpp"
    break;

  case 47:
#line 800 "bison.y"
          {
		(yyval.opt_frame_clause_t) = new OptFrameClause();
		(yyval.opt_frame_clause_t)->case_idx_ = CASE2;
		
	}
#line 4107 "bison_parser.cpp"
    break;

  case 48:
#line 808 "bison.y"
               {
		(yyval.range_or_rows_t) = new RangeOrRows();
		(yyval.range_or_rows_t)->case_idx_ = CASE0;
		
	}
#line 4117 "bison_parser.cpp"
    break;

  case 49:
#line 813 "bison.y"
              {
		(yyval.range_or_rows_t) = new RangeOrRows();
		(yyval.range_or_rows_t)->case_idx_ = CASE1;
		
	}
#line 4127 "bison_parser.cpp"
    break;

  case 50:
#line 818 "bison.y"
                {
		(yyval.range_or_rows_t) = new RangeOrRows();
		(yyval.range_or_rows_t)->case_idx_ = CASE2;
		
	}
#line 4137 "bison_parser.cpp"
    break;

  case 51:
#line 826 "bison.y"
                     {
		(yyval.frame_bound_start_t) = new FrameBoundStart();
		(yyval.frame_bound_start_t)->case_idx_ = CASE0;
		(yyval.frame_bound_start_t)->frame_bound_ = (yyvsp[0].frame_bound_t);
		
	}
#line 4148 "bison_parser.cpp"
    break;

  case 52:
#line 832 "bison.y"
                             {
		(yyval.frame_bound_start_t) = new FrameBoundStart();
		(yyval.frame_bound_start_t)->case_idx_ = CASE1;
		
	}
#line 4158 "bison_parser.cpp"
    break;

  case 53:
#line 840 "bison.y"
                     {
		(yyval.frame_bound_end_t) = new FrameBoundEnd();
		(yyval.frame_bound_end_t)->case_idx_ = CASE0;
		(yyval.frame_bound_end_t)->frame_bound_ = (yyvsp[0].frame_bound_t);
		
	}
#line 4169 "bison_parser.cpp"
    break;

  case 54:
#line 846 "bison.y"
                             {
		(yyval.frame_bound_end_t) = new FrameBoundEnd();
		(yyval.frame_bound_end_t)->case_idx_ = CASE1;
		
	}
#line 4179 "bison_parser.cpp"
    break;

  case 55:
#line 854 "bison.y"
                        {
		(yyval.frame_bound_t) = new FrameBound();
		(yyval.frame_bound_t)->case_idx_ = CASE0;
		(yyval.frame_bound_t)->expr_ = (yyvsp[-1].expr_t);
		
	}
#line 4190 "bison_parser.cpp"
    break;

  case 56:
#line 860 "bison.y"
                        {
		(yyval.frame_bound_t) = new FrameBound();
		(yyval.frame_bound_t)->case_idx_ = CASE1;
		(yyval.frame_bound_t)->expr_ = (yyvsp[-1].expr_t);
		
	}
#line 4201 "bison_parser.cpp"
    break;

  case 57:
#line 866 "bison.y"
                     {
		(yyval.frame_bound_t) = new FrameBound();
		(yyval.frame_bound_t)->case_idx_ = CASE2;
		
	}
#line 4211 "bison_parser.cpp"
    break;

  case 58:
#line 874 "bison.y"
                    {
		(yyval.opt_exist_window_name_t) = new OptExistWindowName();
		(yyval.opt_exist_window_name_t)->case_idx_ = CASE0;
		(yyval.opt_exist_window_name_t)->identifier_ = (yyvsp[0].identifier_t);
		if((yyval.opt_exist_window_name_t)){
			auto tmp1 = (yyval.opt_exist_window_name_t)->identifier_; 
			if(tmp1){
				tmp1->data_type_ = kDataWindowName; 
				tmp1->scope_ = 1; 
				tmp1->data_flag_ =(DATAFLAG)8; 
			}
		}


	}
#line 4231 "bison_parser.cpp"
    break;

  case 59:
#line 889 "bison.y"
          {
		(yyval.opt_exist_window_name_t) = new OptExistWindowName();
		(yyval.opt_exist_window_name_t)->case_idx_ = CASE1;
		
	}
#line 4241 "bison_parser.cpp"
    break;

  case 60:
#line 897 "bison.y"
                                              {
		(yyval.opt_group_clause_t) = new OptGroupClause();
		(yyval.opt_group_clause_t)->case_idx_ = CASE0;
		(yyval.opt_group_clause_t)->expr_list_ = (yyvsp[-1].expr_list_t);
		(yyval.opt_group_clause_t)->opt_having_clause_ = (yyvsp[0].opt_having_clause_t);
		
	}
#line 4253 "bison_parser.cpp"
    break;

  case 61:
#line 904 "bison.y"
          {
		(yyval.opt_group_clause_t) = new OptGroupClause();
		(yyval.opt_group_clause_t)->case_idx_ = CASE1;
		
	}
#line 4263 "bison_parser.cpp"
    break;

  case 62:
#line 912 "bison.y"
                     {
		(yyval.opt_having_clause_t) = new OptHavingClause();
		(yyval.opt_having_clause_t)->case_idx_ = CASE0;
		(yyval.opt_having_clause_t)->expr_ = (yyvsp[0].expr_t);
		
	}
#line 4274 "bison_parser.cpp"
    break;

  case 63:
#line 918 "bison.y"
          {
		(yyval.opt_having_clause_t) = new OptHavingClause();
		(yyval.opt_having_clause_t)->case_idx_ = CASE1;
		
	}
#line 4284 "bison_parser.cpp"
    break;

  case 64:
#line 926 "bison.y"
                      {
		(yyval.opt_where_clause_t) = new OptWhereClause();
		(yyval.opt_where_clause_t)->case_idx_ = CASE0;
		(yyval.opt_where_clause_t)->where_clause_ = (yyvsp[0].where_clause_t);
		
	}
#line 4295 "bison_parser.cpp"
    break;

  case 65:
#line 932 "bison.y"
          {
		(yyval.opt_where_clause_t) = new OptWhereClause();
		(yyval.opt_where_clause_t)->case_idx_ = CASE1;
		
	}
#line 4305 "bison_parser.cpp"
    break;

  case 66:
#line 940 "bison.y"
                    {
		(yyval.where_clause_t) = new WhereClause();
		(yyval.where_clause_t)->case_idx_ = CASE0;
		(yyval.where_clause_t)->expr_ = (yyvsp[0].expr_t);
		
	}
#line 4316 "bison_parser.cpp"
    break;

  case 67:
#line 949 "bison.y"
                        {
		(yyval.from_clause_t) = new FromClause();
		(yyval.from_clause_t)->case_idx_ = CASE0;
		(yyval.from_clause_t)->table_ref_ = (yyvsp[0].table_ref_t);
		
	}
#line 4327 "bison_parser.cpp"
    break;

  case 68:
#line 958 "bison.y"
                                                                             {
		(yyval.table_ref_t) = new TableRef();
		(yyval.table_ref_t)->case_idx_ = CASE0;
		(yyval.table_ref_t)->opt_table_prefix_ = (yyvsp[-5].opt_table_prefix_t);
		(yyval.table_ref_t)->table_name_ = (yyvsp[-4].table_name_t);
		(yyval.table_ref_t)->opt_as_alias_ = (yyvsp[-3].opt_as_alias_t);
		(yyval.table_ref_t)->opt_index_ = (yyvsp[-2].opt_index_t);
		(yyval.table_ref_t)->opt_on_ = (yyvsp[-1].opt_on_t);
		(yyval.table_ref_t)->opt_using_ = (yyvsp[0].opt_using_t);
		
	}
#line 4343 "bison_parser.cpp"
    break;

  case 69:
#line 969 "bison.y"
                                                                                            {
		(yyval.table_ref_t) = new TableRef();
		(yyval.table_ref_t)->case_idx_ = CASE1;
		(yyval.table_ref_t)->opt_table_prefix_ = (yyvsp[-7].opt_table_prefix_t);
		(yyval.table_ref_t)->function_name_ = (yyvsp[-6].function_name_t);
		(yyval.table_ref_t)->expr_list_ = (yyvsp[-4].expr_list_t);
		(yyval.table_ref_t)->opt_as_alias_ = (yyvsp[-2].opt_as_alias_t);
		(yyval.table_ref_t)->opt_on_ = (yyvsp[-1].opt_on_t);
		(yyval.table_ref_t)->opt_using_ = (yyvsp[0].opt_using_t);
		
	}
#line 4359 "bison_parser.cpp"
    break;

  case 70:
#line 980 "bison.y"
                                                                                     {
		(yyval.table_ref_t) = new TableRef();
		(yyval.table_ref_t)->case_idx_ = CASE2;
		(yyval.table_ref_t)->opt_table_prefix_ = (yyvsp[-6].opt_table_prefix_t);
		(yyval.table_ref_t)->select_no_parens_ = (yyvsp[-4].select_no_parens_t);
		(yyval.table_ref_t)->opt_as_alias_ = (yyvsp[-2].opt_as_alias_t);
		(yyval.table_ref_t)->opt_on_ = (yyvsp[-1].opt_on_t);
		(yyval.table_ref_t)->opt_using_ = (yyvsp[0].opt_using_t);
		
	}
#line 4374 "bison_parser.cpp"
    break;

  case 71:
#line 990 "bison.y"
                                                                              {
		(yyval.table_ref_t) = new TableRef();
		(yyval.table_ref_t)->case_idx_ = CASE3;
		(yyval.table_ref_t)->opt_table_prefix_ = (yyvsp[-6].opt_table_prefix_t);
		(yyval.table_ref_t)->table_ref_ = (yyvsp[-4].table_ref_t);
		(yyval.table_ref_t)->opt_as_alias_ = (yyvsp[-2].opt_as_alias_t);
		(yyval.table_ref_t)->opt_on_ = (yyvsp[-1].opt_on_t);
		(yyval.table_ref_t)->opt_using_ = (yyvsp[0].opt_using_t);
		
	}
#line 4389 "bison_parser.cpp"
    break;

  case 72:
#line 1003 "bison.y"
                                {
		(yyval.opt_index_t) = new OptIndex();
		(yyval.opt_index_t)->case_idx_ = CASE0;
		(yyval.opt_index_t)->column_name_ = (yyvsp[0].column_name_t);
		
	}
#line 4400 "bison_parser.cpp"
    break;

  case 73:
#line 1009 "bison.y"
                     {
		(yyval.opt_index_t) = new OptIndex();
		(yyval.opt_index_t)->case_idx_ = CASE1;
		
	}
#line 4410 "bison_parser.cpp"
    break;

  case 74:
#line 1014 "bison.y"
          {
		(yyval.opt_index_t) = new OptIndex();
		(yyval.opt_index_t)->case_idx_ = CASE2;
		
	}
#line 4420 "bison_parser.cpp"
    break;

  case 75:
#line 1022 "bison.y"
                 {
		(yyval.opt_on_t) = new OptOn();
		(yyval.opt_on_t)->case_idx_ = CASE0;
		(yyval.opt_on_t)->expr_ = (yyvsp[0].expr_t);
		
	}
#line 4431 "bison_parser.cpp"
    break;

  case 76:
#line 1028 "bison.y"
                    {
		(yyval.opt_on_t) = new OptOn();
		(yyval.opt_on_t)->case_idx_ = CASE1;
		
	}
#line 4441 "bison_parser.cpp"
    break;

  case 77:
#line 1036 "bison.y"
                                            {
		(yyval.opt_using_t) = new OptUsing();
		(yyval.opt_using_t)->case_idx_ = CASE0;
		(yyval.opt_using_t)->column_name_list_ = (yyvsp[-1].column_name_list_t);
		
	}
#line 4452 "bison_parser.cpp"
    break;

  case 78:
#line 1042 "bison.y"
          {
		(yyval.opt_using_t) = new OptUsing();
		(yyval.opt_using_t)->case_idx_ = CASE1;
		
	}
#line 4462 "bison_parser.cpp"
    break;

  case 79:
#line 1050 "bison.y"
                     {
		(yyval.column_name_list_t) = new ColumnNameList();
		(yyval.column_name_list_t)->case_idx_ = CASE0;
		(yyval.column_name_list_t)->column_name_ = (yyvsp[0].column_name_t);
		
	}
#line 4473 "bison_parser.cpp"
    break;

  case 80:
#line 1056 "bison.y"
                                               {
		(yyval.column_name_list_t) = new ColumnNameList();
		(yyval.column_name_list_t)->case_idx_ = CASE1;
		(yyval.column_name_list_t)->column_name_ = (yyvsp[-2].column_name_t);
		(yyval.column_name_list_t)->column_name_list_ = (yyvsp[0].column_name_list_t);
		
	}
#line 4485 "bison_parser.cpp"
    break;

  case 81:
#line 1066 "bison.y"
                           {
		(yyval.opt_table_prefix_t) = new OptTablePrefix();
		(yyval.opt_table_prefix_t)->case_idx_ = CASE0;
		(yyval.opt_table_prefix_t)->table_ref_ = (yyvsp[-1].table_ref_t);
		(yyval.opt_table_prefix_t)->join_op_ = (yyvsp[0].join_op_t);
		
	}
#line 4497 "bison_parser.cpp"
    break;

  case 82:
#line 1073 "bison.y"
          {
		(yyval.opt_table_prefix_t) = new OptTablePrefix();
		(yyval.opt_table_prefix_t)->case_idx_ = CASE1;
		
	}
#line 4507 "bison_parser.cpp"
    break;

  case 83:
#line 1081 "bison.y"
                  {
		(yyval.join_op_t) = new JoinOp();
		(yyval.join_op_t)->case_idx_ = CASE0;
		
	}
#line 4517 "bison_parser.cpp"
    break;

  case 84:
#line 1086 "bison.y"
              {
		(yyval.join_op_t) = new JoinOp();
		(yyval.join_op_t)->case_idx_ = CASE1;
		
	}
#line 4527 "bison_parser.cpp"
    break;

  case 85:
#line 1091 "bison.y"
                                    {
		(yyval.join_op_t) = new JoinOp();
		(yyval.join_op_t)->case_idx_ = CASE2;
		(yyval.join_op_t)->opt_join_type_ = (yyvsp[-1].opt_join_type_t);
		
	}
#line 4538 "bison_parser.cpp"
    break;

  case 86:
#line 1100 "bison.y"
              {
		(yyval.opt_join_type_t) = new OptJoinType();
		(yyval.opt_join_type_t)->case_idx_ = CASE0;
		
	}
#line 4548 "bison_parser.cpp"
    break;

  case 87:
#line 1105 "bison.y"
                    {
		(yyval.opt_join_type_t) = new OptJoinType();
		(yyval.opt_join_type_t)->case_idx_ = CASE1;
		
	}
#line 4558 "bison_parser.cpp"
    break;

  case 88:
#line 1110 "bison.y"
               {
		(yyval.opt_join_type_t) = new OptJoinType();
		(yyval.opt_join_type_t)->case_idx_ = CASE2;
		
	}
#line 4568 "bison_parser.cpp"
    break;

  case 89:
#line 1115 "bison.y"
               {
		(yyval.opt_join_type_t) = new OptJoinType();
		(yyval.opt_join_type_t)->case_idx_ = CASE3;
		
	}
#line 4578 "bison_parser.cpp"
    break;

  case 90:
#line 1120 "bison.y"
          {
		(yyval.opt_join_type_t) = new OptJoinType();
		(yyval.opt_join_type_t)->case_idx_ = CASE4;
		
	}
#line 4588 "bison_parser.cpp"
    break;

  case 91:
#line 1128 "bison.y"
                                              {
		(yyval.expr_list_t) = new ExprList();
		(yyval.expr_list_t)->case_idx_ = CASE0;
		(yyval.expr_list_t)->expr_ = (yyvsp[-3].expr_t);
		(yyval.expr_list_t)->opt_as_alias_ = (yyvsp[-2].opt_as_alias_t);
		(yyval.expr_list_t)->expr_list_ = (yyvsp[0].expr_list_t);
		
	}
#line 4601 "bison_parser.cpp"
    break;

  case 92:
#line 1136 "bison.y"
                           {
		(yyval.expr_list_t) = new ExprList();
		(yyval.expr_list_t)->case_idx_ = CASE1;
		(yyval.expr_list_t)->expr_ = (yyvsp[-1].expr_t);
		(yyval.expr_list_t)->opt_as_alias_ = (yyvsp[0].opt_as_alias_t);
		
	}
#line 4613 "bison_parser.cpp"
    break;

  case 93:
#line 1146 "bison.y"
                      {
		(yyval.opt_limit_clause_t) = new OptLimitClause();
		(yyval.opt_limit_clause_t)->case_idx_ = CASE0;
		(yyval.opt_limit_clause_t)->limit_clause_ = (yyvsp[0].limit_clause_t);
		
	}
#line 4624 "bison_parser.cpp"
    break;

  case 94:
#line 1152 "bison.y"
          {
		(yyval.opt_limit_clause_t) = new OptLimitClause();
		(yyval.opt_limit_clause_t)->case_idx_ = CASE1;
		
	}
#line 4634 "bison_parser.cpp"
    break;

  case 95:
#line 1160 "bison.y"
                    {
		(yyval.limit_clause_t) = new LimitClause();
		(yyval.limit_clause_t)->case_idx_ = CASE0;
		(yyval.limit_clause_t)->expr_1_ = (yyvsp[0].expr_t);
		
	}
#line 4645 "bison_parser.cpp"
    break;

  case 96:
#line 1166 "bison.y"
                                {
		(yyval.limit_clause_t) = new LimitClause();
		(yyval.limit_clause_t)->case_idx_ = CASE1;
		(yyval.limit_clause_t)->expr_1_ = (yyvsp[-2].expr_t);
		(yyval.limit_clause_t)->expr_2_ = (yyvsp[0].expr_t);
		
	}
#line 4657 "bison_parser.cpp"
    break;

  case 97:
#line 1173 "bison.y"
                                  {
		(yyval.limit_clause_t) = new LimitClause();
		(yyval.limit_clause_t)->case_idx_ = CASE2;
		(yyval.limit_clause_t)->expr_1_ = (yyvsp[-2].expr_t);
		(yyval.limit_clause_t)->expr_2_ = (yyvsp[0].expr_t);
		
	}
#line 4669 "bison_parser.cpp"
    break;

  case 98:
#line 1183 "bison.y"
                    {
		(yyval.opt_limit_row_count_t) = new OptLimitRowCount();
		(yyval.opt_limit_row_count_t)->case_idx_ = CASE0;
		(yyval.opt_limit_row_count_t)->expr_ = (yyvsp[0].expr_t);
		
	}
#line 4680 "bison_parser.cpp"
    break;

  case 99:
#line 1189 "bison.y"
          {
		(yyval.opt_limit_row_count_t) = new OptLimitRowCount();
		(yyval.opt_limit_row_count_t)->case_idx_ = CASE1;
		
	}
#line 4690 "bison_parser.cpp"
    break;

  case 100:
#line 1197 "bison.y"
                                  {
		(yyval.opt_order_clause_t) = new OptOrderClause();
		(yyval.opt_order_clause_t)->case_idx_ = CASE0;
		(yyval.opt_order_clause_t)->order_item_list_ = (yyvsp[0].order_item_list_t);
		
	}
#line 4701 "bison_parser.cpp"
    break;

  case 101:
#line 1203 "bison.y"
          {
		(yyval.opt_order_clause_t) = new OptOrderClause();
		(yyval.opt_order_clause_t)->case_idx_ = CASE1;
		
	}
#line 4711 "bison_parser.cpp"
    break;

  case 102:
#line 1211 "bison.y"
                     {
		(yyval.opt_order_nulls_t) = new OptOrderNulls();
		(yyval.opt_order_nulls_t)->case_idx_ = CASE0;
		
	}
#line 4721 "bison_parser.cpp"
    break;

  case 103:
#line 1216 "bison.y"
                    {
		(yyval.opt_order_nulls_t) = new OptOrderNulls();
		(yyval.opt_order_nulls_t)->case_idx_ = CASE1;
		
	}
#line 4731 "bison_parser.cpp"
    break;

  case 104:
#line 1221 "bison.y"
          {
		(yyval.opt_order_nulls_t) = new OptOrderNulls();
		(yyval.opt_order_nulls_t)->case_idx_ = CASE2;
		
	}
#line 4741 "bison_parser.cpp"
    break;

  case 105:
#line 1229 "bison.y"
                    {
		(yyval.order_item_list_t) = new OrderItemList();
		(yyval.order_item_list_t)->case_idx_ = CASE0;
		(yyval.order_item_list_t)->order_item_ = (yyvsp[0].order_item_t);
		
	}
#line 4752 "bison_parser.cpp"
    break;

  case 106:
#line 1235 "bison.y"
                                             {
		(yyval.order_item_list_t) = new OrderItemList();
		(yyval.order_item_list_t)->case_idx_ = CASE1;
		(yyval.order_item_list_t)->order_item_ = (yyvsp[-2].order_item_t);
		(yyval.order_item_list_t)->order_item_list_ = (yyvsp[0].order_item_list_t);
		
	}
#line 4764 "bison_parser.cpp"
    break;

  case 107:
#line 1245 "bison.y"
                                                 {
		(yyval.order_item_t) = new OrderItem();
		(yyval.order_item_t)->case_idx_ = CASE0;
		(yyval.order_item_t)->expr_ = (yyvsp[-2].expr_t);
		(yyval.order_item_t)->opt_order_behavior_ = (yyvsp[-1].opt_order_behavior_t);
		(yyval.order_item_t)->opt_order_nulls_ = (yyvsp[0].opt_order_nulls_t);
		
	}
#line 4777 "bison_parser.cpp"
    break;

  case 108:
#line 1256 "bison.y"
             {
		(yyval.opt_order_behavior_t) = new OptOrderBehavior();
		(yyval.opt_order_behavior_t)->case_idx_ = CASE0;
		
	}
#line 4787 "bison_parser.cpp"
    break;

  case 109:
#line 1261 "bison.y"
              {
		(yyval.opt_order_behavior_t) = new OptOrderBehavior();
		(yyval.opt_order_behavior_t)->case_idx_ = CASE1;
		
	}
#line 4797 "bison_parser.cpp"
    break;

  case 110:
#line 1266 "bison.y"
          {
		(yyval.opt_order_behavior_t) = new OptOrderBehavior();
		(yyval.opt_order_behavior_t)->case_idx_ = CASE2;
		
	}
#line 4807 "bison_parser.cpp"
    break;

  case 111:
#line 1274 "bison.y"
                             {
		(yyval.opt_with_clause_t) = new OptWithClause();
		(yyval.opt_with_clause_t)->case_idx_ = CASE0;
		(yyval.opt_with_clause_t)->cte_table_list_ = (yyvsp[0].cte_table_list_t);
		
	}
#line 4818 "bison_parser.cpp"
    break;

  case 112:
#line 1280 "bison.y"
                                       {
		(yyval.opt_with_clause_t) = new OptWithClause();
		(yyval.opt_with_clause_t)->case_idx_ = CASE1;
		(yyval.opt_with_clause_t)->cte_table_list_ = (yyvsp[0].cte_table_list_t);
		
	}
#line 4829 "bison_parser.cpp"
    break;

  case 113:
#line 1286 "bison.y"
          {
		(yyval.opt_with_clause_t) = new OptWithClause();
		(yyval.opt_with_clause_t)->case_idx_ = CASE2;
		
	}
#line 4839 "bison_parser.cpp"
    break;

  case 114:
#line 1294 "bison.y"
                   {
		(yyval.cte_table_list_t) = new CteTableList();
		(yyval.cte_table_list_t)->case_idx_ = CASE0;
		(yyval.cte_table_list_t)->cte_table_ = (yyvsp[0].cte_table_t);
		
	}
#line 4850 "bison_parser.cpp"
    break;

  case 115:
#line 1300 "bison.y"
                                           {
		(yyval.cte_table_list_t) = new CteTableList();
		(yyval.cte_table_list_t)->case_idx_ = CASE1;
		(yyval.cte_table_list_t)->cte_table_ = (yyvsp[-2].cte_table_t);
		(yyval.cte_table_list_t)->cte_table_list_ = (yyvsp[0].cte_table_list_t);
		
	}
#line 4862 "bison_parser.cpp"
    break;

  case 116:
#line 1310 "bison.y"
                                                   {
		(yyval.cte_table_t) = new CteTable();
		(yyval.cte_table_t)->case_idx_ = CASE0;
		(yyval.cte_table_t)->cte_table_name_ = (yyvsp[-4].cte_table_name_t);
		(yyval.cte_table_t)->select_stmt_ = (yyvsp[-1].select_stmt_t);
		
	}
#line 4874 "bison_parser.cpp"
    break;

  case 117:
#line 1320 "bison.y"
                                           {
		(yyval.cte_table_name_t) = new CteTableName();
		(yyval.cte_table_name_t)->case_idx_ = CASE0;
		(yyval.cte_table_name_t)->table_name_ = (yyvsp[-1].table_name_t);
		(yyval.cte_table_name_t)->opt_column_name_list_p_ = (yyvsp[0].opt_column_name_list_p_t);
		
	}
#line 4886 "bison_parser.cpp"
    break;

  case 118:
#line 1348 "bison.y"
                                                                                                                      {
		(yyval.create_table_stmt_t) = new CreateTableStmt();
		(yyval.create_table_stmt_t)->case_idx_ = CASE0;
		(yyval.create_table_stmt_t)->opt_temp_ = (yyvsp[-7].opt_temp_t);
		(yyval.create_table_stmt_t)->opt_if_not_exist_ = (yyvsp[-5].opt_if_not_exist_t);
		(yyval.create_table_stmt_t)->table_name_ = (yyvsp[-4].table_name_t);
		(yyval.create_table_stmt_t)->opt_table_option_list_ = (yyvsp[-3].opt_table_option_list_t);
		(yyval.create_table_stmt_t)->opt_ignore_or_replace_ = (yyvsp[-2].opt_ignore_or_replace_t);
		(yyval.create_table_stmt_t)->select_stmt_ = (yyvsp[0].select_stmt_t);
		if((yyval.create_table_stmt_t)){
			auto tmp1 = (yyval.create_table_stmt_t)->table_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)128; 
				}
			}
		}


	}
#line 4914 "bison_parser.cpp"
    break;

  case 119:
#line 1371 "bison.y"
                                                                                                                                       {
		(yyval.create_table_stmt_t) = new CreateTableStmt();
		(yyval.create_table_stmt_t)->case_idx_ = CASE1;
		(yyval.create_table_stmt_t)->opt_temp_ = (yyvsp[-8].opt_temp_t);
		(yyval.create_table_stmt_t)->opt_if_not_exist_ = (yyvsp[-6].opt_if_not_exist_t);
		(yyval.create_table_stmt_t)->table_name_ = (yyvsp[-5].table_name_t);
		(yyval.create_table_stmt_t)->column_def_list_ = (yyvsp[-3].column_def_list_t);
		(yyval.create_table_stmt_t)->opt_table_constraint_list_ = (yyvsp[-2].opt_table_constraint_list_t);
		(yyval.create_table_stmt_t)->opt_table_option_list_ = (yyvsp[0].opt_table_option_list_t);
		if((yyval.create_table_stmt_t)){
			auto tmp1 = (yyval.create_table_stmt_t)->table_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)1; 
				}
			}
		}

		if((yyval.create_table_stmt_t)){
			auto tmp1 = (yyval.create_table_stmt_t)->column_def_list_; 
			while(tmp1){
				auto tmp2 = tmp1->column_def_; 
				if(tmp2){
					auto tmp3 = tmp2->identifier_; 
					if(tmp3){
						tmp3->data_type_ = kDataColumnName; 
						tmp3->scope_ = 2; 
						tmp3->data_flag_ =(DATAFLAG)1; 
					}
				}
				tmp1 = tmp1->column_def_list_;
			}
		}


	}
#line 4958 "bison_parser.cpp"
    break;

  case 120:
#line 1413 "bison.y"
                                                                                                                                   {
		(yyval.create_index_stmt_t) = new CreateIndexStmt();
		(yyval.create_index_stmt_t)->case_idx_ = CASE0;
		(yyval.create_index_stmt_t)->opt_index_keyword_ = (yyvsp[-9].opt_index_keyword_t);
		(yyval.create_index_stmt_t)->table_name_1_ = (yyvsp[-7].table_name_t);
		(yyval.create_index_stmt_t)->table_name_2_ = (yyvsp[-5].table_name_t);
		(yyval.create_index_stmt_t)->indexed_column_list_ = (yyvsp[-3].indexed_column_list_t);
		(yyval.create_index_stmt_t)->opt_index_option_ = (yyvsp[-1].opt_index_option_t);
		(yyval.create_index_stmt_t)->opt_extra_option_ = (yyvsp[0].opt_extra_option_t);
		if((yyval.create_index_stmt_t)){
			auto tmp1 = (yyval.create_index_stmt_t)->table_name_1_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 2; 
					tmp2->data_flag_ =(DATAFLAG)128; 
				}
			}
		}

		if((yyval.create_index_stmt_t)){
			auto tmp1 = (yyval.create_index_stmt_t)->table_name_2_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)8; 
				}
			}
		}


	}
#line 4998 "bison_parser.cpp"
    break;

  case 121:
#line 1451 "bison.y"
                                                                                                                {
		(yyval.create_trigger_stmt_t) = new CreateTriggerStmt();
		(yyval.create_trigger_stmt_t)->case_idx_ = CASE0;
		(yyval.create_trigger_stmt_t)->trigger_name_ = (yyvsp[-8].trigger_name_t);
		(yyval.create_trigger_stmt_t)->trigger_action_time_ = (yyvsp[-7].trigger_action_time_t);
		(yyval.create_trigger_stmt_t)->trigger_events_ = (yyvsp[-6].trigger_events_t);
		(yyval.create_trigger_stmt_t)->table_name_ = (yyvsp[-4].table_name_t);
		(yyval.create_trigger_stmt_t)->trigger_body_ = (yyvsp[0].trigger_body_t);
		if((yyval.create_trigger_stmt_t)){
			auto tmp1 = (yyval.create_trigger_stmt_t)->trigger_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTriggerName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)1; 
				}
			}
		}

		if((yyval.create_trigger_stmt_t)){
			auto tmp1 = (yyval.create_trigger_stmt_t)->table_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)8; 
				}
			}
		}


	}
#line 5037 "bison_parser.cpp"
    break;

  case 122:
#line 1488 "bison.y"
                                                                                                                          {
		(yyval.create_view_stmt_t) = new CreateViewStmt();
		(yyval.create_view_stmt_t)->case_idx_ = CASE0;
		(yyval.create_view_stmt_t)->opt_view_algorithm_ = (yyvsp[-7].opt_view_algorithm_t);
		(yyval.create_view_stmt_t)->opt_sql_security_ = (yyvsp[-6].opt_sql_security_t);
		(yyval.create_view_stmt_t)->view_name_ = (yyvsp[-4].view_name_t);
		(yyval.create_view_stmt_t)->opt_column_name_list_p_ = (yyvsp[-3].opt_column_name_list_p_t);
		(yyval.create_view_stmt_t)->select_stmt_ = (yyvsp[-1].select_stmt_t);
		(yyval.create_view_stmt_t)->opt_check_option_ = (yyvsp[0].opt_check_option_t);
		if((yyval.create_view_stmt_t)){
			auto tmp1 = (yyval.create_view_stmt_t)->view_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 10; 
					tmp2->data_flag_ =(DATAFLAG)1; 
				}
			}
		}

		if((yyval.create_view_stmt_t)){
			auto tmp1 = (yyval.create_view_stmt_t)->opt_column_name_list_p_; 
			if(tmp1){
				auto tmp2 = tmp1->column_name_list_; 
				while(tmp2){
					auto tmp3 = tmp2->column_name_; 
					if(tmp3){
						auto tmp4 = tmp3->identifier_; 
						if(tmp4){
							tmp4->data_type_ = kDataColumnName; 
							tmp4->scope_ = 11; 
							tmp4->data_flag_ =(DATAFLAG)1; 
						}
					}
					tmp2 = tmp2->column_name_list_;
				}
			}
		}


	}
#line 5084 "bison_parser.cpp"
    break;

  case 123:
#line 1530 "bison.y"
                                                                                                                                     {
		(yyval.create_view_stmt_t) = new CreateViewStmt();
		(yyval.create_view_stmt_t)->case_idx_ = CASE1;
		(yyval.create_view_stmt_t)->opt_view_algorithm_ = (yyvsp[-7].opt_view_algorithm_t);
		(yyval.create_view_stmt_t)->opt_sql_security_ = (yyvsp[-6].opt_sql_security_t);
		(yyval.create_view_stmt_t)->view_name_ = (yyvsp[-4].view_name_t);
		(yyval.create_view_stmt_t)->opt_column_name_list_p_ = (yyvsp[-3].opt_column_name_list_p_t);
		(yyval.create_view_stmt_t)->select_stmt_ = (yyvsp[-1].select_stmt_t);
		(yyval.create_view_stmt_t)->opt_check_option_ = (yyvsp[0].opt_check_option_t);
		if((yyval.create_view_stmt_t)){
			auto tmp1 = (yyval.create_view_stmt_t)->view_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 10; 
					tmp2->data_flag_ =(DATAFLAG)1; 
				}
			}
		}

		if((yyval.create_view_stmt_t)){
			auto tmp1 = (yyval.create_view_stmt_t)->opt_column_name_list_p_; 
			if(tmp1){
				auto tmp2 = tmp1->column_name_list_; 
				while(tmp2){
					auto tmp3 = tmp2->column_name_; 
					if(tmp3){
						auto tmp4 = tmp3->identifier_; 
						if(tmp4){
							tmp4->data_type_ = kDataColumnName; 
							tmp4->scope_ = 11; 
							tmp4->data_flag_ =(DATAFLAG)1; 
						}
					}
					tmp2 = tmp2->column_name_list_;
				}
			}
		}


	}
#line 5131 "bison_parser.cpp"
    break;

  case 124:
#line 1575 "bison.y"
                           {
		(yyval.opt_table_option_list_t) = new OptTableOptionList();
		(yyval.opt_table_option_list_t)->case_idx_ = CASE0;
		(yyval.opt_table_option_list_t)->table_option_list_ = (yyvsp[0].table_option_list_t);
		
	}
#line 5142 "bison_parser.cpp"
    break;

  case 125:
#line 1581 "bison.y"
          {
		(yyval.opt_table_option_list_t) = new OptTableOptionList();
		(yyval.opt_table_option_list_t)->case_idx_ = CASE1;
		
	}
#line 5152 "bison_parser.cpp"
    break;

  case 126:
#line 1589 "bison.y"
                      {
		(yyval.table_option_list_t) = new TableOptionList();
		(yyval.table_option_list_t)->case_idx_ = CASE0;
		(yyval.table_option_list_t)->table_option_ = (yyvsp[0].table_option_t);
		
	}
#line 5163 "bison_parser.cpp"
    break;

  case 127:
#line 1595 "bison.y"
                                                     {
		(yyval.table_option_list_t) = new TableOptionList();
		(yyval.table_option_list_t)->case_idx_ = CASE1;
		(yyval.table_option_list_t)->table_option_ = (yyvsp[-2].table_option_t);
		(yyval.table_option_list_t)->opt_op_comma_ = (yyvsp[-1].opt_op_comma_t);
		(yyval.table_option_list_t)->table_option_list_ = (yyvsp[0].table_option_list_t);
		
	}
#line 5176 "bison_parser.cpp"
    break;

  case 128:
#line 1606 "bison.y"
                                       {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE0;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5187 "bison_parser.cpp"
    break;

  case 129:
#line 1612 "bison.y"
                                          {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE1;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5198 "bison_parser.cpp"
    break;

  case 130:
#line 1618 "bison.y"
                                         {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE2;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5209 "bison_parser.cpp"
    break;

  case 131:
#line 1624 "bison.y"
                                         {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE3;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5220 "bison_parser.cpp"
    break;

  case 132:
#line 1630 "bison.y"
                                         {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE4;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5231 "bison_parser.cpp"
    break;

  case 133:
#line 1636 "bison.y"
                                       {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE5;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5242 "bison_parser.cpp"
    break;

  case 134:
#line 1642 "bison.y"
                                            {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE6;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5253 "bison_parser.cpp"
    break;

  case 135:
#line 1648 "bison.y"
                                           {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE7;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5264 "bison_parser.cpp"
    break;

  case 136:
#line 1654 "bison.y"
                                         {
		(yyval.table_option_t) = new TableOption();
		(yyval.table_option_t)->case_idx_ = CASE8;
		(yyval.table_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5275 "bison_parser.cpp"
    break;

  case 137:
#line 1663 "bison.y"
                  {
		(yyval.opt_op_comma_t) = new OptOpComma();
		(yyval.opt_op_comma_t)->case_idx_ = CASE0;
		
	}
#line 5285 "bison_parser.cpp"
    break;

  case 138:
#line 1668 "bison.y"
          {
		(yyval.opt_op_comma_t) = new OptOpComma();
		(yyval.opt_op_comma_t)->case_idx_ = CASE1;
		
	}
#line 5295 "bison_parser.cpp"
    break;

  case 139:
#line 1676 "bison.y"
                {
		(yyval.opt_ignore_or_replace_t) = new OptIgnoreOrReplace();
		(yyval.opt_ignore_or_replace_t)->case_idx_ = CASE0;
		
	}
#line 5305 "bison_parser.cpp"
    break;

  case 140:
#line 1681 "bison.y"
                 {
		(yyval.opt_ignore_or_replace_t) = new OptIgnoreOrReplace();
		(yyval.opt_ignore_or_replace_t)->case_idx_ = CASE1;
		
	}
#line 5315 "bison_parser.cpp"
    break;

  case 141:
#line 1686 "bison.y"
          {
		(yyval.opt_ignore_or_replace_t) = new OptIgnoreOrReplace();
		(yyval.opt_ignore_or_replace_t)->case_idx_ = CASE2;
		
	}
#line 5325 "bison_parser.cpp"
    break;

  case 142:
#line 1694 "bison.y"
                                      {
		(yyval.opt_view_algorithm_t) = new OptViewAlgorithm();
		(yyval.opt_view_algorithm_t)->case_idx_ = CASE0;
		
	}
#line 5335 "bison_parser.cpp"
    break;

  case 143:
#line 1699 "bison.y"
                                  {
		(yyval.opt_view_algorithm_t) = new OptViewAlgorithm();
		(yyval.opt_view_algorithm_t)->case_idx_ = CASE1;
		
	}
#line 5345 "bison_parser.cpp"
    break;

  case 144:
#line 1704 "bison.y"
                                      {
		(yyval.opt_view_algorithm_t) = new OptViewAlgorithm();
		(yyval.opt_view_algorithm_t)->case_idx_ = CASE2;
		
	}
#line 5355 "bison_parser.cpp"
    break;

  case 145:
#line 1709 "bison.y"
          {
		(yyval.opt_view_algorithm_t) = new OptViewAlgorithm();
		(yyval.opt_view_algorithm_t)->case_idx_ = CASE3;
		
	}
#line 5365 "bison_parser.cpp"
    break;

  case 146:
#line 1717 "bison.y"
                              {
		(yyval.opt_sql_security_t) = new OptSqlSecurity();
		(yyval.opt_sql_security_t)->case_idx_ = CASE0;
		
	}
#line 5375 "bison_parser.cpp"
    break;

  case 147:
#line 1722 "bison.y"
                              {
		(yyval.opt_sql_security_t) = new OptSqlSecurity();
		(yyval.opt_sql_security_t)->case_idx_ = CASE1;
		
	}
#line 5385 "bison_parser.cpp"
    break;

  case 148:
#line 1727 "bison.y"
          {
		(yyval.opt_sql_security_t) = new OptSqlSecurity();
		(yyval.opt_sql_security_t)->case_idx_ = CASE2;
		
	}
#line 5395 "bison_parser.cpp"
    break;

  case 149:
#line 1735 "bison.y"
                     {
		(yyval.opt_index_option_t) = new OptIndexOption();
		(yyval.opt_index_option_t)->case_idx_ = CASE0;
		
	}
#line 5405 "bison_parser.cpp"
    break;

  case 150:
#line 1740 "bison.y"
                    {
		(yyval.opt_index_option_t) = new OptIndexOption();
		(yyval.opt_index_option_t)->case_idx_ = CASE1;
		
	}
#line 5415 "bison_parser.cpp"
    break;

  case 151:
#line 1745 "bison.y"
          {
		(yyval.opt_index_option_t) = new OptIndexOption();
		(yyval.opt_index_option_t)->case_idx_ = CASE2;
		
	}
#line 5425 "bison_parser.cpp"
    break;

  case 152:
#line 1753 "bison.y"
                                {
		(yyval.opt_extra_option_t) = new OptExtraOption();
		(yyval.opt_extra_option_t)->case_idx_ = CASE0;
		(yyval.opt_extra_option_t)->index_algorithm_option_ = (yyvsp[0].index_algorithm_option_t);
		
	}
#line 5436 "bison_parser.cpp"
    break;

  case 153:
#line 1759 "bison.y"
                     {
		(yyval.opt_extra_option_t) = new OptExtraOption();
		(yyval.opt_extra_option_t)->case_idx_ = CASE1;
		(yyval.opt_extra_option_t)->lock_option_ = (yyvsp[0].lock_option_t);
		
	}
#line 5447 "bison_parser.cpp"
    break;

  case 154:
#line 1765 "bison.y"
          {
		(yyval.opt_extra_option_t) = new OptExtraOption();
		(yyval.opt_extra_option_t)->case_idx_ = CASE2;
		
	}
#line 5457 "bison_parser.cpp"
    break;

  case 155:
#line 1773 "bison.y"
                                        {
		(yyval.index_algorithm_option_t) = new IndexAlgorithmOption();
		(yyval.index_algorithm_option_t)->case_idx_ = CASE0;
		(yyval.index_algorithm_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5468 "bison_parser.cpp"
    break;

  case 156:
#line 1779 "bison.y"
                                        {
		(yyval.index_algorithm_option_t) = new IndexAlgorithmOption();
		(yyval.index_algorithm_option_t)->case_idx_ = CASE1;
		(yyval.index_algorithm_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5479 "bison_parser.cpp"
    break;

  case 157:
#line 1785 "bison.y"
                                     {
		(yyval.index_algorithm_option_t) = new IndexAlgorithmOption();
		(yyval.index_algorithm_option_t)->case_idx_ = CASE2;
		(yyval.index_algorithm_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5490 "bison_parser.cpp"
    break;

  case 158:
#line 1794 "bison.y"
                                   {
		(yyval.lock_option_t) = new LockOption();
		(yyval.lock_option_t)->case_idx_ = CASE0;
		(yyval.lock_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5501 "bison_parser.cpp"
    break;

  case 159:
#line 1800 "bison.y"
                                {
		(yyval.lock_option_t) = new LockOption();
		(yyval.lock_option_t)->case_idx_ = CASE1;
		(yyval.lock_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5512 "bison_parser.cpp"
    break;

  case 160:
#line 1806 "bison.y"
                                  {
		(yyval.lock_option_t) = new LockOption();
		(yyval.lock_option_t)->case_idx_ = CASE2;
		(yyval.lock_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5523 "bison_parser.cpp"
    break;

  case 161:
#line 1812 "bison.y"
                                     {
		(yyval.lock_option_t) = new LockOption();
		(yyval.lock_option_t)->case_idx_ = CASE3;
		(yyval.lock_option_t)->opt_op_equal_ = (yyvsp[-1].opt_op_equal_t);
		
	}
#line 5534 "bison_parser.cpp"
    break;

  case 162:
#line 1821 "bison.y"
                  {
		(yyval.opt_op_equal_t) = new OptOpEqual();
		(yyval.opt_op_equal_t)->case_idx_ = CASE0;
		
	}
#line 5544 "bison_parser.cpp"
    break;

  case 163:
#line 1826 "bison.y"
          {
		(yyval.opt_op_equal_t) = new OptOpEqual();
		(yyval.opt_op_equal_t)->case_idx_ = CASE1;
		
	}
#line 5554 "bison_parser.cpp"
    break;

  case 164:
#line 1834 "bison.y"
                {
		(yyval.trigger_events_t) = new TriggerEvents();
		(yyval.trigger_events_t)->case_idx_ = CASE0;
		
	}
#line 5564 "bison_parser.cpp"
    break;

  case 165:
#line 1839 "bison.y"
                {
		(yyval.trigger_events_t) = new TriggerEvents();
		(yyval.trigger_events_t)->case_idx_ = CASE1;
		
	}
#line 5574 "bison_parser.cpp"
    break;

  case 166:
#line 1844 "bison.y"
                {
		(yyval.trigger_events_t) = new TriggerEvents();
		(yyval.trigger_events_t)->case_idx_ = CASE2;
		
	}
#line 5584 "bison_parser.cpp"
    break;

  case 167:
#line 1852 "bison.y"
                    {
		(yyval.trigger_name_t) = new TriggerName();
		(yyval.trigger_name_t)->case_idx_ = CASE0;
		(yyval.trigger_name_t)->identifier_ = (yyvsp[0].identifier_t);
		
	}
#line 5595 "bison_parser.cpp"
    break;

  case 168:
#line 1861 "bison.y"
                {
		(yyval.trigger_action_time_t) = new TriggerActionTime();
		(yyval.trigger_action_time_t)->case_idx_ = CASE0;
		
	}
#line 5605 "bison_parser.cpp"
    break;

  case 169:
#line 1866 "bison.y"
               {
		(yyval.trigger_action_time_t) = new TriggerActionTime();
		(yyval.trigger_action_time_t)->case_idx_ = CASE1;
		
	}
#line 5615 "bison_parser.cpp"
    break;

  case 170:
#line 1874 "bison.y"
                                                {
		(yyval.drop_index_stmt_t) = new DropIndexStmt();
		(yyval.drop_index_stmt_t)->case_idx_ = CASE0;
		(yyval.drop_index_stmt_t)->table_name_ = (yyvsp[-1].table_name_t);
		(yyval.drop_index_stmt_t)->opt_extra_option_ = (yyvsp[0].opt_extra_option_t);
		if((yyval.drop_index_stmt_t)){
			auto tmp1 = (yyval.drop_index_stmt_t)->table_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)2; 
				}
			}
		}


	}
#line 5639 "bison_parser.cpp"
    break;

  case 171:
#line 1896 "bison.y"
                                                                             {
		(yyval.drop_table_stmt_t) = new DropTableStmt();
		(yyval.drop_table_stmt_t)->case_idx_ = CASE0;
		(yyval.drop_table_stmt_t)->opt_temp_ = (yyvsp[-4].opt_temp_t);
		(yyval.drop_table_stmt_t)->opt_if_exist_ = (yyvsp[-2].opt_if_exist_t);
		(yyval.drop_table_stmt_t)->table_name_ = (yyvsp[-1].table_name_t);
		(yyval.drop_table_stmt_t)->opt_restrict_or_cascade_ = (yyvsp[0].opt_restrict_or_cascade_t);
		if((yyval.drop_table_stmt_t)){
			auto tmp1 = (yyval.drop_table_stmt_t)->table_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)2; 
				}
			}
		}


	}
#line 5665 "bison_parser.cpp"
    break;

  case 172:
#line 1920 "bison.y"
                  {
		(yyval.opt_restrict_or_cascade_t) = new OptRestrictOrCascade();
		(yyval.opt_restrict_or_cascade_t)->case_idx_ = CASE0;
		
	}
#line 5675 "bison_parser.cpp"
    break;

  case 173:
#line 1925 "bison.y"
                 {
		(yyval.opt_restrict_or_cascade_t) = new OptRestrictOrCascade();
		(yyval.opt_restrict_or_cascade_t)->case_idx_ = CASE1;
		
	}
#line 5685 "bison_parser.cpp"
    break;

  case 174:
#line 1930 "bison.y"
          {
		(yyval.opt_restrict_or_cascade_t) = new OptRestrictOrCascade();
		(yyval.opt_restrict_or_cascade_t)->case_idx_ = CASE2;
		
	}
#line 5695 "bison_parser.cpp"
    break;

  case 175:
#line 1938 "bison.y"
                                                {
		(yyval.drop_trigger_stmt_t) = new DropTriggerStmt();
		(yyval.drop_trigger_stmt_t)->case_idx_ = CASE0;
		(yyval.drop_trigger_stmt_t)->opt_if_exist_ = (yyvsp[-1].opt_if_exist_t);
		(yyval.drop_trigger_stmt_t)->trigger_name_ = (yyvsp[0].trigger_name_t);
		if((yyval.drop_trigger_stmt_t)){
			auto tmp1 = (yyval.drop_trigger_stmt_t)->trigger_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTriggerName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)2; 
				}
			}
		}


	}
#line 5719 "bison_parser.cpp"
    break;

  case 176:
#line 1960 "bison.y"
                                                                  {
		(yyval.drop_view_stmt_t) = new DropViewStmt();
		(yyval.drop_view_stmt_t)->case_idx_ = CASE0;
		(yyval.drop_view_stmt_t)->opt_if_exist_ = (yyvsp[-2].opt_if_exist_t);
		(yyval.drop_view_stmt_t)->view_name_ = (yyvsp[-1].view_name_t);
		(yyval.drop_view_stmt_t)->opt_restrict_or_cascade_ = (yyvsp[0].opt_restrict_or_cascade_t);
		if((yyval.drop_view_stmt_t)){
			auto tmp1 = (yyval.drop_view_stmt_t)->view_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 1; 
					tmp2->data_flag_ =(DATAFLAG)2; 
				}
			}
		}


	}
#line 5744 "bison_parser.cpp"
    break;

  case 177:
#line 1983 "bison.y"
                                                                                         {
		(yyval.insert_stmt_t) = new InsertStmt();
		(yyval.insert_stmt_t)->case_idx_ = CASE0;
		(yyval.insert_stmt_t)->opt_with_clause_ = (yyvsp[-6].opt_with_clause_t);
		(yyval.insert_stmt_t)->table_name_ = (yyvsp[-3].table_name_t);
		(yyval.insert_stmt_t)->opt_as_alias_ = (yyvsp[-2].opt_as_alias_t);
		(yyval.insert_stmt_t)->insert_rest_ = (yyvsp[-1].insert_rest_t);
		(yyval.insert_stmt_t)->opt_on_conflict_ = (yyvsp[0].opt_on_conflict_t);
		
	}
#line 5759 "bison_parser.cpp"
    break;

  case 178:
#line 1996 "bison.y"
                                                 {
		(yyval.insert_rest_t) = new InsertRest();
		(yyval.insert_rest_t)->case_idx_ = CASE0;
		(yyval.insert_rest_t)->opt_column_name_list_p_ = (yyvsp[-1].opt_column_name_list_p_t);
		(yyval.insert_rest_t)->select_no_parens_ = (yyvsp[0].select_no_parens_t);
		
	}
#line 5771 "bison_parser.cpp"
    break;

  case 179:
#line 2003 "bison.y"
                                               {
		(yyval.insert_rest_t) = new InsertRest();
		(yyval.insert_rest_t)->case_idx_ = CASE1;
		(yyval.insert_rest_t)->opt_column_name_list_p_ = (yyvsp[-2].opt_column_name_list_p_t);
		
	}
#line 5782 "bison_parser.cpp"
    break;

  case 180:
#line 2009 "bison.y"
                                                         {
		(yyval.insert_rest_t) = new InsertRest();
		(yyval.insert_rest_t)->case_idx_ = CASE2;
		(yyval.insert_rest_t)->opt_column_name_list_p_ = (yyvsp[-2].opt_column_name_list_p_t);
		(yyval.insert_rest_t)->super_values_list_ = (yyvsp[0].super_values_list_t);
		
	}
#line 5794 "bison_parser.cpp"
    break;

  case 181:
#line 2019 "bison.y"
                     {
		(yyval.super_values_list_t) = new SuperValuesList();
		(yyval.super_values_list_t)->case_idx_ = CASE0;
		(yyval.super_values_list_t)->values_list_ = (yyvsp[0].values_list_t);
		
	}
#line 5805 "bison_parser.cpp"
    break;

  case 182:
#line 2025 "bison.y"
                                                {
		(yyval.super_values_list_t) = new SuperValuesList();
		(yyval.super_values_list_t)->case_idx_ = CASE1;
		(yyval.super_values_list_t)->values_list_ = (yyvsp[-2].values_list_t);
		(yyval.super_values_list_t)->super_values_list_ = (yyvsp[0].super_values_list_t);
		
	}
#line 5817 "bison_parser.cpp"
    break;

  case 183:
#line 2035 "bison.y"
                               {
		(yyval.values_list_t) = new ValuesList();
		(yyval.values_list_t)->case_idx_ = CASE0;
		(yyval.values_list_t)->expr_list_ = (yyvsp[-1].expr_list_t);
		
	}
#line 5828 "bison_parser.cpp"
    break;

  case 184:
#line 2044 "bison.y"
                                                  {
		(yyval.opt_on_conflict_t) = new OptOnConflict();
		(yyval.opt_on_conflict_t)->case_idx_ = CASE0;
		(yyval.opt_on_conflict_t)->opt_conflict_expr_ = (yyvsp[-2].opt_conflict_expr_t);
		
	}
#line 5839 "bison_parser.cpp"
    break;

  case 185:
#line 2050 "bison.y"
                                                                              {
		(yyval.opt_on_conflict_t) = new OptOnConflict();
		(yyval.opt_on_conflict_t)->case_idx_ = CASE1;
		(yyval.opt_on_conflict_t)->opt_conflict_expr_ = (yyvsp[-4].opt_conflict_expr_t);
		(yyval.opt_on_conflict_t)->set_clause_list_ = (yyvsp[-1].set_clause_list_t);
		(yyval.opt_on_conflict_t)->where_clause_ = (yyvsp[0].where_clause_t);
		
	}
#line 5852 "bison_parser.cpp"
    break;

  case 186:
#line 2058 "bison.y"
          {
		(yyval.opt_on_conflict_t) = new OptOnConflict();
		(yyval.opt_on_conflict_t)->case_idx_ = CASE2;
		
	}
#line 5862 "bison_parser.cpp"
    break;

  case 187:
#line 2066 "bison.y"
                                                      {
		(yyval.opt_conflict_expr_t) = new OptConflictExpr();
		(yyval.opt_conflict_expr_t)->case_idx_ = CASE0;
		(yyval.opt_conflict_expr_t)->indexed_column_list_ = (yyvsp[-2].indexed_column_list_t);
		(yyval.opt_conflict_expr_t)->where_clause_ = (yyvsp[0].where_clause_t);
		
	}
#line 5874 "bison_parser.cpp"
    break;

  case 188:
#line 2073 "bison.y"
          {
		(yyval.opt_conflict_expr_t) = new OptConflictExpr();
		(yyval.opt_conflict_expr_t)->case_idx_ = CASE1;
		
	}
#line 5884 "bison_parser.cpp"
    break;

  case 189:
#line 2081 "bison.y"
                        {
		(yyval.indexed_column_list_t) = new IndexedColumnList();
		(yyval.indexed_column_list_t)->case_idx_ = CASE0;
		(yyval.indexed_column_list_t)->indexed_column_ = (yyvsp[0].indexed_column_t);
		
	}
#line 5895 "bison_parser.cpp"
    break;

  case 190:
#line 2087 "bison.y"
                                                     {
		(yyval.indexed_column_list_t) = new IndexedColumnList();
		(yyval.indexed_column_list_t)->case_idx_ = CASE1;
		(yyval.indexed_column_list_t)->indexed_column_ = (yyvsp[-2].indexed_column_t);
		(yyval.indexed_column_list_t)->indexed_column_list_ = (yyvsp[0].indexed_column_list_t);
		
	}
#line 5907 "bison_parser.cpp"
    break;

  case 191:
#line 2097 "bison.y"
                                 {
		(yyval.indexed_column_t) = new IndexedColumn();
		(yyval.indexed_column_t)->case_idx_ = CASE0;
		(yyval.indexed_column_t)->expr_ = (yyvsp[-1].expr_t);
		(yyval.indexed_column_t)->opt_order_behavior_ = (yyvsp[0].opt_order_behavior_t);
		
	}
#line 5919 "bison_parser.cpp"
    break;

  case 192:
#line 2107 "bison.y"
                                                                                                                         {
		(yyval.update_stmt_t) = new UpdateStmt();
		(yyval.update_stmt_t)->case_idx_ = CASE0;
		(yyval.update_stmt_t)->table_name_ = (yyvsp[-6].table_name_t);
		(yyval.update_stmt_t)->opt_as_alias_ = (yyvsp[-5].opt_as_alias_t);
		(yyval.update_stmt_t)->set_clause_list_ = (yyvsp[-3].set_clause_list_t);
		(yyval.update_stmt_t)->opt_where_clause_ = (yyvsp[-2].opt_where_clause_t);
		(yyval.update_stmt_t)->opt_order_clause_ = (yyvsp[-1].opt_order_clause_t);
		(yyval.update_stmt_t)->opt_limit_row_count_ = (yyvsp[0].opt_limit_row_count_t);
		
	}
#line 5935 "bison_parser.cpp"
    break;

  case 193:
#line 2118 "bison.y"
                                                                                                                  {
		(yyval.update_stmt_t) = new UpdateStmt();
		(yyval.update_stmt_t)->case_idx_ = CASE1;
		(yyval.update_stmt_t)->table_name_ = (yyvsp[-6].table_name_t);
		(yyval.update_stmt_t)->opt_as_alias_ = (yyvsp[-5].opt_as_alias_t);
		(yyval.update_stmt_t)->set_clause_list_ = (yyvsp[-3].set_clause_list_t);
		(yyval.update_stmt_t)->opt_where_clause_ = (yyvsp[-2].opt_where_clause_t);
		(yyval.update_stmt_t)->opt_order_clause_ = (yyvsp[-1].opt_order_clause_t);
		(yyval.update_stmt_t)->opt_limit_row_count_ = (yyvsp[0].opt_limit_row_count_t);
		
	}
#line 5951 "bison_parser.cpp"
    break;

  case 194:
#line 2132 "bison.y"
                              {
		(yyval.alter_action_t) = new AlterAction();
		(yyval.alter_action_t)->case_idx_ = CASE0;
		(yyval.alter_action_t)->table_name_ = (yyvsp[0].table_name_t);
		if((yyval.alter_action_t)){
			auto tmp1 = (yyval.alter_action_t)->table_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 2; 
					tmp2->data_flag_ =(DATAFLAG)64; 
				}
			}
		}


	}
#line 5974 "bison_parser.cpp"
    break;

  case 195:
#line 2150 "bison.y"
                                                      {
		(yyval.alter_action_t) = new AlterAction();
		(yyval.alter_action_t)->case_idx_ = CASE1;
		(yyval.alter_action_t)->opt_column_ = (yyvsp[-3].opt_column_t);
		(yyval.alter_action_t)->column_name_1_ = (yyvsp[-2].column_name_t);
		(yyval.alter_action_t)->column_name_2_ = (yyvsp[0].column_name_t);
		if((yyval.alter_action_t)){
			auto tmp1 = (yyval.alter_action_t)->column_name_1_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataColumnName; 
					tmp2->scope_ = 2; 
					tmp2->data_flag_ =(DATAFLAG)8; 
				}
			}
		}

		if((yyval.alter_action_t)){
			auto tmp1 = (yyval.alter_action_t)->column_name_2_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataColumnName; 
					tmp2->scope_ = 3; 
					tmp2->data_flag_ =(DATAFLAG)64; 
				}
			}
		}


	}
#line 6011 "bison_parser.cpp"
    break;

  case 196:
#line 2182 "bison.y"
                                   {
		(yyval.alter_action_t) = new AlterAction();
		(yyval.alter_action_t)->case_idx_ = CASE2;
		(yyval.alter_action_t)->opt_column_ = (yyvsp[-1].opt_column_t);
		(yyval.alter_action_t)->column_def_ = (yyvsp[0].column_def_t);
		if((yyval.alter_action_t)){
			auto tmp1 = (yyval.alter_action_t)->column_def_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataColumnName; 
					tmp2->scope_ = 2; 
					tmp2->data_flag_ =(DATAFLAG)1; 
				}
			}
		}


	}
#line 6035 "bison_parser.cpp"
    break;

  case 197:
#line 2201 "bison.y"
                                     {
		(yyval.alter_action_t) = new AlterAction();
		(yyval.alter_action_t)->case_idx_ = CASE3;
		(yyval.alter_action_t)->opt_column_ = (yyvsp[-1].opt_column_t);
		(yyval.alter_action_t)->column_name_1_ = (yyvsp[0].column_name_t);
		if((yyval.alter_action_t)){
			auto tmp1 = (yyval.alter_action_t)->column_name_1_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataColumnName; 
					tmp2->scope_ = 2; 
					tmp2->data_flag_ =(DATAFLAG)2; 
				}
			}
		}


	}
#line 6059 "bison_parser.cpp"
    break;

  case 198:
#line 2220 "bison.y"
                               {
		(yyval.alter_action_t) = new AlterAction();
		(yyval.alter_action_t)->case_idx_ = CASE4;
		(yyval.alter_action_t)->alter_constant_action_ = (yyvsp[0].alter_constant_action_t);
		
	}
#line 6070 "bison_parser.cpp"
    break;

  case 199:
#line 2229 "bison.y"
                          {
		(yyval.alter_constant_action_t) = new AlterConstantAction();
		(yyval.alter_constant_action_t)->case_idx_ = CASE0;
		
	}
#line 6080 "bison_parser.cpp"
    break;

  case 200:
#line 2234 "bison.y"
               {
		(yyval.alter_constant_action_t) = new AlterConstantAction();
		(yyval.alter_constant_action_t)->case_idx_ = CASE1;
		
	}
#line 6090 "bison_parser.cpp"
    break;

  case 201:
#line 2239 "bison.y"
                      {
		(yyval.alter_constant_action_t) = new AlterConstantAction();
		(yyval.alter_constant_action_t)->case_idx_ = CASE2;
		
	}
#line 6100 "bison_parser.cpp"
    break;

  case 202:
#line 2244 "bison.y"
                     {
		(yyval.alter_constant_action_t) = new AlterConstantAction();
		(yyval.alter_constant_action_t)->case_idx_ = CASE3;
		
	}
#line 6110 "bison_parser.cpp"
    break;

  case 203:
#line 2249 "bison.y"
                     {
		(yyval.alter_constant_action_t) = new AlterConstantAction();
		(yyval.alter_constant_action_t)->case_idx_ = CASE4;
		(yyval.alter_constant_action_t)->lock_option_ = (yyvsp[0].lock_option_t);
		
	}
#line 6121 "bison_parser.cpp"
    break;

  case 204:
#line 2255 "bison.y"
                         {
		(yyval.alter_constant_action_t) = new AlterConstantAction();
		(yyval.alter_constant_action_t)->case_idx_ = CASE5;
		
	}
#line 6131 "bison_parser.cpp"
    break;

  case 205:
#line 2260 "bison.y"
                            {
		(yyval.alter_constant_action_t) = new AlterConstantAction();
		(yyval.alter_constant_action_t)->case_idx_ = CASE6;
		
	}
#line 6141 "bison_parser.cpp"
    break;

  case 206:
#line 2268 "bison.y"
                    {
		(yyval.column_def_list_t) = new ColumnDefList();
		(yyval.column_def_list_t)->case_idx_ = CASE0;
		(yyval.column_def_list_t)->column_def_ = (yyvsp[0].column_def_t);
		
	}
#line 6152 "bison_parser.cpp"
    break;

  case 207:
#line 2274 "bison.y"
                                             {
		(yyval.column_def_list_t) = new ColumnDefList();
		(yyval.column_def_list_t)->case_idx_ = CASE1;
		(yyval.column_def_list_t)->column_def_ = (yyvsp[-2].column_def_t);
		(yyval.column_def_list_t)->column_def_list_ = (yyvsp[0].column_def_list_t);
		
	}
#line 6164 "bison_parser.cpp"
    break;

  case 208:
#line 2284 "bison.y"
                                                              {
		(yyval.column_def_t) = new ColumnDef();
		(yyval.column_def_t)->case_idx_ = CASE0;
		(yyval.column_def_t)->identifier_ = (yyvsp[-2].identifier_t);
		(yyval.column_def_t)->type_name_list_ = (yyvsp[-1].type_name_list_t);
		(yyval.column_def_t)->opt_column_constraint_list_ = (yyvsp[0].opt_column_constraint_list_t);
		if((yyval.column_def_t)){
			auto tmp1 = (yyval.column_def_t)->identifier_; 
			if(tmp1){
				tmp1->data_type_ = kDataColumnName; 
				tmp1->scope_ = 2; 
				tmp1->data_flag_ =(DATAFLAG)1; 
			}
		}


	}
#line 6186 "bison_parser.cpp"
    break;

  case 209:
#line 2304 "bison.y"
                                                               {
		(yyval.opt_column_constraint_list_t) = new OptColumnConstraintList();
		(yyval.opt_column_constraint_list_t)->case_idx_ = CASE0;
		(yyval.opt_column_constraint_list_t)->column_constraint_list_ = (yyvsp[-2].column_constraint_list_t);
		(yyval.opt_column_constraint_list_t)->opt_check_ = (yyvsp[-1].opt_check_t);
		(yyval.opt_column_constraint_list_t)->opt_reference_clause_ = (yyvsp[0].opt_reference_clause_t);
		
	}
#line 6199 "bison_parser.cpp"
    break;

  case 210:
#line 2312 "bison.y"
          {
		(yyval.opt_column_constraint_list_t) = new OptColumnConstraintList();
		(yyval.opt_column_constraint_list_t)->case_idx_ = CASE1;
		
	}
#line 6209 "bison_parser.cpp"
    break;

  case 211:
#line 2320 "bison.y"
                           {
		(yyval.column_constraint_list_t) = new ColumnConstraintList();
		(yyval.column_constraint_list_t)->case_idx_ = CASE0;
		(yyval.column_constraint_list_t)->column_constraint_ = (yyvsp[0].column_constraint_t);
		
	}
#line 6220 "bison_parser.cpp"
    break;

  case 212:
#line 2326 "bison.y"
                                                  {
		(yyval.column_constraint_list_t) = new ColumnConstraintList();
		(yyval.column_constraint_list_t)->case_idx_ = CASE1;
		(yyval.column_constraint_list_t)->column_constraint_ = (yyvsp[-1].column_constraint_t);
		(yyval.column_constraint_list_t)->column_constraint_list_ = (yyvsp[0].column_constraint_list_t);
		
	}
#line 6232 "bison_parser.cpp"
    break;

  case 213:
#line 2336 "bison.y"
                         {
		(yyval.column_constraint_t) = new ColumnConstraint();
		(yyval.column_constraint_t)->case_idx_ = CASE0;
		(yyval.column_constraint_t)->constraint_type_ = (yyvsp[0].constraint_type_t);
		
	}
#line 6243 "bison_parser.cpp"
    break;

  case 214:
#line 2345 "bison.y"
                                          {
		(yyval.opt_reference_clause_t) = new OptReferenceClause();
		(yyval.opt_reference_clause_t)->case_idx_ = CASE0;
		(yyval.opt_reference_clause_t)->opt_foreign_key_ = (yyvsp[-1].opt_foreign_key_t);
		(yyval.opt_reference_clause_t)->reference_clause_ = (yyvsp[0].reference_clause_t);
		
	}
#line 6255 "bison_parser.cpp"
    break;

  case 215:
#line 2352 "bison.y"
          {
		(yyval.opt_reference_clause_t) = new OptReferenceClause();
		(yyval.opt_reference_clause_t)->case_idx_ = CASE1;
		
	}
#line 6265 "bison_parser.cpp"
    break;

  case 216:
#line 2360 "bison.y"
                                             {
		(yyval.opt_check_t) = new OptCheck();
		(yyval.opt_check_t)->case_idx_ = CASE0;
		(yyval.opt_check_t)->expr_ = (yyvsp[-2].expr_t);
		(yyval.opt_check_t)->opt_enforced_ = (yyvsp[0].opt_enforced_t);
		
	}
#line 6277 "bison_parser.cpp"
    break;

  case 217:
#line 2367 "bison.y"
          {
		(yyval.opt_check_t) = new OptCheck();
		(yyval.opt_check_t)->case_idx_ = CASE1;
		
	}
#line 6287 "bison_parser.cpp"
    break;

  case 218:
#line 2375 "bison.y"
                     {
		(yyval.constraint_type_t) = new ConstraintType();
		(yyval.constraint_type_t)->case_idx_ = CASE0;
		
	}
#line 6297 "bison_parser.cpp"
    break;

  case 219:
#line 2380 "bison.y"
                  {
		(yyval.constraint_type_t) = new ConstraintType();
		(yyval.constraint_type_t)->case_idx_ = CASE1;
		
	}
#line 6307 "bison_parser.cpp"
    break;

  case 220:
#line 2385 "bison.y"
                {
		(yyval.constraint_type_t) = new ConstraintType();
		(yyval.constraint_type_t)->case_idx_ = CASE2;
		
	}
#line 6317 "bison_parser.cpp"
    break;

  case 221:
#line 2391 "bison.y"
                           {
		(yyval.constraint_type_t) = new ConstraintType;
		(yyval.constraint_type_t)->case_idx_ = CASE3;
		(yyval.constraint_type_t)->expr_ = (yyvsp[0].expr_t);
	}
#line 6327 "bison_parser.cpp"
    break;

  case 222:
#line 2399 "bison.y"
                                                                                                            {
		(yyval.reference_clause_t) = new ReferenceClause();
		(yyval.reference_clause_t)->case_idx_ = CASE0;
		(yyval.reference_clause_t)->table_name_ = (yyvsp[-3].table_name_t);
		(yyval.reference_clause_t)->opt_column_name_list_p_ = (yyvsp[-2].opt_column_name_list_p_t);
		(yyval.reference_clause_t)->opt_foreign_key_actions_ = (yyvsp[-1].opt_foreign_key_actions_t);
		(yyval.reference_clause_t)->opt_constraint_attribute_spec_ = (yyvsp[0].opt_constraint_attribute_spec_t);
		if((yyval.reference_clause_t)){
			auto tmp1 = (yyval.reference_clause_t)->table_name_; 
			if(tmp1){
				auto tmp2 = tmp1->identifier_; 
				if(tmp2){
					tmp2->data_type_ = kDataTableName; 
					tmp2->scope_ = 100; 
					tmp2->data_flag_ =(DATAFLAG)8; 
				}
			}
		}

		if((yyval.reference_clause_t)){
			auto tmp1 = (yyval.reference_clause_t)->opt_column_name_list_p_; 
			if(tmp1){
				auto tmp2 = tmp1->column_name_list_; 
				while(tmp2){
					auto tmp3 = tmp2->column_name_; 
					if(tmp3){
						auto tmp4 = tmp3->identifier_; 
						if(tmp4){
							tmp4->data_type_ = kDataColumnName; 
							tmp4->scope_ = 101; 
							tmp4->data_flag_ =(DATAFLAG)8; 
						}
					}
					tmp2 = tmp2->column_name_list_;
				}
			}
		}


	}
#line 6372 "bison_parser.cpp"
    break;

  case 223:
#line 2442 "bison.y"
                     {
		(yyval.opt_foreign_key_t) = new OptForeignKey();
		(yyval.opt_foreign_key_t)->case_idx_ = CASE0;
		
	}
#line 6382 "bison_parser.cpp"
    break;

  case 224:
#line 2447 "bison.y"
          {
		(yyval.opt_foreign_key_t) = new OptForeignKey();
		(yyval.opt_foreign_key_t)->case_idx_ = CASE1;
		
	}
#line 6392 "bison_parser.cpp"
    break;

  case 225:
#line 2455 "bison.y"
                             {
		(yyval.opt_foreign_key_actions_t) = new OptForeignKeyActions();
		(yyval.opt_foreign_key_actions_t)->case_idx_ = CASE0;
		(yyval.opt_foreign_key_actions_t)->foreign_key_actions_ = (yyvsp[0].foreign_key_actions_t);
		
	}
#line 6403 "bison_parser.cpp"
    break;

  case 226:
#line 2461 "bison.y"
          {
		(yyval.opt_foreign_key_actions_t) = new OptForeignKeyActions();
		(yyval.opt_foreign_key_actions_t)->case_idx_ = CASE1;
		
	}
#line 6413 "bison_parser.cpp"
    break;

  case 227:
#line 2469 "bison.y"
                    {
		(yyval.foreign_key_actions_t) = new ForeignKeyActions();
		(yyval.foreign_key_actions_t)->case_idx_ = CASE0;
		
	}
#line 6423 "bison_parser.cpp"
    break;

  case 228:
#line 2474 "bison.y"
                       {
		(yyval.foreign_key_actions_t) = new ForeignKeyActions();
		(yyval.foreign_key_actions_t)->case_idx_ = CASE1;
		
	}
#line 6433 "bison_parser.cpp"
    break;

  case 229:
#line 2479 "bison.y"
                      {
		(yyval.foreign_key_actions_t) = new ForeignKeyActions();
		(yyval.foreign_key_actions_t)->case_idx_ = CASE2;
		
	}
#line 6443 "bison_parser.cpp"
    break;

  case 230:
#line 2484 "bison.y"
                               {
		(yyval.foreign_key_actions_t) = new ForeignKeyActions();
		(yyval.foreign_key_actions_t)->case_idx_ = CASE3;
		(yyval.foreign_key_actions_t)->key_actions_ = (yyvsp[0].key_actions_t);
		
	}
#line 6454 "bison_parser.cpp"
    break;

  case 231:
#line 2490 "bison.y"
                               {
		(yyval.foreign_key_actions_t) = new ForeignKeyActions();
		(yyval.foreign_key_actions_t)->case_idx_ = CASE4;
		(yyval.foreign_key_actions_t)->key_actions_ = (yyvsp[0].key_actions_t);
		
	}
#line 6465 "bison_parser.cpp"
    break;

  case 232:
#line 2499 "bison.y"
                  {
		(yyval.key_actions_t) = new KeyActions();
		(yyval.key_actions_t)->case_idx_ = CASE0;
		
	}
#line 6475 "bison_parser.cpp"
    break;

  case 233:
#line 2504 "bison.y"
                     {
		(yyval.key_actions_t) = new KeyActions();
		(yyval.key_actions_t)->case_idx_ = CASE1;
		
	}
#line 6485 "bison_parser.cpp"
    break;

  case 234:
#line 2509 "bison.y"
                 {
		(yyval.key_actions_t) = new KeyActions();
		(yyval.key_actions_t)->case_idx_ = CASE2;
		
	}
#line 6495 "bison_parser.cpp"
    break;

  case 235:
#line 2514 "bison.y"
                  {
		(yyval.key_actions_t) = new KeyActions();
		(yyval.key_actions_t)->case_idx_ = CASE3;
		
	}
#line 6505 "bison_parser.cpp"
    break;

  case 236:
#line 2519 "bison.y"
                   {
		(yyval.key_actions_t) = new KeyActions();
		(yyval.key_actions_t)->case_idx_ = CASE4;
		
	}
#line 6515 "bison_parser.cpp"
    break;

  case 237:
#line 2527 "bison.y"
                                      {
		(yyval.opt_constraint_attribute_spec_t) = new OptConstraintAttributeSpec();
		(yyval.opt_constraint_attribute_spec_t)->case_idx_ = CASE0;
		(yyval.opt_constraint_attribute_spec_t)->opt_initial_time_ = (yyvsp[0].opt_initial_time_t);
		
	}
#line 6526 "bison_parser.cpp"
    break;

  case 238:
#line 2533 "bison.y"
                                          {
		(yyval.opt_constraint_attribute_spec_t) = new OptConstraintAttributeSpec();
		(yyval.opt_constraint_attribute_spec_t)->case_idx_ = CASE1;
		(yyval.opt_constraint_attribute_spec_t)->opt_initial_time_ = (yyvsp[0].opt_initial_time_t);
		
	}
#line 6537 "bison_parser.cpp"
    break;

  case 239:
#line 2539 "bison.y"
          {
		(yyval.opt_constraint_attribute_spec_t) = new OptConstraintAttributeSpec();
		(yyval.opt_constraint_attribute_spec_t)->case_idx_ = CASE2;
		
	}
#line 6547 "bison_parser.cpp"
    break;

  case 240:
#line 2547 "bison.y"
                            {
		(yyval.opt_initial_time_t) = new OptInitialTime();
		(yyval.opt_initial_time_t)->case_idx_ = CASE0;
		
	}
#line 6557 "bison_parser.cpp"
    break;

  case 241:
#line 2552 "bison.y"
                             {
		(yyval.opt_initial_time_t) = new OptInitialTime();
		(yyval.opt_initial_time_t)->case_idx_ = CASE1;
		
	}
#line 6567 "bison_parser.cpp"
    break;

  case 242:
#line 2557 "bison.y"
          {
		(yyval.opt_initial_time_t) = new OptInitialTime();
		(yyval.opt_initial_time_t)->case_idx_ = CASE2;
		
	}
#line 6577 "bison_parser.cpp"
    break;

  case 243:
#line 2565 "bison.y"
                         {
		(yyval.constraint_name_t) = new ConstraintName();
		(yyval.constraint_name_t)->case_idx_ = CASE0;
		(yyval.constraint_name_t)->name_ = (yyvsp[0].name_t);
		
	}
#line 6588 "bison_parser.cpp"
    break;

  case 244:
#line 2574 "bison.y"
                   {
		(yyval.opt_temp_t) = new OptTemp();
		(yyval.opt_temp_t)->case_idx_ = CASE0;
		
	}
#line 6598 "bison_parser.cpp"
    break;

  case 245:
#line 2579 "bison.y"
          {
		(yyval.opt_temp_t) = new OptTemp();
		(yyval.opt_temp_t)->case_idx_ = CASE1;
		
	}
#line 6608 "bison_parser.cpp"
    break;

  case 246:
#line 2587 "bison.y"
                           {
		(yyval.opt_check_option_t) = new OptCheckOption();
		(yyval.opt_check_option_t)->case_idx_ = CASE0;
		
	}
#line 6618 "bison_parser.cpp"
    break;

  case 247:
#line 2592 "bison.y"
                                    {
		(yyval.opt_check_option_t) = new OptCheckOption();
		(yyval.opt_check_option_t)->case_idx_ = CASE1;
		
	}
#line 6628 "bison_parser.cpp"
    break;

  case 248:
#line 2597 "bison.y"
                                 {
		(yyval.opt_check_option_t) = new OptCheckOption();
		(yyval.opt_check_option_t)->case_idx_ = CASE2;
		
	}
#line 6638 "bison_parser.cpp"
    break;

  case 249:
#line 2602 "bison.y"
          {
		(yyval.opt_check_option_t) = new OptCheckOption();
		(yyval.opt_check_option_t)->case_idx_ = CASE3;
		
	}
#line 6648 "bison_parser.cpp"
    break;

  case 250:
#line 2610 "bison.y"
                                      {
		(yyval.opt_column_name_list_p_t) = new OptColumnNameListP();
		(yyval.opt_column_name_list_p_t)->case_idx_ = CASE0;
		(yyval.opt_column_name_list_p_t)->column_name_list_ = (yyvsp[-1].column_name_list_t);
		
	}
#line 6659 "bison_parser.cpp"
    break;

  case 251:
#line 2616 "bison.y"
          {
		(yyval.opt_column_name_list_p_t) = new OptColumnNameListP();
		(yyval.opt_column_name_list_p_t)->case_idx_ = CASE1;
		
	}
#line 6669 "bison_parser.cpp"
    break;

  case 252:
#line 2624 "bison.y"
                    {
		(yyval.set_clause_list_t) = new SetClauseList();
		(yyval.set_clause_list_t)->case_idx_ = CASE0;
		(yyval.set_clause_list_t)->set_clause_ = (yyvsp[0].set_clause_t);
		
	}
#line 6680 "bison_parser.cpp"
    break;

  case 253:
#line 2630 "bison.y"
                                             {
		(yyval.set_clause_list_t) = new SetClauseList();
		(yyval.set_clause_list_t)->case_idx_ = CASE1;
		(yyval.set_clause_list_t)->set_clause_ = (yyvsp[-2].set_clause_t);
		(yyval.set_clause_list_t)->set_clause_list_ = (yyvsp[0].set_clause_list_t);
		
	}
#line 6692 "bison_parser.cpp"
    break;

  case 254:
#line 2640 "bison.y"
                                   {
		(yyval.set_clause_t) = new SetClause();
		(yyval.set_clause_t)->case_idx_ = CASE0;
		(yyval.set_clause_t)->column_name_ = (yyvsp[-2].column_name_t);
		(yyval.set_clause_t)->expr_ = (yyvsp[0].expr_t);
		
	}
#line 6704 "bison_parser.cpp"
    break;

  case 255:
#line 2647 "bison.y"
                                                    {
		(yyval.set_clause_t) = new SetClause();
		(yyval.set_clause_t)->case_idx_ = CASE1;
		(yyval.set_clause_t)->column_name_list_ = (yyvsp[-3].column_name_list_t);
		(yyval.set_clause_t)->expr_ = (yyvsp[0].expr_t);
		
	}
#line 6716 "bison_parser.cpp"
    break;

  case 256:
#line 2657 "bison.y"
                  {
		(yyval.opt_as_alias_t) = new OptAsAlias();
		(yyval.opt_as_alias_t)->case_idx_ = CASE0;
		(yyval.opt_as_alias_t)->as_alias_ = (yyvsp[0].as_alias_t);
		
	}
#line 6727 "bison_parser.cpp"
    break;

  case 257:
#line 2663 "bison.y"
          {
		(yyval.opt_as_alias_t) = new OptAsAlias();
		(yyval.opt_as_alias_t)->case_idx_ = CASE1;
		
	}
#line 6737 "bison_parser.cpp"
    break;

  case 258:
#line 2671 "bison.y"
                 {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE0;
		(yyval.expr_t)->operand_ = (yyvsp[0].operand_t);
		
	}
#line 6748 "bison_parser.cpp"
    break;

  case 259:
#line 2677 "bison.y"
                      {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE1;
		(yyval.expr_t)->between_expr_ = (yyvsp[0].between_expr_t);
		
	}
#line 6759 "bison_parser.cpp"
    break;

  case 260:
#line 2683 "bison.y"
                     {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE2;
		(yyval.expr_t)->exists_expr_ = (yyvsp[0].exists_expr_t);
		
	}
#line 6770 "bison_parser.cpp"
    break;

  case 261:
#line 2689 "bison.y"
                 {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE3;
		(yyval.expr_t)->in_expr_ = (yyvsp[0].in_expr_t);
		
	}
#line 6781 "bison_parser.cpp"
    break;

  case 262:
#line 2695 "bison.y"
                   {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE4;
		(yyval.expr_t)->cast_expr_ = (yyvsp[0].cast_expr_t);
		
	}
#line 6792 "bison_parser.cpp"
    break;

  case 263:
#line 2701 "bison.y"
                    {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE5;
		(yyval.expr_t)->logic_expr_ = (yyvsp[0].logic_expr_t);
		
	}
#line 6803 "bison_parser.cpp"
    break;

  case 264:
#line 2707 "bison.y"
                          {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE6;
		(yyval.expr_t)->coalesce_expr_ = (yyvsp[0].coalesce_expr_t);
	}
#line 6813 "bison_parser.cpp"
    break;

  case 265:
#line 2712 "bison.y"
                     {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE7;
		(yyval.expr_t)->max_expr_ = (yyvsp[0].max_expr_t);
	}
#line 6823 "bison_parser.cpp"
    break;

  case 266:
#line 2717 "bison.y"
                     {
		(yyval.expr_t) = new Expr();
		(yyval.expr_t)->case_idx_ = CASE8;
		(yyval.expr_t)->min_expr_ = (yyvsp[0].min_expr_t);
	}
#line 6833 "bison_parser.cpp"
    break;

  case 267:
#line 2725 "bison.y"
                               {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE0;
		(yyval.operand_t)->expr_list_ = (yyvsp[-1].expr_list_t);
		
	}
#line 6844 "bison_parser.cpp"
    break;

  case 268:
#line 2731 "bison.y"
                     {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE1;
		(yyval.operand_t)->array_index_ = (yyvsp[0].array_index_t);
		
	}
#line 6855 "bison_parser.cpp"
    break;

  case 269:
#line 2737 "bison.y"
                     {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE2;
		(yyval.operand_t)->scalar_expr_ = (yyvsp[0].scalar_expr_t);
		
	}
#line 6866 "bison_parser.cpp"
    break;

  case 270:
#line 2743 "bison.y"
                    {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE3;
		(yyval.operand_t)->unary_expr_ = (yyvsp[0].unary_expr_t);
		
	}
#line 6877 "bison_parser.cpp"
    break;

  case 271:
#line 2749 "bison.y"
                     {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE4;
		(yyval.operand_t)->binary_expr_ = (yyvsp[0].binary_expr_t);
		
	}
#line 6888 "bison_parser.cpp"
    break;

  case 272:
#line 2755 "bison.y"
                   {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE5;
		(yyval.operand_t)->case_expr_ = (yyvsp[0].case_expr_t);
		
	}
#line 6899 "bison_parser.cpp"
    break;

  case 273:
#line 2761 "bison.y"
                      {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE6;
		(yyval.operand_t)->extract_expr_ = (yyvsp[0].extract_expr_t);
		
	}
#line 6910 "bison_parser.cpp"
    break;

  case 274:
#line 2767 "bison.y"
                    {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE7;
		(yyval.operand_t)->array_expr_ = (yyvsp[0].array_expr_t);
		
	}
#line 6921 "bison_parser.cpp"
    break;

  case 275:
#line 2773 "bison.y"
                       {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE8;
		(yyval.operand_t)->function_expr_ = (yyvsp[0].function_expr_t);
		
	}
#line 6932 "bison_parser.cpp"
    break;

  case 276:
#line 2779 "bison.y"
                                      {
		(yyval.operand_t) = new Operand();
		(yyval.operand_t)->case_idx_ = CASE9;
		(yyval.operand_t)->select_no_parens_ = (yyvsp[-1].select_no_parens_t);
		
	}
#line 6943 "bison_parser.cpp"
    break;

  case 277:
#line 2788 "bison.y"
                                            {
		(yyval.cast_expr_t) = new CastExpr();
		(yyval.cast_expr_t)->case_idx_ = CASE0;
		(yyval.cast_expr_t)->expr_ = (yyvsp[-3].expr_t);
		(yyval.cast_expr_t)->type_name_ = (yyvsp[-1].type_name_t);
		
	}
#line 6955 "bison_parser.cpp"
    break;

  case 278:
#line 2798 "bison.y"
                                   {
		(yyval.coalesce_expr_t) = new CoalesceExpr();
		(yyval.coalesce_expr_t)->case_idx_ = CASE0;
		(yyval.coalesce_expr_t)->expr_ = (yyvsp[-1].expr_t);
	}
#line 6965 "bison_parser.cpp"
    break;

  case 279:
#line 2803 "bison.y"
                                          {
		(yyval.coalesce_expr_t) = new CoalesceExpr();
		(yyval.coalesce_expr_t)->case_idx_ = CASE1;
		(yyval.coalesce_expr_t)->expr_list_ = (yyvsp[-1].expr_list_t);
	}
#line 6975 "bison_parser.cpp"
    break;

  case 280:
#line 2811 "bison.y"
                              {
		(yyval.max_expr_t) = new MaxExpr();
		(yyval.max_expr_t)->case_idx_ = CASE0;
		(yyval.max_expr_t)->expr_ = (yyvsp[-1].expr_t);
	}
#line 6985 "bison_parser.cpp"
    break;

  case 281:
#line 2819 "bison.y"
                              {
		(yyval.min_expr_t) = new MinExpr();
		(yyval.min_expr_t)->case_idx_ = CASE0;
		(yyval.min_expr_t)->expr_ = (yyvsp[-1].expr_t);
	}
#line 6995 "bison_parser.cpp"
    break;

  case 282:
#line 2827 "bison.y"
                     {
		(yyval.scalar_expr_t) = new ScalarExpr();
		(yyval.scalar_expr_t)->case_idx_ = CASE0;
		(yyval.scalar_expr_t)->column_name_ = (yyvsp[0].column_name_t);
		
	}
#line 7006 "bison_parser.cpp"
    break;

  case 283:
#line 2833 "bison.y"
                 {
		(yyval.scalar_expr_t) = new ScalarExpr();
		(yyval.scalar_expr_t)->case_idx_ = CASE1;
		(yyval.scalar_expr_t)->literal_ = (yyvsp[0].literal_t);
		
	}
#line 7017 "bison_parser.cpp"
    break;

  case 284:
#line 2842 "bison.y"
                                    {
		(yyval.unary_expr_t) = new UnaryExpr();
		(yyval.unary_expr_t)->case_idx_ = CASE0;
		(yyval.unary_expr_t)->operand_ = (yyvsp[0].operand_t);
		
	}
#line 7028 "bison_parser.cpp"
    break;

  case 285:
#line 2848 "bison.y"
                              {
		(yyval.unary_expr_t) = new UnaryExpr();
		(yyval.unary_expr_t)->case_idx_ = CASE1;
		(yyval.unary_expr_t)->operand_ = (yyvsp[0].operand_t);
		
	}
#line 7039 "bison_parser.cpp"
    break;

  case 286:
#line 2854 "bison.y"
                                    {
		(yyval.unary_expr_t) = new UnaryExpr();
		(yyval.unary_expr_t)->case_idx_ = CASE2;
		(yyval.unary_expr_t)->operand_ = (yyvsp[-1].operand_t);
		
	}
#line 7050 "bison_parser.cpp"
    break;

  case 287:
#line 2860 "bison.y"
                         {
		(yyval.unary_expr_t) = new UnaryExpr();
		(yyval.unary_expr_t)->case_idx_ = CASE3;
		(yyval.unary_expr_t)->operand_ = (yyvsp[-2].operand_t);
		
	}
#line 7061 "bison_parser.cpp"
    break;

  case 288:
#line 2866 "bison.y"
                             {
		(yyval.unary_expr_t) = new UnaryExpr();
		(yyval.unary_expr_t)->case_idx_ = CASE4;
		(yyval.unary_expr_t)->operand_ = (yyvsp[-3].operand_t);
		
	}
#line 7072 "bison_parser.cpp"
    break;

  case 289:
#line 2872 "bison.y"
              {
		(yyval.unary_expr_t) = new UnaryExpr();
		(yyval.unary_expr_t)->case_idx_ = CASE5;
		
	}
#line 7082 "bison_parser.cpp"
    break;

  case 290:
#line 2877 "bison.y"
                {
		(yyval.unary_expr_t) = new UnaryExpr();
		(yyval.unary_expr_t)->case_idx_ = CASE6;
		
	}
#line 7092 "bison_parser.cpp"
    break;

  case 291:
#line 2885 "bison.y"
                   {
		(yyval.binary_expr_t) = new BinaryExpr();
		(yyval.binary_expr_t)->case_idx_ = CASE0;
		(yyval.binary_expr_t)->comp_expr_ = (yyvsp[0].comp_expr_t);
		
	}
#line 7103 "bison_parser.cpp"
    break;

  case 292:
#line 2891 "bison.y"
                                               {
		(yyval.binary_expr_t) = new BinaryExpr();
		(yyval.binary_expr_t)->case_idx_ = CASE1;
		(yyval.binary_expr_t)->operand_1_ = (yyvsp[-2].operand_t);
		(yyval.binary_expr_t)->binary_op_ = (yyvsp[-1].binary_op_t);
		(yyval.binary_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7116 "bison_parser.cpp"
    break;

  case 293:
#line 2899 "bison.y"
                              {
		(yyval.binary_expr_t) = new BinaryExpr();
		(yyval.binary_expr_t)->case_idx_ = CASE2;
		(yyval.binary_expr_t)->operand_1_ = (yyvsp[-2].operand_t);
		(yyval.binary_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7128 "bison_parser.cpp"
    break;

  case 294:
#line 2906 "bison.y"
                                  {
		(yyval.binary_expr_t) = new BinaryExpr();
		(yyval.binary_expr_t)->case_idx_ = CASE3;
		(yyval.binary_expr_t)->operand_1_ = (yyvsp[-3].operand_t);
		(yyval.binary_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7140 "bison_parser.cpp"
    break;

  case 295:
#line 2916 "bison.y"
                       {
		(yyval.logic_expr_t) = new LogicExpr();
		(yyval.logic_expr_t)->case_idx_ = CASE0;
		(yyval.logic_expr_t)->expr_1_ = (yyvsp[-2].expr_t);
		(yyval.logic_expr_t)->expr_2_ = (yyvsp[0].expr_t);
		
	}
#line 7152 "bison_parser.cpp"
    break;

  case 296:
#line 2923 "bison.y"
                      {
		(yyval.logic_expr_t) = new LogicExpr();
		(yyval.logic_expr_t)->case_idx_ = CASE1;
		(yyval.logic_expr_t)->expr_1_ = (yyvsp[-2].expr_t);
		(yyval.logic_expr_t)->expr_2_ = (yyvsp[0].expr_t);
		
	}
#line 7164 "bison_parser.cpp"
    break;

  case 297:
#line 2933 "bison.y"
                                                         {
		(yyval.in_expr_t) = new InExpr();
		(yyval.in_expr_t)->case_idx_ = CASE0;
		(yyval.in_expr_t)->operand_ = (yyvsp[-5].operand_t);
		(yyval.in_expr_t)->opt_not_ = (yyvsp[-4].opt_not_t);
		(yyval.in_expr_t)->select_no_parens_ = (yyvsp[-1].select_no_parens_t);
		
	}
#line 7177 "bison_parser.cpp"
    break;

  case 298:
#line 2941 "bison.y"
                                                  {
		(yyval.in_expr_t) = new InExpr();
		(yyval.in_expr_t)->case_idx_ = CASE1;
		(yyval.in_expr_t)->operand_ = (yyvsp[-5].operand_t);
		(yyval.in_expr_t)->opt_not_ = (yyvsp[-4].opt_not_t);
		(yyval.in_expr_t)->expr_list_ = (yyvsp[-1].expr_list_t);
		
	}
#line 7190 "bison_parser.cpp"
    break;

  case 299:
#line 2949 "bison.y"
                                       {
		(yyval.in_expr_t) = new InExpr();
		(yyval.in_expr_t)->case_idx_ = CASE2;
		(yyval.in_expr_t)->operand_ = (yyvsp[-3].operand_t);
		(yyval.in_expr_t)->opt_not_ = (yyvsp[-2].opt_not_t);
		(yyval.in_expr_t)->table_name_ = (yyvsp[0].table_name_t);
		
	}
#line 7203 "bison_parser.cpp"
    break;

  case 300:
#line 2960 "bison.y"
                                 {
		(yyval.case_expr_t) = new CaseExpr();
		(yyval.case_expr_t)->case_idx_ = CASE0;
		(yyval.case_expr_t)->expr_1_ = (yyvsp[-2].expr_t);
		(yyval.case_expr_t)->case_list_ = (yyvsp[-1].case_list_t);
		
	}
#line 7215 "bison_parser.cpp"
    break;

  case 301:
#line 2967 "bison.y"
                            {
		(yyval.case_expr_t) = new CaseExpr();
		(yyval.case_expr_t)->case_idx_ = CASE1;
		(yyval.case_expr_t)->case_list_ = (yyvsp[-1].case_list_t);
		
	}
#line 7226 "bison_parser.cpp"
    break;

  case 302:
#line 2973 "bison.y"
                                           {
		(yyval.case_expr_t) = new CaseExpr();
		(yyval.case_expr_t)->case_idx_ = CASE2;
		(yyval.case_expr_t)->expr_1_ = (yyvsp[-4].expr_t);
		(yyval.case_expr_t)->case_list_ = (yyvsp[-3].case_list_t);
		(yyval.case_expr_t)->expr_2_ = (yyvsp[-1].expr_t);
		
	}
#line 7239 "bison_parser.cpp"
    break;

  case 303:
#line 2981 "bison.y"
                                      {
		(yyval.case_expr_t) = new CaseExpr();
		(yyval.case_expr_t)->case_idx_ = CASE3;
		(yyval.case_expr_t)->case_list_ = (yyvsp[-3].case_list_t);
		(yyval.case_expr_t)->expr_1_ = (yyvsp[-1].expr_t);
		
	}
#line 7251 "bison_parser.cpp"
    break;

  case 304:
#line 2991 "bison.y"
                                                          {
		(yyval.between_expr_t) = new BetweenExpr();
		(yyval.between_expr_t)->case_idx_ = CASE0;
		(yyval.between_expr_t)->operand_1_ = (yyvsp[-4].operand_t);
		(yyval.between_expr_t)->operand_2_ = (yyvsp[-2].operand_t);
		(yyval.between_expr_t)->operand_3_ = (yyvsp[0].operand_t);
		
	}
#line 7264 "bison_parser.cpp"
    break;

  case 305:
#line 2999 "bison.y"
                                                          {
		(yyval.between_expr_t) = new BetweenExpr();
		(yyval.between_expr_t)->case_idx_ = CASE1;
		(yyval.between_expr_t)->operand_1_ = (yyvsp[-5].operand_t);
		(yyval.between_expr_t)->operand_2_ = (yyvsp[-2].operand_t);
		(yyval.between_expr_t)->operand_3_ = (yyvsp[0].operand_t);
		
	}
#line 7277 "bison_parser.cpp"
    break;

  case 306:
#line 3010 "bison.y"
                                                     {
		(yyval.exists_expr_t) = new ExistsExpr();
		(yyval.exists_expr_t)->case_idx_ = CASE0;
		(yyval.exists_expr_t)->opt_not_ = (yyvsp[-4].opt_not_t);
		(yyval.exists_expr_t)->select_no_parens_ = (yyvsp[-1].select_no_parens_t);
		
	}
#line 7289 "bison_parser.cpp"
    break;

  case 307:
#line 3020 "bison.y"
                                                                     {
		(yyval.function_expr_t) = new FunctionExpr();
		(yyval.function_expr_t)->case_idx_ = CASE0;
		(yyval.function_expr_t)->function_name_ = (yyvsp[-4].function_name_t);
		(yyval.function_expr_t)->opt_filter_clause_ = (yyvsp[-1].opt_filter_clause_t);
		(yyval.function_expr_t)->opt_over_clause_ = (yyvsp[0].opt_over_clause_t);
		
	}
#line 7302 "bison_parser.cpp"
    break;

  case 308:
#line 3028 "bison.y"
                                                                                            {
		(yyval.function_expr_t) = new FunctionExpr();
		(yyval.function_expr_t)->case_idx_ = CASE1;
		(yyval.function_expr_t)->function_name_ = (yyvsp[-6].function_name_t);
		(yyval.function_expr_t)->opt_distinct_ = (yyvsp[-4].opt_distinct_t);
		(yyval.function_expr_t)->expr_list_ = (yyvsp[-3].expr_list_t);
		(yyval.function_expr_t)->opt_filter_clause_ = (yyvsp[-1].opt_filter_clause_t);
		(yyval.function_expr_t)->opt_over_clause_ = (yyvsp[0].opt_over_clause_t);
		
	}
#line 7317 "bison_parser.cpp"
    break;

  case 309:
#line 3041 "bison.y"
                  {
		(yyval.opt_distinct_t) = new OptDistinct();
		(yyval.opt_distinct_t)->case_idx_ = CASE0;
		
	}
#line 7327 "bison_parser.cpp"
    break;

  case 310:
#line 3046 "bison.y"
          {
		(yyval.opt_distinct_t) = new OptDistinct();
		(yyval.opt_distinct_t)->case_idx_ = CASE1;
		
	}
#line 7337 "bison_parser.cpp"
    break;

  case 311:
#line 3054 "bison.y"
                                       {
		(yyval.opt_filter_clause_t) = new OptFilterClause();
		(yyval.opt_filter_clause_t)->case_idx_ = CASE0;
		(yyval.opt_filter_clause_t)->expr_ = (yyvsp[-1].expr_t);
		
	}
#line 7348 "bison_parser.cpp"
    break;

  case 312:
#line 3060 "bison.y"
          {
		(yyval.opt_filter_clause_t) = new OptFilterClause();
		(yyval.opt_filter_clause_t)->case_idx_ = CASE1;
		
	}
#line 7358 "bison_parser.cpp"
    break;

  case 313:
#line 3068 "bison.y"
                                 {
		(yyval.opt_over_clause_t) = new OptOverClause();
		(yyval.opt_over_clause_t)->case_idx_ = CASE0;
		(yyval.opt_over_clause_t)->window_ = (yyvsp[-1].window_t);
		
	}
#line 7369 "bison_parser.cpp"
    break;

  case 314:
#line 3074 "bison.y"
                          {
		(yyval.opt_over_clause_t) = new OptOverClause();
		(yyval.opt_over_clause_t)->case_idx_ = CASE1;
		(yyval.opt_over_clause_t)->window_name_ = (yyvsp[0].window_name_t);
		
	}
#line 7380 "bison_parser.cpp"
    break;

  case 315:
#line 3080 "bison.y"
          {
		(yyval.opt_over_clause_t) = new OptOverClause();
		(yyval.opt_over_clause_t)->case_idx_ = CASE2;
		
	}
#line 7390 "bison_parser.cpp"
    break;

  case 316:
#line 3088 "bison.y"
                     {
		(yyval.case_list_t) = new CaseList();
		(yyval.case_list_t)->case_idx_ = CASE0;
		(yyval.case_list_t)->case_clause_ = (yyvsp[0].case_clause_t);
		
	}
#line 7401 "bison_parser.cpp"
    break;

  case 317:
#line 3094 "bison.y"
                               {
		(yyval.case_list_t) = new CaseList();
		(yyval.case_list_t)->case_idx_ = CASE1;
		(yyval.case_list_t)->case_clause_ = (yyvsp[-1].case_clause_t);
		(yyval.case_list_t)->case_list_ = (yyvsp[0].case_list_t);
		
	}
#line 7413 "bison_parser.cpp"
    break;

  case 318:
#line 3104 "bison.y"
                             {
		(yyval.case_clause_t) = new CaseClause();
		(yyval.case_clause_t)->case_idx_ = CASE0;
		(yyval.case_clause_t)->expr_1_ = (yyvsp[-2].expr_t);
		(yyval.case_clause_t)->expr_2_ = (yyvsp[0].expr_t);
		
	}
#line 7425 "bison_parser.cpp"
    break;

  case 319:
#line 3114 "bison.y"
                                  {
		(yyval.comp_expr_t) = new CompExpr();
		(yyval.comp_expr_t)->case_idx_ = CASE0;
		(yyval.comp_expr_t)->operand_1_ = (yyvsp[-2].operand_t);
		(yyval.comp_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7437 "bison_parser.cpp"
    break;

  case 320:
#line 3121 "bison.y"
                                     {
		(yyval.comp_expr_t) = new CompExpr();
		(yyval.comp_expr_t)->case_idx_ = CASE1;
		(yyval.comp_expr_t)->operand_1_ = (yyvsp[-2].operand_t);
		(yyval.comp_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7449 "bison_parser.cpp"
    break;

  case 321:
#line 3128 "bison.y"
                                        {
		(yyval.comp_expr_t) = new CompExpr();
		(yyval.comp_expr_t)->case_idx_ = CASE2;
		(yyval.comp_expr_t)->operand_1_ = (yyvsp[-2].operand_t);
		(yyval.comp_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7461 "bison_parser.cpp"
    break;

  case 322:
#line 3135 "bison.y"
                                     {
		(yyval.comp_expr_t) = new CompExpr();
		(yyval.comp_expr_t)->case_idx_ = CASE3;
		(yyval.comp_expr_t)->operand_1_ = (yyvsp[-2].operand_t);
		(yyval.comp_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7473 "bison_parser.cpp"
    break;

  case 323:
#line 3142 "bison.y"
                                   {
		(yyval.comp_expr_t) = new CompExpr();
		(yyval.comp_expr_t)->case_idx_ = CASE4;
		(yyval.comp_expr_t)->operand_1_ = (yyvsp[-2].operand_t);
		(yyval.comp_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7485 "bison_parser.cpp"
    break;

  case 324:
#line 3149 "bison.y"
                                      {
		(yyval.comp_expr_t) = new CompExpr();
		(yyval.comp_expr_t)->case_idx_ = CASE5;
		(yyval.comp_expr_t)->operand_1_ = (yyvsp[-2].operand_t);
		(yyval.comp_expr_t)->operand_2_ = (yyvsp[0].operand_t);
		
	}
#line 7497 "bison_parser.cpp"
    break;

  case 325:
#line 3159 "bison.y"
                                                      {
		(yyval.extract_expr_t) = new ExtractExpr();
		(yyval.extract_expr_t)->case_idx_ = CASE0;
		(yyval.extract_expr_t)->datetime_field_ = (yyvsp[-3].datetime_field_t);
		(yyval.extract_expr_t)->expr_ = (yyvsp[-1].expr_t);
		
	}
#line 7509 "bison_parser.cpp"
    break;

  case 326:
#line 3169 "bison.y"
                {
		(yyval.datetime_field_t) = new DatetimeField();
		(yyval.datetime_field_t)->case_idx_ = CASE0;
		
	}
#line 7519 "bison_parser.cpp"
    break;

  case 327:
#line 3174 "bison.y"
                {
		(yyval.datetime_field_t) = new DatetimeField();
		(yyval.datetime_field_t)->case_idx_ = CASE1;
		
	}
#line 7529 "bison_parser.cpp"
    break;

  case 328:
#line 3179 "bison.y"
              {
		(yyval.datetime_field_t) = new DatetimeField();
		(yyval.datetime_field_t)->case_idx_ = CASE2;
		
	}
#line 7539 "bison_parser.cpp"
    break;

  case 329:
#line 3184 "bison.y"
             {
		(yyval.datetime_field_t) = new DatetimeField();
		(yyval.datetime_field_t)->case_idx_ = CASE3;
		
	}
#line 7549 "bison_parser.cpp"
    break;

  case 330:
#line 3189 "bison.y"
               {
		(yyval.datetime_field_t) = new DatetimeField();
		(yyval.datetime_field_t)->case_idx_ = CASE4;
		
	}
#line 7559 "bison_parser.cpp"
    break;

  case 331:
#line 3194 "bison.y"
              {
		(yyval.datetime_field_t) = new DatetimeField();
		(yyval.datetime_field_t)->case_idx_ = CASE5;
		
	}
#line 7569 "bison_parser.cpp"
    break;

  case 332:
#line 3202 "bison.y"
                                                 {
		(yyval.array_expr_t) = new ArrayExpr();
		(yyval.array_expr_t)->case_idx_ = CASE0;
		(yyval.array_expr_t)->expr_list_ = (yyvsp[-1].expr_list_t);
		
	}
#line 7580 "bison_parser.cpp"
    break;

  case 333:
#line 3211 "bison.y"
                                                     {
		(yyval.array_index_t) = new ArrayIndex();
		(yyval.array_index_t)->case_idx_ = CASE0;
		(yyval.array_index_t)->operand_ = (yyvsp[-3].operand_t);
		(yyval.array_index_t)->int_literal_ = (yyvsp[-1].int_literal_t);
		
	}
#line 7592 "bison_parser.cpp"
    break;

  case 334:
#line 3221 "bison.y"
                        {
		(yyval.literal_t) = new Literal();
		(yyval.literal_t)->case_idx_ = CASE0;
		(yyval.literal_t)->string_literal_ = (yyvsp[0].string_literal_t);
		
	}
#line 7603 "bison_parser.cpp"
    break;

  case 335:
#line 3227 "bison.y"
                      {
		(yyval.literal_t) = new Literal();
		(yyval.literal_t)->case_idx_ = CASE1;
		(yyval.literal_t)->bool_literal_ = (yyvsp[0].bool_literal_t);
		
	}
#line 7614 "bison_parser.cpp"
    break;

  case 336:
#line 3233 "bison.y"
                     {
		(yyval.literal_t) = new Literal();
		(yyval.literal_t)->case_idx_ = CASE2;
		(yyval.literal_t)->num_literal_ = (yyvsp[0].num_literal_t);
		
	}
#line 7625 "bison_parser.cpp"
    break;

  case 337:
#line 3242 "bison.y"
                       {
		(yyval.string_literal_t) = new StringLiteral();
		(yyval.string_literal_t)->string_val_ = (yyvsp[0].sval);
		free((yyvsp[0].sval));
		
	}
#line 7636 "bison_parser.cpp"
    break;

  case 338:
#line 3251 "bison.y"
              {
		(yyval.bool_literal_t) = new BoolLiteral();
		(yyval.bool_literal_t)->case_idx_ = CASE0;
		
	}
#line 7646 "bison_parser.cpp"
    break;

  case 339:
#line 3256 "bison.y"
               {
		(yyval.bool_literal_t) = new BoolLiteral();
		(yyval.bool_literal_t)->case_idx_ = CASE1;
		
	}
#line 7656 "bison_parser.cpp"
    break;

  case 340:
#line 3264 "bison.y"
                     {
		(yyval.num_literal_t) = new NumLiteral();
		(yyval.num_literal_t)->case_idx_ = CASE0;
		(yyval.num_literal_t)->int_literal_ = (yyvsp[0].int_literal_t);
		
	}
#line 7667 "bison_parser.cpp"
    break;

  case 341:
#line 3270 "bison.y"
                       {
		(yyval.num_literal_t) = new NumLiteral();
		(yyval.num_literal_t)->case_idx_ = CASE1;
		(yyval.num_literal_t)->float_literal_ = (yyvsp[0].float_literal_t);
		
	}
#line 7678 "bison_parser.cpp"
    break;

  case 342:
#line 3279 "bison.y"
                    {
		(yyval.int_literal_t) = new IntLiteral();
		(yyval.int_literal_t)->int_val_ = (yyvsp[0].ival);
		
	}
#line 7688 "bison_parser.cpp"
    break;

  case 343:
#line 3287 "bison.y"
                      {
		(yyval.float_literal_t) = new FloatLiteral();
		(yyval.float_literal_t)->float_val_ = (yyvsp[0].fval);
		
	}
#line 7698 "bison_parser.cpp"
    break;

  case 344:
#line 3295 "bison.y"
                {
		(yyval.opt_column_t) = new OptColumn();
		(yyval.opt_column_t)->case_idx_ = CASE0;
		
	}
#line 7708 "bison_parser.cpp"
    break;

  case 345:
#line 3300 "bison.y"
          {
		(yyval.opt_column_t) = new OptColumn();
		(yyval.opt_column_t)->case_idx_ = CASE1;
		
	}
#line 7718 "bison_parser.cpp"
    break;

  case 346:
#line 3308 "bison.y"
                   {
		(yyval.trigger_body_t) = new TriggerBody();
		(yyval.trigger_body_t)->case_idx_ = CASE0;
		(yyval.trigger_body_t)->drop_stmt_ = (yyvsp[0].drop_stmt_t);
		
	}
#line 7729 "bison_parser.cpp"
    break;

  case 347:
#line 3314 "bison.y"
                     {
		(yyval.trigger_body_t) = new TriggerBody();
		(yyval.trigger_body_t)->case_idx_ = CASE1;
		(yyval.trigger_body_t)->update_stmt_ = (yyvsp[0].update_stmt_t);
		
	}
#line 7740 "bison_parser.cpp"
    break;

  case 348:
#line 3320 "bison.y"
                     {
		(yyval.trigger_body_t) = new TriggerBody();
		(yyval.trigger_body_t)->case_idx_ = CASE2;
		(yyval.trigger_body_t)->insert_stmt_ = (yyvsp[0].insert_stmt_t);
		
	}
#line 7751 "bison_parser.cpp"
    break;

  case 349:
#line 3326 "bison.y"
                    {
		(yyval.trigger_body_t) = new TriggerBody();
		(yyval.trigger_body_t)->case_idx_ = CASE3;
		(yyval.trigger_body_t)->alter_stmt_ = (yyvsp[0].alter_stmt_t);
		
	}
#line 7762 "bison_parser.cpp"
    break;

  case 350:
#line 3335 "bison.y"
                       {
		(yyval.opt_if_not_exist_t) = new OptIfNotExist();
		(yyval.opt_if_not_exist_t)->case_idx_ = CASE0;
		
	}
#line 7772 "bison_parser.cpp"
    break;

  case 351:
#line 3340 "bison.y"
          {
		(yyval.opt_if_not_exist_t) = new OptIfNotExist();
		(yyval.opt_if_not_exist_t)->case_idx_ = CASE1;
		
	}
#line 7782 "bison_parser.cpp"
    break;

  case 352:
#line 3348 "bison.y"
                   {
		(yyval.opt_if_exist_t) = new OptIfExist();
		(yyval.opt_if_exist_t)->case_idx_ = CASE0;
		
	}
#line 7792 "bison_parser.cpp"
    break;

  case 353:
#line 3353 "bison.y"
          {
		(yyval.opt_if_exist_t) = new OptIfExist();
		(yyval.opt_if_exist_t)->case_idx_ = CASE1;
		
	}
#line 7802 "bison_parser.cpp"
    break;

  case 354:
#line 3361 "bison.y"
                    {
		(yyval.identifier_t) = new Identifier();
		(yyval.identifier_t)->string_val_ = (yyvsp[0].sval);
		free((yyvsp[0].sval));
		
	}
#line 7813 "bison_parser.cpp"
    break;

  case 355:
#line 3370 "bison.y"
                       {
		(yyval.as_alias_t) = new AsAlias();
		(yyval.as_alias_t)->case_idx_ = CASE0;
		(yyval.as_alias_t)->identifier_ = (yyvsp[0].identifier_t);
		if((yyval.as_alias_t)){
			auto tmp1 = (yyval.as_alias_t)->identifier_; 
			if(tmp1){
				tmp1->data_type_ = kDataAliasName; 
				tmp1->scope_ = 1; 
				tmp1->data_flag_ =(DATAFLAG)1; 
			}
		}


	}
#line 7833 "bison_parser.cpp"
    break;

  case 356:
#line 3388 "bison.y"
                    {
		(yyval.table_name_t) = new TableName();
		(yyval.table_name_t)->case_idx_ = CASE0;
		(yyval.table_name_t)->identifier_ = (yyvsp[0].identifier_t);
		if((yyval.table_name_t)){
			auto tmp1 = (yyval.table_name_t)->identifier_; 
			if(tmp1){
				tmp1->data_type_ = kDataTableName; 
				tmp1->scope_ = 1; 
				tmp1->data_flag_ =(DATAFLAG)8; 
			}
		}


	}
#line 7853 "bison_parser.cpp"
    break;

  case 357:
#line 3406 "bison.y"
                    {
		(yyval.column_name_t) = new ColumnName();
		(yyval.column_name_t)->case_idx_ = CASE0;
		(yyval.column_name_t)->identifier_ = (yyvsp[0].identifier_t);
		if((yyval.column_name_t)){
			auto tmp1 = (yyval.column_name_t)->identifier_; 
			if(tmp1){
				tmp1->data_type_ = kDataColumnName; 
				tmp1->scope_ = 2; 
				tmp1->data_flag_ =(DATAFLAG)8; 
			}
		}


	}
#line 7873 "bison_parser.cpp"
    break;

  case 358:
#line 3422 "bison.y"
                                    {
		(yyval.column_name_t) = new ColumnName();
		(yyval.column_name_t)->case_idx_ = CASE1;
		(yyval.column_name_t)->table_name_ = (yyvsp[-2].table_name_t);
		(yyval.column_name_t)->identifier_ = (yyvsp[0].identifier_t);
		if((yyval.column_name_t)){
			auto tmp1 = (yyval.column_name_t)->identifier_; 
			if(tmp1){
				tmp1->data_type_ = kDataColumnName; 
				tmp1->scope_ = 2; 
				tmp1->data_flag_ =(DATAFLAG)8; 
			}
		}
	}
#line 7892 "bison_parser.cpp"
    break;

  case 359:
#line 3439 "bison.y"
                {
		(yyval.opt_index_keyword_t) = new OptIndexKeyword();
		(yyval.opt_index_keyword_t)->case_idx_ = CASE0;
		
	}
#line 7902 "bison_parser.cpp"
    break;

  case 360:
#line 3444 "bison.y"
                  {
		(yyval.opt_index_keyword_t) = new OptIndexKeyword();
		(yyval.opt_index_keyword_t)->case_idx_ = CASE1;
		
	}
#line 7912 "bison_parser.cpp"
    break;

  case 361:
#line 3449 "bison.y"
                 {
		(yyval.opt_index_keyword_t) = new OptIndexKeyword();
		(yyval.opt_index_keyword_t)->case_idx_ = CASE2;
		
	}
#line 7922 "bison_parser.cpp"
    break;

  case 362:
#line 3454 "bison.y"
          {
		(yyval.opt_index_keyword_t) = new OptIndexKeyword();
		(yyval.opt_index_keyword_t)->case_idx_ = CASE3;
		
	}
#line 7932 "bison_parser.cpp"
    break;

  case 363:
#line 3462 "bison.y"
                    {
		(yyval.view_name_t) = new ViewName();
		(yyval.view_name_t)->case_idx_ = CASE0;
		(yyval.view_name_t)->identifier_ = (yyvsp[0].identifier_t);
		
	}
#line 7943 "bison_parser.cpp"
    break;

  case 364:
#line 3471 "bison.y"
                    {
		(yyval.function_name_t) = new FunctionName();
		(yyval.function_name_t)->case_idx_ = CASE0;
		(yyval.function_name_t)->identifier_ = (yyvsp[0].identifier_t);
		if((yyval.function_name_t)){
			auto tmp1 = (yyval.function_name_t)->identifier_; 
			if(tmp1){
				tmp1->data_type_ = kDataFunctionName; 
				tmp1->scope_ = 1; 
				tmp1->data_flag_ =(DATAFLAG)4; 
			}
		}


	}
#line 7963 "bison_parser.cpp"
    break;

  case 365:
#line 3489 "bison.y"
                {
		(yyval.binary_op_t) = new BinaryOp();
		(yyval.binary_op_t)->case_idx_ = CASE0;
		
	}
#line 7973 "bison_parser.cpp"
    break;

  case 366:
#line 3494 "bison.y"
                {
		(yyval.binary_op_t) = new BinaryOp();
		(yyval.binary_op_t)->case_idx_ = CASE1;
		
	}
#line 7983 "bison_parser.cpp"
    break;

  case 367:
#line 3499 "bison.y"
                   {
		(yyval.binary_op_t) = new BinaryOp();
		(yyval.binary_op_t)->case_idx_ = CASE2;
		
	}
#line 7993 "bison_parser.cpp"
    break;

  case 368:
#line 3504 "bison.y"
                {
		(yyval.binary_op_t) = new BinaryOp();
		(yyval.binary_op_t)->case_idx_ = CASE3;
		
	}
#line 8003 "bison_parser.cpp"
    break;

  case 369:
#line 3509 "bison.y"
                {
		(yyval.binary_op_t) = new BinaryOp();
		(yyval.binary_op_t)->case_idx_ = CASE4;
		
	}
#line 8013 "bison_parser.cpp"
    break;

  case 370:
#line 3514 "bison.y"
                {
		(yyval.binary_op_t) = new BinaryOp();
		(yyval.binary_op_t)->case_idx_ = CASE5;
		
	}
#line 8023 "bison_parser.cpp"
    break;

  case 371:
#line 3522 "bison.y"
             {
		(yyval.opt_not_t) = new OptNot();
		(yyval.opt_not_t)->case_idx_ = CASE0;
		
	}
#line 8033 "bison_parser.cpp"
    break;

  case 372:
#line 3527 "bison.y"
          {
		(yyval.opt_not_t) = new OptNot();
		(yyval.opt_not_t)->case_idx_ = CASE1;
		
	}
#line 8043 "bison_parser.cpp"
    break;

  case 373:
#line 3535 "bison.y"
                    {
		(yyval.name_t) = new Name();
		(yyval.name_t)->case_idx_ = CASE0;
		(yyval.name_t)->identifier_ = (yyvsp[0].identifier_t);
		
	}
#line 8054 "bison_parser.cpp"
    break;

  case 374:
#line 3544 "bison.y"
                      {
		(yyval.type_name_t) = new TypeName();
		(yyval.type_name_t)->case_idx_ = CASE0;
		(yyval.type_name_t)->numeric_type_ = (yyvsp[0].numeric_type_t);
		
	}
#line 8065 "bison_parser.cpp"
    break;

  case 375:
#line 3550 "bison.y"
                        {
		(yyval.type_name_t) = new TypeName();
		(yyval.type_name_t)->case_idx_ = CASE1;
		(yyval.type_name_t)->character_type_ = (yyvsp[0].character_type_t);
		
	}
#line 8076 "bison_parser.cpp"
    break;

  case 376:
#line 3559 "bison.y"
                  {
		(yyval.type_name_list_t) = new TypeNameList();
		(yyval.type_name_list_t)->case_idx_ = CASE0;
		(yyval.type_name_list_t)->type_name_ = (yyvsp[0].type_name_t);
	}
#line 8086 "bison_parser.cpp"
    break;

  case 377:
#line 3564 "bison.y"
                                   {
		(yyval.type_name_list_t) = new TypeNameList();
		(yyval.type_name_list_t)->case_idx_ = CASE1;
		(yyval.type_name_list_t)->type_name_ = (yyvsp[-1].type_name_t);
		(yyval.type_name_list_t)->type_name_list_ = (yyvsp[0].type_name_list_t);
	}
#line 8097 "bison_parser.cpp"
    break;

  case 378:
#line 3572 "bison.y"
                               {
		(yyval.character_type_t) = new CharacterType();
		(yyval.character_type_t)->case_idx_ = CASE0;
		(yyval.character_type_t)->character_with_length_ = (yyvsp[0].character_with_length_t);
		
	}
#line 8108 "bison_parser.cpp"
    break;

  case 379:
#line 3578 "bison.y"
                                  {
		(yyval.character_type_t) = new CharacterType();
		(yyval.character_type_t)->case_idx_ = CASE1;
		(yyval.character_type_t)->character_without_length_ = (yyvsp[0].character_without_length_t);
		
	}
#line 8119 "bison_parser.cpp"
    break;

  case 380:
#line 3587 "bison.y"
                                                     {
		(yyval.character_with_length_t) = new CharacterWithLength();
		(yyval.character_with_length_t)->case_idx_ = CASE0;
		(yyval.character_with_length_t)->character_conflicta_ = (yyvsp[-3].character_conflicta_t);
		(yyval.character_with_length_t)->int_literal_ = (yyvsp[-1].int_literal_t);
		
	}
#line 8131 "bison_parser.cpp"
    break;

  case 381:
#line 3597 "bison.y"
                             {
		(yyval.character_without_length_t) = new CharacterWithoutLength();
		(yyval.character_without_length_t)->case_idx_ = CASE0;
		(yyval.character_without_length_t)->character_conflicta_ = (yyvsp[0].character_conflicta_t);
		
	}
#line 8142 "bison_parser.cpp"
    break;

  case 382:
#line 3603 "bison.y"
             {
		(yyval.character_without_length_t) = new CharacterWithoutLength();
		(yyval.character_without_length_t)->case_idx_ = CASE1;
		
	}
#line 8152 "bison_parser.cpp"
    break;

  case 383:
#line 3608 "bison.y"
              {
		(yyval.character_without_length_t) = new CharacterWithoutLength();
		(yyval.character_without_length_t)->case_idx_ = CASE2;
		
	}
#line 8162 "bison_parser.cpp"
    break;

  case 384:
#line 3613 "bison.y"
                {
		(yyval.character_without_length_t) = new CharacterWithoutLength();
		(yyval.character_without_length_t)->case_idx_ = CASE3;
		
	}
#line 8172 "bison_parser.cpp"
    break;

  case 385:
#line 3621 "bison.y"
                   {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE0;
		
	}
#line 8182 "bison_parser.cpp"
    break;

  case 386:
#line 3626 "bison.y"
              {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE1;
		
	}
#line 8192 "bison_parser.cpp"
    break;

  case 387:
#line 3631 "bison.y"
                 {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE2;
		
	}
#line 8202 "bison_parser.cpp"
    break;

  case 388:
#line 3636 "bison.y"
              {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE3;
		
	}
#line 8212 "bison_parser.cpp"
    break;

  case 389:
#line 3641 "bison.y"
                  {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE4;
		
	}
#line 8222 "bison_parser.cpp"
    break;

  case 390:
#line 3646 "bison.y"
                    {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE5;
		
	}
#line 8232 "bison_parser.cpp"
    break;

  case 391:
#line 3651 "bison.y"
                  {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE6;
		
	}
#line 8242 "bison_parser.cpp"
    break;

  case 392:
#line 3656 "bison.y"
                            {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE7;
		
	}
#line 8252 "bison_parser.cpp"
    break;

  case 393:
#line 3661 "bison.y"
                       {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE8;
		
	}
#line 8262 "bison_parser.cpp"
    break;

  case 394:
#line 3666 "bison.y"
               {
		(yyval.character_conflicta_t) = new CharacterConflicta();
		(yyval.character_conflicta_t)->case_idx_ = CASE9;
		
	}
#line 8272 "bison_parser.cpp"
    break;

  case 395:
#line 3674 "bison.y"
             {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE0;
		
	}
#line 8282 "bison_parser.cpp"
    break;

  case 396:
#line 3679 "bison.y"
                 {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE1;
		
	}
#line 8292 "bison_parser.cpp"
    break;

  case 397:
#line 3684 "bison.y"
                  {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE2;
		
	}
#line 8302 "bison_parser.cpp"
    break;

  case 398:
#line 3689 "bison.y"
                {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE3;
		
	}
#line 8312 "bison_parser.cpp"
    break;

  case 399:
#line 3694 "bison.y"
              {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE4;
		
	}
#line 8322 "bison_parser.cpp"
    break;

  case 400:
#line 3699 "bison.y"
               {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE5;
		
	}
#line 8332 "bison_parser.cpp"
    break;

  case 401:
#line 3704 "bison.y"
               {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE6;
		
	}
#line 8342 "bison_parser.cpp"
    break;

  case 402:
#line 3709 "bison.y"
                {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE7;
		
	}
#line 8352 "bison_parser.cpp"
    break;

  case 403:
#line 3714 "bison.y"
                          {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE8;
		
	}
#line 8362 "bison_parser.cpp"
    break;

  case 404:
#line 3719 "bison.y"
                 {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE9;
		
	}
#line 8372 "bison_parser.cpp"
    break;

  case 405:
#line 3724 "bison.y"
             {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE10;
		
	}
#line 8382 "bison_parser.cpp"
    break;

  case 406:
#line 3729 "bison.y"
                 {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE11;
		
	}
#line 8392 "bison_parser.cpp"
    break;

  case 407:
#line 3734 "bison.y"
                 {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE12;
		
	}
#line 8402 "bison_parser.cpp"
    break;

  case 408:
#line 3739 "bison.y"
              {
		(yyval.numeric_type_t) = new NumericType();
		(yyval.numeric_type_t)->case_idx_ = CASE13;
		
  }
#line 8412 "bison_parser.cpp"
    break;

  case 409:
#line 3747 "bison.y"
                               {
		(yyval.opt_table_constraint_list_t) = new OptTableConstraintList();
		(yyval.opt_table_constraint_list_t)->case_idx_ = CASE0;
		(yyval.opt_table_constraint_list_t)->table_constraint_list_ = (yyvsp[0].table_constraint_list_t);
		
	}
#line 8423 "bison_parser.cpp"
    break;

  case 410:
#line 3753 "bison.y"
          {
		(yyval.opt_table_constraint_list_t) = new OptTableConstraintList();
		(yyval.opt_table_constraint_list_t)->case_idx_ = CASE1;
		
	}
#line 8433 "bison_parser.cpp"
    break;

  case 411:
#line 3761 "bison.y"
                          {
		(yyval.table_constraint_list_t) = new TableConstraintList();
		(yyval.table_constraint_list_t)->case_idx_ = CASE0;
		(yyval.table_constraint_list_t)->table_constraint_ = (yyvsp[0].table_constraint_t);
		
	}
#line 8444 "bison_parser.cpp"
    break;

  case 412:
#line 3767 "bison.y"
                                                         {
		(yyval.table_constraint_list_t) = new TableConstraintList();
		(yyval.table_constraint_list_t)->case_idx_ = CASE1;
		(yyval.table_constraint_list_t)->table_constraint_ = (yyvsp[-2].table_constraint_t);
		(yyval.table_constraint_list_t)->table_constraint_list_ = (yyvsp[0].table_constraint_list_t);
		
	}
#line 8456 "bison_parser.cpp"
    break;

  case 413:
#line 3777 "bison.y"
                                                                     {
		(yyval.table_constraint_t) = new TableConstraint();
		(yyval.table_constraint_t)->case_idx_ = CASE0;
		(yyval.table_constraint_t)->constraint_name_ = (yyvsp[-5].constraint_name_t);
		(yyval.table_constraint_t)->indexed_column_list_ = (yyvsp[-1].indexed_column_list_t);
		
	}
#line 8468 "bison_parser.cpp"
    break;

  case 414:
#line 3784 "bison.y"
                                                                {
		(yyval.table_constraint_t) = new TableConstraint();
		(yyval.table_constraint_t)->case_idx_ = CASE1;
		(yyval.table_constraint_t)->constraint_name_ = (yyvsp[-4].constraint_name_t);
		(yyval.table_constraint_t)->indexed_column_list_ = (yyvsp[-1].indexed_column_list_t);
		
	}
#line 8480 "bison_parser.cpp"
    break;

  case 415:
#line 3791 "bison.y"
                                                             {
		(yyval.table_constraint_t) = new TableConstraint();
		(yyval.table_constraint_t)->case_idx_ = CASE2;
		(yyval.table_constraint_t)->constraint_name_ = (yyvsp[-5].constraint_name_t);
		(yyval.table_constraint_t)->expr_ = (yyvsp[-2].expr_t);
		(yyval.table_constraint_t)->opt_enforced_ = (yyvsp[0].opt_enforced_t);
		
	}
#line 8493 "bison_parser.cpp"
    break;

  case 416:
#line 3799 "bison.y"
                                                                                   {
		(yyval.table_constraint_t) = new TableConstraint();
		(yyval.table_constraint_t)->case_idx_ = CASE3;
		(yyval.table_constraint_t)->constraint_name_ = (yyvsp[-6].constraint_name_t);
		(yyval.table_constraint_t)->column_name_list_ = (yyvsp[-2].column_name_list_t);
		(yyval.table_constraint_t)->reference_clause_ = (yyvsp[0].reference_clause_t);
		if((yyval.table_constraint_t)){
			auto tmp1 = (yyval.table_constraint_t)->column_name_list_; 
			while(tmp1){
				auto tmp2 = tmp1->column_name_; 
				if(tmp2){
					auto tmp3 = tmp2->identifier_; 
					if(tmp3){
						tmp3->data_type_ = kDataColumnName; 
						tmp3->scope_ = 2; 
						tmp3->data_flag_ =(DATAFLAG)8; 
					}
				}
				tmp1 = tmp1->column_name_list_;
			}
		}


	}
#line 8522 "bison_parser.cpp"
    break;

  case 417:
#line 3826 "bison.y"
                  {
		(yyval.opt_enforced_t) = new OptEnforced();
		(yyval.opt_enforced_t)->case_idx_ = CASE0;
		
	}
#line 8532 "bison_parser.cpp"
    break;

  case 418:
#line 3831 "bison.y"
                      {
		(yyval.opt_enforced_t) = new OptEnforced();
		(yyval.opt_enforced_t)->case_idx_ = CASE1;
		
	}
#line 8542 "bison_parser.cpp"
    break;

  case 419:
#line 3836 "bison.y"
          {
		(yyval.opt_enforced_t) = new OptEnforced();
		(yyval.opt_enforced_t)->case_idx_ = CASE2;
		
	}
#line 8552 "bison_parser.cpp"
    break;


#line 8556 "bison_parser.cpp"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (&yylloc, result, scanner, YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (&yylloc, result, scanner, yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }

  yyerror_range[1] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, &yylloc, result, scanner);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp, yylsp, result, scanner);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, yyerror_range, 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (&yylloc, result, scanner, YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc, result, scanner);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp, yylsp, result, scanner);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 3843 "bison.y"
