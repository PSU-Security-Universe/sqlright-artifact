#include "../include/sqlite_tlp.h"
#include "../include/mutator.h"
#include <iostream>

#include <algorithm>
#include <regex>
#include <string>

int SQL_TLP::count_valid_stmts(const string &input) {
  int norec_select_count = 0;
  vector<string> queries_vector = string_splitter(input, ";");
  for (string &query : queries_vector)
    if (this->is_oracle_valid_stmt(query))
      norec_select_count++;
  return norec_select_count;
}

bool SQL_TLP::is_oracle_valid_stmt(const string &query) {

  if ((((findStringIter(query, "SELECT") - query.begin()) < 5)) &&
      findStringIn(query, "FROM") && findStringIn(query, "WHERE") &&
      !findStringIn(query, "INSERT") && !findStringIn(query, "UPDATE"))
    return true;

  return false;
}

bool SQL_TLP::mark_all_valid_node(vector<IR *> &v_ir_collector) {
  return true;
}

void SQL_TLP::rewrite_valid_stmt_from_ori(string &query, string &rew_1,
                                          string &rew_2, string &rew_3,
                                          unsigned multi_run_id) {
  // vector<string> stmt_vector = string_splitter(query,
  // "where|WHERE|SELECT|select|FROM|from");

  string ori_query = query;

  while (query[0] == ' ' || query[0] == '\n' ||
         query[0] == '\t') { // Delete duplicated whitespace at the beginning.
    query = query.substr(1, query.size() - 1);
  }

  size_t select_position = 0;
  size_t from_position = -1;
  size_t where_position = -1;
  size_t group_by_position = -1;
  size_t order_by_position = -1;

  vector<size_t> op_lp_v;
  vector<size_t> op_rp_v;

  size_t tmp1 = 0, tmp2 = 0;
  while ((tmp1 = query.find("(", tmp1)) && tmp1 != string::npos) {
    op_lp_v.push_back(tmp1);
    tmp1++;
    if (tmp1 == query.size()) {
      break;
    }
  }
  while ((tmp2 = query.find(")", tmp2)) && tmp2 != string::npos) {
    op_rp_v.push_back(tmp2);
    tmp2++;
    if (tmp2 == query.size()) {
      break;
    }
  }

  if (op_lp_v.size() !=
      op_rp_v.size()) { // The symbol of '(' and ')' is not matched. Ignore all
                        // the '()' symbol.
    op_lp_v.clear();
    op_rp_v.clear();
  }

  for (int i = 0; i < op_lp_v.size();
       i++) { // The symbol of '(' and ')' is not matched. Ignore all the '()'
              // symbol.
    if (op_lp_v[i] > op_rp_v[i]) {
      op_lp_v.clear();
      op_rp_v.clear();
    }
  }

  tmp1 = -1;
  tmp2 = -1;

  tmp1 = query.find("SELECT",
                    0); // The first SELECT statement will always be the correct
                        // outter most SELECT statement. Pick its pos.
  tmp2 = query.find("select", 0);
  if (tmp1 != string::npos) {
    select_position = tmp1;
  }
  if (tmp2 != string::npos && tmp2 < tmp1) {
    select_position = tmp2;
  }

  tmp1 = 0;
  tmp2 = 0;
  from_position = -1;

  do {
    if (tmp1 != string::npos)
      tmp1 = query.find("FROM", tmp1 + 4);
    if (tmp2 != string::npos)
      tmp2 = query.find("from", tmp2 + 4);

    if (tmp1 != string::npos) {
      bool is_ignore = false;
      for (int i = 0; i < op_lp_v.size(); i++) {
        if (tmp1 > op_lp_v[i] && tmp1 < op_rp_v[i]) {
          is_ignore = true;
          break;
        }
      }
      if (!is_ignore) {
        from_position = tmp1;
        break; // from_position is found. Break the outter do...while loop.
      }
    }

    if (tmp2 != string::npos) {
      bool is_ignore = false;
      for (int i = 0; i < op_lp_v.size(); i++) {
        if (tmp2 > op_lp_v[i] && tmp2 < op_rp_v[i]) {
          is_ignore = true;
          break;
        }
      }
      if (!is_ignore) {
        from_position = tmp2;
        break; // from_position is found. Break the outter do...while loop.
      }
    }

  } while (tmp1 != string::npos || tmp2 != string::npos);

  tmp1 = 0;
  tmp2 = 0;
  where_position = -1;

  do {
    if (tmp1 != string::npos)
      tmp1 = query.find("WHERE", tmp1 + 5);
    if (tmp2 != string::npos)
      tmp2 = query.find("where", tmp2 + 5);

    if (tmp1 != string::npos) {
      bool is_ignore = false;
      for (int i = 0; i < op_lp_v.size(); i++) {
        if (tmp1 > op_lp_v[i] && tmp1 < op_rp_v[i]) {
          is_ignore = true;
          break;
        }
      }
      if (!is_ignore) {
        where_position = tmp1;
        break; // where_position is found. Break the outter do...while loop.
      }
    }

    if (tmp2 != string::npos) {
      bool is_ignore = false;
      for (int i = 0; i < op_lp_v.size(); i++) {
        if (tmp2 > op_lp_v[i] && tmp2 < op_rp_v[i]) {
          is_ignore = true;
          break;
        }
      }
      if (!is_ignore) {
        where_position = tmp2;
        break; // where_position is found. Break the outter do...while loop.
      }
    }

  } while (tmp1 != string::npos || tmp2 != string::npos);

  /*** Taking care of GROUP BY stmt.   ***/
  tmp1 = -1, tmp2 = -1;
  size_t tmp = 0;
  while ((tmp = query.find("GROUP BY", tmp + 8)) && (tmp != string::npos)) {
    bool is_ignore = false;
    for (int i = 0; i < op_lp_v.size(); i++) {
      if (tmp > op_lp_v[i] && tmp < op_rp_v[i]) {
        is_ignore = true;
        break;
      }
    }
    if (!is_ignore) {
      tmp1 = tmp;
    }
  } // The last GROUP BY statement outside the bracket will always be the
    // correct outter most GROUP BY statement. Pick its pos.

  tmp = -8;
  while ((tmp = query.find("group by", tmp + 8)) && (tmp != string::npos)) {
    bool is_ignore = false;
    for (int i = 0; i < op_lp_v.size(); i++) {
      if (tmp > op_lp_v[i] && tmp < op_rp_v[i]) {
        is_ignore = true;
        break;
      }
    }
    if (!is_ignore) {
      tmp2 = tmp;
    }
  } // The last GROUP BY statement outside the bracket will always be the
    // correct outter most GROUP BY statement. Pick its pos.
  if (tmp1 != string::npos) {
    group_by_position = tmp1;
  }
  if (tmp2 != string::npos && tmp2 > tmp1) {
    group_by_position = tmp2;
  }

  /*** Taking care of ORDER BY stmt.   ***/
  tmp1 = -1, tmp2 = -1;
  tmp = -8;
  while ((tmp = query.find("ORDER BY", tmp + 8)) && (tmp != string::npos)) {
    bool is_ignore = false;
    for (int i = 0; i < op_lp_v.size(); i++) {
      if (tmp > op_lp_v[i] && tmp < op_rp_v[i]) {
        is_ignore = true;
        break;
      }
    }
    if (!is_ignore) {
      tmp1 = tmp;
    }
  } // The last ORDER BY statement outside the bracket will always be the
    // correct outter most GROUP BY statement. Pick its pos.
  tmp = -8;
  while ((tmp = query.find("order by", tmp + 8)) && (tmp != string::npos)) {
    bool is_ignore = false;
    for (int i = 0; i < op_lp_v.size(); i++) {
      if (tmp > op_lp_v[i] && tmp < op_rp_v[i]) {
        is_ignore = true;
        break;
      }
    }
    if (!is_ignore) {
      tmp2 = tmp;
    }
  } // The last order by statement outside the bracket will always be the
    // correct outter most GROUP BY statement. Pick its pos.
  if (tmp1 != string::npos) {
    order_by_position = tmp1;
  }
  if (tmp2 != string::npos && tmp2 > tmp1) {
    order_by_position = tmp2;
  }

  size_t order_by_len = 0, group_by_len = 0;
  if (group_by_position != string::npos && order_by_position != string::npos) {
    if (group_by_position < order_by_position) {
      group_by_len = order_by_position - group_by_position;
      order_by_len = ori_query.size() - order_by_position;
    } else {
      order_by_len = group_by_position - order_by_position;
      group_by_len = ori_query.size() - group_by_position;
    }
  } else if (group_by_position != string::npos) {
    group_by_len = ori_query.size() - group_by_position;
  } else if (order_by_position != string::npos) {
    order_by_len = ori_query.size() - order_by_position;
  }

  size_t extra_stmt_position =
      min((size_t)(group_by_position), (size_t)(order_by_position));
  // size_t extra_stmt_position = -1;
  // if (group_by_position != string::npos && order_by_position != string::npos)
  //   extra_stmt_position = ((group_by_position < order_by_position) ?
  //   group_by_position : order_by_position);
  // else if (group_by_position != string::npos)
  //   extra_stmt_position = group_by_position;
  // else if (order_by_position != string::npos)
  //   extra_stmt_position = order_by_position;

  string before_select_stmt;
  string select_stmt;
  string from_stmt;
  string where_stmt;
  // string extra_stmt;
  string order_by_stmt;

  before_select_stmt = query.substr(0, select_position - 0);

  select_stmt =
      query.substr(select_position + 6, from_position - select_position - 6);

  if (from_position == -1)
    from_stmt = "";
  else
    from_stmt =
        query.substr(from_position + 4, where_position - from_position - 4);

  if (where_position == -1)
    where_stmt = "";
  else if (extra_stmt_position == -1)
    where_stmt =
        query.substr(where_position + 5, query.size() - where_position - 5);
  else
    where_stmt = query.substr(where_position + 5,
                              extra_stmt_position - where_position - 5);

  where_stmt.erase(where_stmt.find_last_not_of(';')+1);

  if (order_by_position == string::npos)
    order_by_stmt = "";
  else
    order_by_stmt = query.substr(order_by_position, order_by_len);


  // remove where_stmt in order_by_stmt
  int where_stmt_index = order_by_stmt.find("WHERE");
  if (where_stmt_index != string::npos) {
    order_by_stmt = order_by_stmt.substr(0, where_stmt_index);
  }
  // remove order_by_stmt in from_stmt
  int order_by_stmt_index = from_stmt.find("ORDER BY");
  if (order_by_stmt_index != string::npos) {
    from_stmt = from_stmt.substr(0, order_by_stmt_index);  
  }

  /* Muted GROUP BY */
  // if (group_by_position == string::npos)
  //   group_by_stmt = "";
  // else
  //   group_by_stmt = query.substr(group_by_position, group_by_len);

  // if (extra_stmt_position == -1)
  //   extra_stmt = "";
  // else
  //   extra_stmt = query.substr(extra_stmt_position, query.size() -
  //   extra_stmt_position);

  if (!findStringIn(
          ori_query,
          "HAVING")) { // This is not a having stmts. Handle with where stmt.
    
    bool is_union_all = !((findStringIter(ori_query, "SELECT DISTINCT") - ori_query.begin()) < 5) ;

    // if (
    //     /* Do not use UNION ALL, if we have SELECT DISTINCT. */
    //     !((findStringIter(ori_query, "SELECT DISTINCT") - ori_query.begin()) < 5)
    //   ) {

    //  rewrite_where(query, rew_1, before_select_stmt, select_stmt, from_stmt,
    //                where_stmt, "", order_by_stmt, true);

    // } else {

    //   rewrite_where(query, rew_1, before_select_stmt, select_stmt, from_stmt,
    //                 where_stmt, "", order_by_stmt, false);
    // }

    if ( (select_stmt.find("AVG") != string::npos) || (select_stmt.find("avg") != string::npos) ) {
      rewrite_avg(query, rew_1, before_select_stmt, select_stmt, from_stmt, where_stmt, order_by_stmt, is_union_all);
    } else if ( (select_stmt.find("MIN") != string::npos) || (select_stmt.find("min") != string::npos) ) {
      rewrite_min(query, rew_1, before_select_stmt, select_stmt, from_stmt, where_stmt, order_by_stmt, is_union_all);
    } else if ( (select_stmt.find("MAX") != string::npos) || (select_stmt.find("max") != string::npos) ) {
      rewrite_max(query, rew_1, before_select_stmt, select_stmt, from_stmt, where_stmt, order_by_stmt, is_union_all);
    } else if ( (select_stmt.find("SUM") != string::npos) || (select_stmt.find("sum") != string::npos) ) {
      rewrite_sum(query, rew_1, before_select_stmt, select_stmt, from_stmt, where_stmt, order_by_stmt, is_union_all);
    } else if (!is_union_all) {
      rewrite_distinct(query, rew_1, before_select_stmt, select_stmt, from_stmt, where_stmt, order_by_stmt);
    // } else if (group_by_position != string::npos) {
    //   string group_by_stmt = query.substr(group_by_position, group_by_len);
    //   rewrite_groupby(query, rew_1, select_stmt, from_stmt, where_stmt, group_by_stmt, order_by_stmt);
    // } 
    } else {
      rewrite_where(query, rew_1, before_select_stmt, select_stmt, from_stmt, where_stmt, "", order_by_stmt, is_union_all);
    }

    // query = "--" + ori_query + "\n" + query;

    // if (group_by_stmt != "")
    //   cerr << "GROUP BY stmt is: " << group_by_stmt << endl;
    // if (order_by_stmt != "")
    //   cerr << "ORDER BY stmt is: " << order_by_stmt << endl;

  } else {
    // TODO:: Handling HAVING stmt.
    query = "";
    rew_1 = "";
  }

  /* For now, do not process the stmt with the following contents. . */
  /*
  if (((findStringIter(ori_query, "SELECT DISTINCT AVG") - ori_query.begin()) <
       5) ||
      ((findStringIter(ori_query, "SELECT AVG") - ori_query.begin()) < 5) ||
      findStringIn(ori_query, "UNION") || findStringIn(ori_query, "EXCEPT") ||
      findStringIn(ori_query, "OVER") || findStringIn(ori_query, "INTERSECT")) {
    query = "";
    rew_1 = "";
  }

  if (findStringIn(ori_query, "MIN") ||
      findStringIn(ori_query, "MAX") ||
      findStringIn(ori_query, "SUM") ||
      findStringIn(ori_query, "COUNT") ||
      findStringIn(ori_query, "AVG")) {
        query = "";
        rew_1 = "";
      }
  */

  if (findStringIn(ori_query, "COUNT")) {
    query = "";
    rew_1 = "";
  } else if (findStringIn(select_stmt, "OVER(")) {
    query = "";
    rew_1 = "";
  }

  // cout << "before select stmt: " << before_select_stmt.c_str() << endl;
  // cout << "select stmt: " << select_stmt.c_str() << endl;
  // cout << "from stmt: " << from_stmt.c_str() << endl;
  // cout << "where stmt: " << where_stmt.c_str() << endl;
  // cout << "order by stmt: " << order_by_stmt.c_str() << endl;

  rew_2 = "";
  rew_3 = "";
}

