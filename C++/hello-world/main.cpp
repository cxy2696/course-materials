#include <array>
#include <iostream>
#include <string_view>

int main() {
    constexpr std::array<std::string_view, 6> words{
        "Hello", "C++", "World", "from", "VS Code", "and the C++ extension!"};

    for (std::string_view word : words) {
        std::cout << word << ' ';
    }
    std::cout << '\n';
    return 0;
}
