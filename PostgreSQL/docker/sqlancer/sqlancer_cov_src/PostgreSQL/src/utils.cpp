#include "../include/utils.h"
#include <algorithm>
#include <dirent.h>
#include <regex>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <functional> 
#include <cctype>
#include <locale>

string magic_string_generator(string &s) {
  unsigned int i = get_rand_int(100);
  if (i < 80)
    return s;
  return "**%s**";
}

typedef unsigned long uint64_t;

uint64_t fuzzing_hash(const void *key, int len) {
  const uint64_t m = 0xc6a4a7935bd1e995;
  const int r = 47;
  uint64_t h = 0xdeadbeefdeadbeef ^ (len * m);

  const uint64_t *data = (const uint64_t *)key;
  const uint64_t *end = data + (len / 8);

  while (data != end) {
    uint64_t k = *data++;

    k *= m;
    k ^= k >> r;
    k *= m;

    h ^= k;
    h *= m;
  }

  const unsigned char *data2 = (const unsigned char *)data;

  switch (len & 7) {
  case 7:
    h ^= uint64_t(data2[6]) << 48;
  case 6:
    h ^= uint64_t(data2[5]) << 40;
  case 5:
    h ^= uint64_t(data2[4]) << 32;
  case 4:
    h ^= uint64_t(data2[3]) << 24;
  case 3:
    h ^= uint64_t(data2[2]) << 16;
  case 2:
    h ^= uint64_t(data2[1]) << 8;
  case 1:
    h ^= uint64_t(data2[0]);
    h *= m;
  };

  h ^= h >> r;
  h *= m;
  h ^= h >> r;

  return h;
}

bool BothAreSpaces(char lhs, char rhs) { return (lhs == rhs) && (lhs == ' '); }

// void trim_string(string &res) {
//   int count = 0;
//   int idx = 0;
//   bool expect_space = false;
//   for (int i = 0; i < res.size(); i++) {
//     if (res[i] == ';' && i != res.size() - 1) {
//       res[i + 1] = '\n';
//     }
//     if (res[i] == ' ') {
//       if (expect_space == false) {
//         continue;
//       } else {
//         expect_space = false;
//         res[idx++] = res[i];
//         count++;
//       }
//     } else {
//       expect_space = true;
//       res[idx++] = res[i];
//       count++;
//     }
//   }

//   res.resize(count);
// }

// remove leading and ending spaces
// reduce 2+ spaces to one
// change ' ;' to ';'
void trim_string(string &res) {

  // string::iterator new_end = unique(res.begin(), res.end(), BothAreSpaces);
  // res.erase(new_end, res.end());

  // res.erase(0, res.find_first_not_of(' '));
  // res.erase(res.find_last_not_of(' ') + 1);

  int effect_idx = 0, idx = 0;
  bool prev_is_space = false;
  int sz = res.size();

  // skip leading spaces
  for (; idx < sz && res[idx] == ' '; idx++)
    ;

  // now idx points to the first non-space character
  for (; idx < sz; idx++) {

    char &c = res[idx];

    if (c == ' ') {

      if (prev_is_space)
        continue;

      prev_is_space = true;
      res[effect_idx++] = c;

    } else if (c == ';' || c == ',') {

      if (prev_is_space)
        res[effect_idx - 1] = c;
      else
        res[effect_idx++] = c;

      prev_is_space = false;

    } else {

      prev_is_space = false;
      res[effect_idx++] = c;
    }
  }

  if (effect_idx > 0 && res[effect_idx - 1] == ' ')
    effect_idx--;

  res.resize(effect_idx);
}

// trim from both ends
std::string trim(const std::string &s)
{
    std::string::const_iterator it = s.begin();
    while (it != s.end() && isspace(*it))
        it++;

    std::string::const_reverse_iterator rit = s.rbegin();
    while (rit.base() != it && isspace(*rit))
        rit++;

    return std::string(it, rit.base());
}

vector<string> get_all_files_in_dir(const char *dir_name) {
  vector<string> file_list;
  // check the parameter !
  if (NULL == dir_name) {
    cout << " dir_name is null ! " << endl;
    return file_list;
  }

  // check if dir_name is a valid dir
  struct stat s;
  lstat(dir_name, &s);
  if (!S_ISDIR(s.st_mode)) {
    cout << "dir_name is not a valid directory !" << endl;
    return file_list;
  }

  struct dirent *filename; // return value for readdir()
  DIR *dir;                // return value for opendir()
  dir = opendir(dir_name);
  if (NULL == dir) {
    cout << "Can not open dir " << dir_name << endl;
    return file_list;
  }
  cout << "Successfully opened the dir !" << endl;

  /* read all the files in the dir ~ */
  while ((filename = readdir(dir)) != NULL) {
    // get rid of "." and ".."
    if (strcmp(filename->d_name, ".") == 0 ||
        strcmp(filename->d_name, "..") == 0)
      continue;
    // cout << filename->d_name << endl;
    file_list.push_back(string(filename->d_name));
  }
  closedir(dir);
  return file_list;
}

void ensure_semicolon_at_query_end(string &stmt) {
  for (auto idx = stmt.rbegin(); idx != stmt.rend(); idx++) {
    if (*idx == ';') {
      return;
    } else if (
      *idx == ' ' ||
      *idx == '\t' ||
      *idx == '\n'
    ) {
      continue;
    } else {
      stmt += "; ";
      return;
    }
  }
}

vector<string> string_splitter(const string &input_string,
                               string delimiter_re = "\n") {
  std::regex re(delimiter_re);
  std::sregex_token_iterator first{input_string.begin(), input_string.end(), re,
                                   -1},
      last; // the '-1' is what makes the regex split (-1 := what was not
            // matched)
  vector<string> split_string{first, last};

  return split_string;
}

// from http://www.cplusplus.com/forum/beginner/114790/
vector<string> string_splitter2(const std::string &s, const char delimiter) {

  size_t start = 0;
  size_t end = s.find_first_of(delimiter);

  vector<string> output;

  while (end <= string::npos) {

    output.emplace_back(s.substr(start, end - start));

    if (end == string::npos)
      break;

    start = end + 1;
    end = s.find_first_of(delimiter, start);
  }

  return output;
}

bool is_str_empty(string input_str) {
  for (int i = 0; i < input_str.size(); i++) {
    char c = input_str[i];
    if (!isspace(c) && c != '\n' && c != '\0')
      return false; // Not empty.
  }
  return true; // Empty
}

string::const_iterator findStringIter(const std::string &strHaystack,
                                      const std::string &strNeedle) {
  auto it =
      std::search(strHaystack.begin(), strHaystack.end(), strNeedle.begin(),
                  strNeedle.end(), [](char ch1, char ch2) {
                    return std::toupper(ch1) == std::toupper(ch2);
                  });
  return it;
}

bool findStringIn(const std::string &strHaystack,
                  const std::string &strNeedle) {
  return (findStringIter(strHaystack, strNeedle) != strHaystack.end());
}

string gen_string() { return string("x"); }

double gen_float() { return 1.2; }

long gen_long() { return 1; }

int gen_int() { return 1; }

Program *parser(string sql) {

  yyscan_t scanner;
  YY_BUFFER_STATE state;
  Program *p = new Program();

  if (ff_lex_init(&scanner)) {
    p->deep_delete();
    return NULL;
  }
  state = ff__scan_string(sql.c_str(), scanner);

  int ret = ff_parse(p, scanner);

  ff__delete_buffer(state, scanner);
  ff_lex_destroy(scanner);
  if (ret != 0) {
    p->deep_delete();
    return NULL;
  }

  return p;
}