void SQL_TLP::rewrite_avg(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &order_by_stmt,
                     const bool is_union_all) {

   int avg_lp_idx = sel_stmt.find("(") + 1;
   int avg_rp_idx = sel_stmt.rfind(")");
   string avg_stmt = sel_stmt.substr(avg_lp_idx, avg_rp_idx-avg_lp_idx);
  //  cout << "average stmt: " << avg_stmt.c_str() << endl;

   if (where_stmt == "") {
    if (bef_sel_stmt != "") {
      rew_1 += bef_sel_stmt + " ";
    }

    rew_1 += "SELECT SUM ( s ) / SUM ( c ) FROM ( ";

    rew_1 += "SELECT SUM ( " + avg_stmt + " ) AS s, COUNT ( " + avg_stmt + " ) AS c ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE TRUE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT SUM ( " + avg_stmt + " ) AS s, COUNT ( " + avg_stmt + " ) AS c ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE FALSE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT SUM ( " + avg_stmt + " ) AS s, COUNT ( " + avg_stmt + " ) AS c ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE NULL ";
    rew_1 += order_by_stmt ;
    rew_1 += " )";

  } else {
    if (bef_sel_stmt != "") {
      rew_1 += bef_sel_stmt + " ";
    }

    rew_1 += "SELECT SUM ( s ) / SUM ( c ) FROM ( ";

    rew_1 += "SELECT SUM ( " + avg_stmt + " ) AS s, COUNT ( " + avg_stmt + " ) AS c ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS TRUE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT SUM ( " + avg_stmt + " ) AS s, COUNT ( " + avg_stmt + " ) AS c ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS FALSE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT SUM ( " + avg_stmt + " ) AS s, COUNT ( " + avg_stmt + " ) AS c ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + ")  IS NULL ";
    rew_1 += order_by_stmt;
    rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;
  }
}



