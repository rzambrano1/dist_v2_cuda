#include <iostream>
#include <typeinfo>

int main_aux() {
    // Just a few lines of code to check my understanding of what is going on

    float i = 42;
    float* ptr = &i;

    //float* d_in = &i;
    float* d_in = 0;
    float* d_out = 0;

    if (!d_in) {
        std::cout << "d_in is null" << std::endl;
    }
    else {
        std::cout << "d_in is not null" << std::endl;
    }

    if (!d_out) {
        std::cout << "d_out is null" << std::endl;
    }
    else {
        std::cout << "d_out is not null" << std::endl;
    }

    std::cout << &d_in << std::endl;
    std::cout << &d_out << std::endl;

    int j = (float)i;

    std::cout << typeid(j).name() << std::endl;

    *ptr = 24;
    std::cout << i << std::endl;

    return 0;
}