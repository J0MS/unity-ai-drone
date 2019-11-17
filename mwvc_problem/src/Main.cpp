/*-----------------------------------------<Main.cpp>-----------------------------------------*/
#include <iostream>
#include <sstream>
#include <string>
#include <chrono>
#include <fstream>
#include <unistd.h>
#include <chrono>
#include <unordered_set>
#include "aco.hpp"
#include "clara.hpp"

static const char VERSION[] = "0.1";
bool showHelp = false;
int width = 0;
std::string paramsFile;
bool verbose = false;
bool graphics = false;
std::string command;
int tempIndex = 0;
istream *instance;
ifstream inFile;

int seed = 100;
int n, m, u, v, w;
//cin >> n >> m;

// Check if input data file exist
bool is_file_exist(const char *fileName){
    std::ifstream infile(fileName);
    return infile.good();
}

// Get data, line by line for stdin
void PL(std::istream& is) {
   string line;
    while(is) {
        is >> n >> m;
        if(std::getline(is,line)) {
            // supposed to Parsing string into words and translate//
            //but just reading back input for now//
            //is >> n >> m;
            //cout<<n<< m <<endl;
        }
    }
}


int main(int argc, char **argv){
  using namespace clara;

    //------------------------------------------Configure flags & command line arguments.--------------------------------
    auto arguments = clara::detail::Help(showHelp)
                 | clara::detail::Opt( paramsFile, "config" )["-c"]["--config"]("Load ACO meta-parameters configuration file (specific)")
                 | clara::detail::Opt( verbose )["-v"]["--verbose"]("Verbosity on" )
                 | clara::detail::Opt( graphics, "graphics" )["-g"]["--graphics"]("Output graphics")
                 | clara::detail::Opt( [&]( int i )
                                      {
                                        if (i < 0 || i > 10)
                                            return clara::detail::ParserResult::runtimeError("tempIndex must be between 0 and 10");
                                        else {
                                            tempIndex = i;
                                            return clara::detail::ParserResult::ok( clara::detail::ParseResultType::Matched );
                                        }
                                      }, "tempIndex" ) ["-i"]( "An tempIndex, which is an integer between 0 and 10, inclusive" )
                 | clara::detail::Arg( command, "command" )("which command to run").required();

    auto result = arguments.parse( clara::detail::Args( argc, argv ) );
                 if( !result ){
                 	std::cerr << "Error in command line: " << result.errorMessage() << std::endl;
                 	return 1;
                 }

                 if (showHelp){
             	     std::cerr << arguments << std::endl;
                    return 0;
                 }
                 if (verbose){
             	     verbose=true;
                 }
    //---------------------------------------------End Command line args configuration--------------------------------------

    using namespace std;
    printf("\n");
    printf("%-25s%-25s", " " ,"Ant Colony Optimization Algorithm.\n");
    printf("Version: %s |  \n",VERSION);
    printf("\n");
    printf("Current problem: MWVC\n");

    // TODO: Non operative block -------------------
    // if (is_file_exist(argv[1])) {
    //   inFile.open(argv[1]);
    //   instance = &inFile;
    //   cout << "Succesfully loaded: "<< argv[1] <<endl;
    // }else{
    //   cout << "Fatal error: File does not exist!." <<endl;
    //   return -1;
    // }
    // ----------------------------------------------

    // TODO: Get start time
    // auto gstart = chrono::steady_clock::now();
    cin >> n >> m;
    // ACO object instance and  weight/edge configuration
    ACO aco(n, m);
    for(int i = 0; i < n; i++) {
      cin >> w;
      aco.setWeight(i, w);
    }
    for(; m > 0; m--) {
      cin >> u >> v;
      aco.setEdge(u, v);
    }
    // Random number seed generation
    aco.randomEngineGenerator(seed);
    printf("\nSeed: %d\n", seed);
    // Print candidate solution
    pair<unordered_set<int>, int> currentSolution = aco.getSolution();
    for (int x : currentSolution.first){
      printf("%d, ", x);
    }

    // Print current solution cost
printf("\nCost: %d\n", currentSolution.second);



}

/*-----------------------------------------</Main.cpp>-----------------------------------------*/