void SQL_TLP::rewrite_min(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &order_by_stmt, 
                     const bool is_union_all) {
    int lp_idx = sel_stmt.find("(") + 1;
    int rp_idx = sel_stmt.rfind(")");
    string new_sel_stmt = sel_stmt.substr(lp_idx, rp_idx-lp_idx);
    // int comma_idx = new_sel_stmt.find(",", rp_idx);
    // new_sel_stmt = new_sel_stmt.substr(0, comma_idx);
    new_sel_stmt = " MIN ( " + new_sel_stmt + " ) "; 

    int as_alias_idx = sel_stmt.find(" AS ");
    new_sel_stmt = new_sel_stmt.substr(0, as_alias_idx); 
   
   if (where_stmt == "") {
     if (bef_sel_stmt != "") {
      rew_1 += bef_sel_stmt + " ";
    }

    rew_1 += "SELECT MIN(aggr) FROM ( ";

    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE TRUE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE FALSE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE NULL ";
    rew_1 += order_by_stmt ;
    rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;
  } else {
    if (bef_sel_stmt != "") {
      rew_1 += bef_sel_stmt + " ";
    }

    rew_1 += "SELECT MIN(aggr) FROM ( ";

    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS TRUE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS FALSE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS NULL ";
    rew_1 += order_by_stmt;
    rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;
  
  }
}



