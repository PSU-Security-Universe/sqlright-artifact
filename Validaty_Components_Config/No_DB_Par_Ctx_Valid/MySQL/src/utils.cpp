#include "../include/utils.h"
#include "../include/ir_wrapper.h"
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <cstring>
#include <algorithm>

using namespace std;

IRWrapper ir_wrapper_2;

void trim_string(string &res){
    int count = 0;
    int idx = 0;
    bool expect_space = false;
    for(int i = 0; i < res.size(); i++){
        if(res[i] == ';' && i != res.size() - 1){
            res[i+1] = '\n';
        }
        if(res[i] == ' '){
            if(expect_space == false){
                continue;
            }else{
                expect_space = false;
                res[idx++] = res[i];
                count ++;
            }
        }else{
            expect_space = true;
            res[idx++] = res[i];
            count ++;
        }
    }

    res.resize(count);
}

string gen_string(){
    return string("x");
}

double gen_float(){
    return 1.2;
}

long gen_long(){
    return 1;
}

int gen_int(){
    return 1;
}


typedef unsigned long uint64_t;

uint64_t fucking_hash ( const void * key, int len )
{
	const uint64_t m = 0xc6a4a7935bd1e995;
	const int r = 47;
	uint64_t h = 0xdeadbeefdeadbeef ^ (len * m);

	const uint64_t * data = (const uint64_t *)key;
	const uint64_t * end = data + (len/8);

	while(data != end)
	{
		uint64_t k = *data++;

		k *= m; 
		k ^= k >> r; 
		k *= m; 
		
		h ^= k;
		h *= m; 
	}

	const unsigned char * data2 = (const unsigned char*)data;

	switch(len & 7)
	{
	case 7: h ^= uint64_t(data2[6]) << 48;
	case 6: h ^= uint64_t(data2[5]) << 40;
	case 5: h ^= uint64_t(data2[4]) << 32;
	case 4: h ^= uint64_t(data2[3]) << 24;
	case 3: h ^= uint64_t(data2[2]) << 16;
	case 2: h ^= uint64_t(data2[1]) << 8;
	case 1: h ^= uint64_t(data2[0]);
	        h *= m;
	};
 
	h ^= h >> r;
	h *= m;
	h ^= h >> r;

	return h;
} 

vector<string> get_all_files_in_dir( const char * dir_name  )
{
        vector<string> file_list;
         if( NULL == dir_name  )
         {
               cout<<" dir_name is null ! "<<endl;
                 return file_list;
                  
         }
          
          struct stat s;
           lstat( dir_name , &s  );
            if( ! S_ISDIR( s.st_mode  )  )
            {
                  cout<<"dir_name is not a valid directory !"<<endl;
                    return file_list;
                     
            }
             
             struct dirent * filename;    // return value for readdir()
               DIR * dir;                   // return value for opendir()
                dir = opendir( dir_name  );
                 if( NULL == dir  )
                 {
                       cout<<"Can not open dir "<<dir_name<<endl;
                         return file_list;
                          
                 }
                  cout<<"Successfully opened the dir !"<<endl;
                   
                   while( ( filename = readdir(dir)  ) != NULL  )
                   {
                         if( strcmp( filename->d_name , "."  ) == 0 || 
                                    strcmp( filename->d_name , ".." ) == 0    )
                                continue;
                           cout<<filename->d_name <<endl;
                                   file_list.push_back(string(filename->d_name));
                                    
                   }
                       return file_list;
                       
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

bool is_str_empty(string input_str) {
  for (int i = 0; i < input_str.size(); i++) {
    char c = input_str[i];
    if (!isspace(c) && c != '\n' && c != '\0')
      return false; // Not empty.
  }
  return true; // Empty
}

// from http://www.cplusplus.com/forum/beginner/114790/
vector<string> string_splitter(const std::string &s, const char delimiter) {

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

Program * parser(string sql){

    yyscan_t scanner;
    YY_BUFFER_STATE state;
    Program * p = new Program();

    if (ff_lex_init(&scanner)) {
        return NULL;
    }
    state = ff__scan_string(sql.c_str(), scanner);

    int ret = ff_parse(p, scanner);

    ff__delete_buffer(state, scanner);
    ff_lex_destroy(scanner);
    if(ret != 0){
        p->deep_delete();
        return NULL;
    }
    
    return p;
}

vector<IR *> run_parser(string input)
{
    vector<IR*> ir_set;
    Program *program = parser(input);

    if (program == NULL) {
        ir_set.clear();
        return ir_set;
    }

    try {
        program->translate(ir_set);
    }
    catch (...) {
        program->deep_delete();
        for (IR* ir : ir_set) {
          ir->drop();
        }
        ir_set.clear();
        return ir_set;
    }
    program->deep_delete();

    /* Set up unique_id */
    int id = 0;
    for (IR* cur_ir : ir_set) {
      cur_ir->uniq_id_in_tree_ = id++;
    }

    return ir_set;

}
