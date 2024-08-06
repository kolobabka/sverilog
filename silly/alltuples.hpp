#pragma once
#include <iostream>
#include <bitset>

template <typename F>
void all_tuples(int n, std::ostream &os, F visit) {
  if (n < 2 || n > 31) {
    std::cerr << "Tuples of more than 31-bit not supported (anyway you will have too much of those). The same for less than 2 bits\n";
    std::terminate();
  }
  for (int i = 0; i < (1 << n); i++) {
    std::bitset<32> b(i);
    os << b.to_string().substr(32 - n);
    os << visit(b);
    os << "\n";
  }
}