void SQL_TLP::rewrite_max(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &order_by_stmt, 
                     const bool is_union_all) {
   int lp_idx = sel_stmt.find("(") + 1;
   int rp_idx = sel_stmt.rfind(")");
   string new_sel_stmt = sel_stmt.substr(lp_idx, rp_idx-lp_idx);
  //  int comma_idx = new_sel_stmt.find(",", rp_idx);
  //  new_sel_stmt = new_sel_stmt.substr(0, comma_idx);
   new_sel_stmt = " MAX ( " + new_sel_stmt + " ) "; 

   int as_alias_idx = sel_stmt.find(" AS ");
   new_sel_stmt = new_sel_stmt.substr(0, as_alias_idx); 

   if (where_stmt == "") {
     if (bef_sel_stmt != "") {
      rew_1 += bef_sel_stmt + " ";
    }

    rew_1 += "SELECT MAX(aggr) FROM ( ";

    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE TRUE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE FALSE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE NULL ";
    rew_1 += order_by_stmt ;
    rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;
  } else {
    if (bef_sel_stmt != "") {
      rew_1 += bef_sel_stmt + " ";
    }

    rew_1 += "SELECT MAX(aggr) FROM ( ";

    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS TRUE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS FALSE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS NULL ";
    rew_1 += order_by_stmt;
    rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;

  }
}



