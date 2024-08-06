#include <iostream>
#include <fstream>
#include <bitset>

#include "alltuples.hpp"

int main() {
  std::fstream fsilly("sillyvectors.txt", std::ios::out | std::ios::trunc);
  auto silly = [] (auto bset) {
    unsigned c = bset[0] ? 1 : 0, b = bset[1] ? 1 : 0, a = bset[2] ? 1 : 0;
    auto y = (((~a) & (~b) & (~c)) | (a & (~b) & (~c)) | (a & (~b) & c));
    return y & 1;
  };
  all_tuples(3, fsilly, silly);

  std::fstream fxor4("xor4vectors.txt", std::ios::out | std::ios::trunc);
  auto xor4 = [] (auto bset) {
    unsigned a = bset[0], b = bset[1], c = bset[2], d = bset[3];
    auto y = (a ^ b) ^ (c ^ d);
    return y & 1;
  };
  all_tuples(4, fxor4, xor4);
}