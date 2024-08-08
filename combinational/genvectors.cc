#include <bitset>
#include <fstream>
#include <iostream>

#include "alltuples.hpp"

template <typename T> auto sillygen(T bset) {
  unsigned c = bset[0], b = bset[1], a = bset[2];
  auto y = (((~a) & (~b) & (~c)) | (a & (~b) & (~c)) | (a & (~b) & c));
  return make_result(std::bitset<1>(y & 1));
};

template <typename T> auto xor4gen(T bset) {
  unsigned a = bset[0], b = bset[1], c = bset[2], d = bset[3];
  auto y = (a ^ b) ^ (c ^ d);
  return make_result(std::bitset<1>(y & 1));
};

template <typename T> auto and8gen(T bset) {
  unsigned a = bset.count();
  unsigned y = (a == 8);
  return make_result(std::bitset<1>(y & 1));
};

template <typename T> auto gatesgen(T bset) {
  auto a = std::bitset<4>(bset.to_ulong() >> 4);
  auto b = std::bitset<4>(bset.to_ulong());
  auto yinv = ~a;
  auto yand = a & b;
  auto yor = a | b;
  auto yxor = a ^ b;
  auto ynand = ~(a & b);
  auto ynor = ~(a | b);
  return make_result(yinv, yand, yor, yxor, ynand, ynor);
};

template <typename F> auto gentry(std::string_view nm, int n, F functor) {
  std::fstream fout(nm.data(), std::ios::out | std::ios::trunc);
  all_tuples(n, fout, functor);
}

int main() {
  gentry("sillyvectors.txt", 3, [](auto bset) { return sillygen(bset); });
  gentry("xor4vectors.txt", 4, [](auto bset) { return xor4gen(bset); });
  gentry("and8vectors.txt", 8, [](auto bset) { return and8gen(bset); });
  gentry("gatevectors.txt", 8, [](auto bset) { return gatesgen(bset); });
}