void SQL_TLP::rewrite_sum(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, const string &order_by_stmt, 
                     const bool is_union_all) {
   int lp_idx = sel_stmt.find("(") + 1;
   int rp_idx = sel_stmt.rfind(")");
   string new_sel_stmt = sel_stmt.substr(lp_idx, rp_idx-lp_idx);
  //  int comma_idx = new_sel_stmt.find(",", rp_idx);
  //  new_sel_stmt = new_sel_stmt.substr(0, comma_idx);
   new_sel_stmt = " SUM ( " + new_sel_stmt + " ) "; 

   int as_alias_idx = sel_stmt.find(" AS ");
   new_sel_stmt = new_sel_stmt.substr(0, as_alias_idx); 

   if (where_stmt == "") {
    if (bef_sel_stmt != "") {
      rew_1 += bef_sel_stmt + " ";
    }

    rew_1 += "SELECT SUM(aggr) FROM ( ";

    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE TRUE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE FALSE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE NULL ";
    rew_1 += order_by_stmt ;
    rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;
  } else {
    if (bef_sel_stmt != "") {
      rew_1 += bef_sel_stmt + " ";
    }

    rew_1 += "SELECT SUM(aggr) FROM ( ";

    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS TRUE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS FALSE ";

    if (is_union_all) {
      rew_1 += " UNION ALL ";
    } else {
      rew_1 += " UNION ";
    }
    
    rew_1 += "SELECT " + new_sel_stmt + " AS aggr ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS NULL ";
    rew_1 += order_by_stmt;
    rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;
  
  }
}



void SQL_TLP::rewrite_distinct(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, 
                     const string &order_by_stmt) {
   int comma_idx = sel_stmt.find(",");
   string new_sel_stmt = sel_stmt.substr(0, comma_idx);

   if (where_stmt == "") {

    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE TRUE ";

    rew_1 += " UNION ";
    
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE FALSE ";

    rew_1 += " UNION ";
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE NULL ";
    rew_1 += order_by_stmt ;
    // rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;
  } else {
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS TRUE ";

    rew_1 += " UNION ";
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS FALSE ";

    rew_1 += " UNION ";
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS NULL ";
    rew_1 += order_by_stmt;
    // rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + order_by_stmt;
  
  }
}



void SQL_TLP::rewrite_groupby(string &ori, string &rew_1,
                     const string &bef_sel_stmt, 
                     const string &sel_stmt, const string &from_stmt,
                     const string &where_stmt, 
                     const string &group_by_stmt,
                     const string &order_by_stmt) {
   int comma_idx = sel_stmt.find(",");
   string new_sel_stmt = sel_stmt.substr(0, comma_idx);

   if (where_stmt == "") {
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE TRUE ";
    rew_1 += group_by_stmt ;

    rew_1 += " UNION ";
    
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE FALSE ";
    rew_1 += group_by_stmt ;

    rew_1 += " UNION ";
    
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE NULL ";
    rew_1 += group_by_stmt + " " + order_by_stmt ;
    // rew_1 += " )";
    
    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + group_by_stmt + " " + order_by_stmt;
  } else {

    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS TRUE ";
    rew_1 += group_by_stmt ;

    rew_1 += " UNION ";
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS FALSE ";
    rew_1 += group_by_stmt ;

    rew_1 += " UNION ";
    
    rew_1 += bef_sel_stmt + " SELECT " + new_sel_stmt + " ";
    rew_1 += "FROM " + from_stmt + " ";
    rew_1 += "WHERE ( " + where_stmt + " ) IS NULL ";
    rew_1 += group_by_stmt + " " + order_by_stmt;
    // rew_1 += " )";

    ori = bef_sel_stmt + " SELECT " + new_sel_stmt + " FROM " + from_stmt + " " + group_by_stmt + " " + order_by_stmt;
  
  }
}


