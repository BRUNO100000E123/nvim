#include <iostream>
#include <regex>
#include <string>

int main(int argc, char* argv[]) {

    std::string text = argv[1];
    std::regex pattern("[a-zA-Z0-9_]*(\\.)?[a-zA-Z0-9_]*$");

    std::smatch match;

    if(std::regex_search(text, match, pattern)){
        std::cout << match[0] << std::endl;
    } else {
        std::cout << "no match" << std::endl;
    }

    return 0;

}
