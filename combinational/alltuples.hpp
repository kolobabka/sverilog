#pragma once
#include <array>
#include <bitset>
#include <iostream>
#include <tuple>

template <typename... Ts> auto make_result(Ts... vs) {
  using T = std::tuple_element_t<0, std::tuple<Ts...>>;
  constexpr auto n = sizeof...(Ts);
  std::array<T, n> a{vs...};
  return std::make_tuple(n, a);
}

template <typename F> void all_tuples(int n, std::ostream &os, F visit) {
  if (n < 2 || n > 31) {
    std::cerr << "Tuples of more than 31-bit not supported (anyway you will "
                 "have too much of those). The same for less than 2 bits\n";
    std::terminate();
  }
  for (int i = 0; i < (1 << n); i++) {
    std::bitset<32> b(i);
    os << b.to_string().substr(32 - n);
    auto [k, arr] = visit(b);
    for (auto i = 0; i < k; ++i)
      os << arr[i].to_string();
    os << "\n";
  }
}