void SQL_TLP::rewrite_where(string &ori, string &rew_1,
                            const string &bef_sel_stmt, const string &sel_stmt,
                            const string &from_stmt, const string &where_stmt,
                            const string &group_by_stmt,
                            const string &order_by_stmt,
                            const bool is_union_all) {
  /* Taking care of TLP select stmt: SELECT x FROM x [joins] */
  if (where_stmt == "") {
    rew_1 = bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
            " WHERE TRUE " + group_by_stmt;
    if (is_union_all)
      rew_1 += " UNION ALL ";
    else
      rew_1 += " UNION ";
    rew_1 += bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
             " WHERE FALSE " + group_by_stmt;
    if (is_union_all)
      rew_1 += " UNION ALL ";
    else
      rew_1 += " UNION ";
    rew_1 += bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
             " WHERE NULL " + group_by_stmt + " " + order_by_stmt;

  } else {

    rew_1 = bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
            " WHERE (" + where_stmt + ") IS TRUE" + group_by_stmt;
    if (is_union_all)
      rew_1 += " UNION ALL ";
    else
      rew_1 += " UNION ";
    rew_1 += bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
             " WHERE (" + where_stmt + ") IS FALSE" + group_by_stmt;
    if (is_union_all)
      rew_1 += " UNION ALL ";
    else
      rew_1 += " UNION ";
    rew_1 += bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt +
             " WHERE (" + where_stmt + ") IS NULL " + group_by_stmt + " " +
             order_by_stmt;

    ori = bef_sel_stmt + " SELECT " + sel_stmt + " FROM " + from_stmt + " " +
          group_by_stmt + " " + order_by_stmt;
  }
}

string SQL_TLP::rewrite_having(string &ori, string &rew_1,
                               const string &before_select_stmt,
                               const string &select_stmt,
                               const string &from_stmt,
                               const string &where_stmt,
                               const string &extra_stmt) {
  // TODO:: Implement having stmts.
  return "";
}

string SQL_TLP::remove_valid_stmts_from_str(string query) {
  string output_query = "";
  vector<string> queries_vector = string_splitter(query, ";");

  for (auto current_stmt : queries_vector) {
    if (is_str_empty(current_stmt))
      continue;
    if (!is_oracle_valid_stmt(current_stmt))
      output_query += current_stmt + "; ";
  }

  return output_query;
}

bool SQL_TLP::compare_norm(COMP_RES &res) {

  string &res_a = res.res_str_0;
  string &res_b = res.res_str_1;
  int &res_a_int = res.res_int_0;
  int &res_b_int = res.res_int_1;

  if (res_a.find("Error") != string::npos ||
      res_b.find("Error") != string::npos) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  res_a_int = 0;
  res_b_int = 0;

  vector<string> v_res_a = string_splitter(res_a, "\n");
  vector<string> v_res_b = string_splitter(res_b, "\n");

  if (v_res_a.size() > 50 || v_res_b.size() > 50) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  /* Remove NULL results */
  for (string &r : v_res_a) {
    if (is_str_empty(r))
      res_a_int--;
  }

  for (string &r : v_res_b) {
    if (is_str_empty(r))
      res_b_int--;
  }

  v_res_a.clear();
  v_res_b.clear();

  res_a_int += std::count(res_a.begin(), res_a.end(), '\n');
  res_b_int += std::count(res_b.begin(), res_b.end(), '\n');

  /* For case that the first stmt return NULL, but the second stmt returns all 0. */
  if (res_a_int == 0) {
    bool is_all_zero = true;
    for (string& r : v_res_b) {
      if (r != "0") {
        is_all_zero = false;
        break;
      }
    }
    if (is_all_zero) {
      res.comp_res = ORA_COMP_RES::Pass;
      return false;
    }
  }

  if (res_a_int != res_b_int) { // Found inconsistent.
    // cerr << "NORMAL Found mismatched: " << "res_a: " << res_a << "res_b: " <<
    // res_b << " res_a_int: " << res_a_int << "res_b_int: " << res_b_int <<
    // endl;
    res.comp_res = ORA_COMP_RES::Fail;
    return false;
  }
  res.comp_res = ORA_COMP_RES::Pass;
  return false;
}

bool SQL_TLP::compare_uniq(COMP_RES &res) {

  string &res_a = res.res_str_0;
  string &res_b = res.res_str_1;
  int &res_a_int = res.res_int_0;
  int &res_b_int = res.res_int_1;

  if (res_a.find("Error") != string::npos ||
      res_b.find("Error") != string::npos) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  res_a_int = 0;
  res_b_int = 0;

  vector<string> v_res_a = string_splitter(res_a, "\n");
  vector<string> v_res_b = string_splitter(res_b, "\n");

  if (v_res_a.size() > 50 || v_res_b.size() > 50) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  set<string> uniq_rows;

  /* Remove NULL results */
  for (string &r : v_res_a) {
    if (is_str_empty(r)) {
      res_a_int--;
    } else if (uniq_rows.find(r) != uniq_rows.end()) {      /* Remove duplicated results. */ 
      res_a_int--;
    } else {
      uniq_rows.insert(r);
    }

  }
  uniq_rows.clear();

  for (string &r : v_res_b) {
    if (is_str_empty(r)) {
      res_b_int--;
    } else if (uniq_rows.find(r) != uniq_rows.end()) {      /* Remove duplicated results. */ 
      res_b_int--;
    } else {
      uniq_rows.insert(r);
    }

  }
  uniq_rows.clear();

  res_a_int += std::count(res_a.begin(), res_a.end(), '\n');
  res_b_int += std::count(res_b.begin(), res_b.end(), '\n');

  /* For case that the first stmt return NULL, but the second stmt returns all 0. */
  if (res_a_int == 0) {
    bool is_all_zero = true;
    for (string& r : v_res_b) {
      if (r != "0") {
        is_all_zero = false;
        break;
      }
    }
    if (is_all_zero) {
      res.comp_res = ORA_COMP_RES::Pass;
      return false;
    }
  }

  if (res_a_int != res_b_int) { // Found inconsistent.
    // cerr << "NORMAL Found mismatched: " << "res_a: " << res_a << "res_b: " <<
    // res_b << " res_a_int: " << res_a_int << "res_b_int: " << res_b_int <<
    // endl;
    res.comp_res = ORA_COMP_RES::Fail;
    return false;
  }
  res.comp_res = ORA_COMP_RES::Pass;
  return false;
}

/* Handle MIN valid stmt: SELECT MIN(*) FROM ...; and MAX valid stmt: SELECT
 * MAX(*) FROM ...;  */
bool SQL_TLP::compare_aggr(COMP_RES &res) {
  string &res_a = res.res_str_0;
  string &res_b = res.res_str_1;
  int &res_a_int = res.res_int_0;
  int &res_b_int = res.res_int_1;

  if (res_a.find("Error") != string::npos ||
      res_b.find("Error") != string::npos) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  try {
    res_a_int = stoi(res.res_str_0);
    res_b_int = stoi(res.res_str_1);
  } catch (std::invalid_argument &e) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  } catch (std::out_of_range &e) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  } catch (const std::exception& e) {
    res.comp_res = ORA_COMP_RES::Error;
    return true;
  }

  if (res_a_int != res_b_int) {
    res.comp_res = ORA_COMP_RES::Fail;
  } else {
    res.comp_res = ORA_COMP_RES::Pass;
  }

  return false;
}


/* Handle MIN valid stmt: SELECT MIN(*) FROM ...; and MAX valid stmt: SELECT
 * MAX(*) FROM ...;  */
bool SQL_TLP::compare_sum_count_minmax(COMP_RES &res,
                                       VALID_STMT_TYPE_TLP valid_type) {

  res.comp_res = ORA_COMP_RES::IGNORE;
  return true;
} 

void SQL_TLP::compare_results(ALL_COMP_RES &res_out) {

  res_out.final_res = ORA_COMP_RES::Pass;
  bool is_all_err = true;

  vector<VALID_STMT_TYPE_TLP> v_valid_type;
  get_v_valid_type(res_out.cmd_str, v_valid_type);

  if (v_valid_type.size() != res_out.v_res.size()) {
    for (COMP_RES &res : res_out.v_res) {
      res.comp_res = ORA_COMP_RES::Error;
    }
    res_out.final_res = ORA_COMP_RES::ALL_Error;
    return;
  }

  int i = 0;
  for (COMP_RES &res : res_out.v_res) {

    if (i >= v_valid_type.size()) {
      /* The size of res_out is different from VALID_STMT_TYPE_TLP, Error and ignore. */
      res.comp_res = ORA_COMP_RES::Error;
      break;
    }

    switch (v_valid_type[i++]) {
      case VALID_STMT_TYPE_TLP::NORMAL:
        /* Handle normal valid stmt: SELECT * FROM ...; */
        if (!compare_norm(res))
          {is_all_err = false;}
        break; // Break the switch
      
      /* Compare unique results */
      case VALID_STMT_TYPE_TLP::DISTINCT:
        [[fallthrough]];
      case VALID_STMT_TYPE_TLP::GROUP_BY:
        compare_uniq(res);
        break;

      /* Compare concret values */
      case VALID_STMT_TYPE_TLP::AGGR_AVG:
        [[fallthrough]];
      case VALID_STMT_TYPE_TLP::AGGR_COUNT:
        [[fallthrough]];
      case VALID_STMT_TYPE_TLP::AGGR_MAX:
        [[fallthrough]];
      case VALID_STMT_TYPE_TLP::AGGR_MIN:
        [[fallthrough]];
      case VALID_STMT_TYPE_TLP::AGGR_SUM:
        if (!compare_aggr(res))
          {is_all_err = false;}
        break; // Break the switch

      default:
        res.comp_res = ORA_COMP_RES::Error;
        break;
    } // Switch stmt.
    if (res.comp_res == ORA_COMP_RES::Fail)
      {res_out.final_res = ORA_COMP_RES::Fail;}
  } // Result outer loop.

  if (is_all_err && res_out.final_res != ORA_COMP_RES::Fail)
    res_out.final_res = ORA_COMP_RES::ALL_Error;

  return;
}

void SQL_TLP::get_v_valid_type(const string &cmd_str,
                               vector<VALID_STMT_TYPE_TLP> &v_valid_type) {
  /* Look throught first validation stmt's result_1 first */
  size_t begin_idx = cmd_str.find("SELECT 'BEGIN VERI 0';", 0);
  size_t end_idx = cmd_str.find("SELECT 'END VERI 0';", 0);

  while (begin_idx != string::npos) {
    if (end_idx != string::npos) {
      string cur_cmd_str =
          cmd_str.substr(begin_idx + 23, (end_idx - begin_idx - 23));
      begin_idx = cmd_str.find("SELECT 'BEGIN VERI 0';", begin_idx + 23);
      end_idx = cmd_str.find("SELECT 'END VERI 0';", end_idx + 21);

      vector<string> v_cur_cmd = string_splitter(cur_cmd_str, " "); 

      if (findStringInVector(v_cur_cmd, "DISTINCT")) {
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::DISTINCT); 
      } 
      else if (findStringInVector(v_cur_cmd, "MIN")) {
        if (findStringIn(cur_cmd_str, "GROUP BY")) {
          v_valid_type.push_back(VALID_STMT_TYPE_TLP::TLP_UNKNOWN);  
        }
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::AGGR_MIN); 
      }
      else if (findStringInVector(v_cur_cmd, "MAX")) {
        if (findStringIn(cur_cmd_str, "GROUP BY")) {
          v_valid_type.push_back(VALID_STMT_TYPE_TLP::TLP_UNKNOWN);  
        }
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::AGGR_MAX); 
      }
      else if (findStringInVector(v_cur_cmd, "COUNT")) {
        if (findStringIn(cur_cmd_str, "GROUP BY")) {
          v_valid_type.push_back(VALID_STMT_TYPE_TLP::TLP_UNKNOWN);  
        }
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::AGGR_COUNT); 
      }
      else if (findStringInVector(v_cur_cmd, "SUM")) {
        if (findStringIn(cur_cmd_str, "GROUP BY")) {
          v_valid_type.push_back(VALID_STMT_TYPE_TLP::TLP_UNKNOWN);  
        }
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::AGGR_SUM); 
      }
      else if (findStringInVector(v_cur_cmd, "AVG")) {
        if (findStringIn(cur_cmd_str, "GROUP BY")) {
          v_valid_type.push_back(VALID_STMT_TYPE_TLP::TLP_UNKNOWN);  
        }
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::AGGR_AVG); 
      }
      else if (findStringIn(cur_cmd_str, "GROUP BY")) {
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::GROUP_BY); 
      } 
      else {
        v_valid_type.push_back(VALID_STMT_TYPE_TLP::NORMAL);
        // cerr << "query: " << cur_cmd_str << " \nNORM. \n";
      }

    } else {
      break; // For the current begin_idx, we cannot find the end_idx. Ignore
             // the current output.
    }
  }
}

bool SQL_TLP::is_str_contains_group(const string &input_str) {
  // check whether if 'input_str' contains 'GROUP BY' keyword.
  if ((input_str.find("GROUP BY") != string::npos) ||
      (input_str.find("GROUP") != string::npos)) {
    return true;
  }

  return false;
}

bool SQL_TLP::is_str_contains_aggregate(const string &input_str) {
  // check whether if 'input_str' contains aggregate function.
  if ((input_str.find("MIN") != string::npos) ||
      (input_str.find("MAX") != string::npos) ||
      (input_str.find("SUM") != string::npos) ||
      (input_str.find("COUNT") != string::npos)) {
    return true;
  }

  return false;
}

// bool SQL_TLP::is_oracle_select_stmt(IR* cur_IR) {}
// IR* SQL_TLP::transform_aggr(IR* cur_stmt, bool is_UNION_ALL, VALID_STMT_TYPE_TLP tlp_type) {}
// IR* SQL_TLP::transform_non_aggr(IR* cur_stmt, bool is_UNION_ALL, VALID_STMT_TYPE_TLP tlp_type) {}
// vector<IR*> SQL_TLP::post_fix_transform_select_stmt(IR* cur_stmt, unsigned multi_run_id) {}
