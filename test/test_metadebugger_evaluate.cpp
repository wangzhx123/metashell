// Metashell - Interactive C++ template metaprogramming shell
// Copyright (C) 2014, Andras Kucsma (andras.kucsma@gmail.com)
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#include "metadebugger_test_shell.hpp"

#include <just/test.hpp>

using namespace metashell;

const std::string fibonacci_mp =
  "template <int N> struct fib {"
    "static constexpr int value = fib<N - 2>::value + fib<N - 1>::value;"
  "};"
  "template <> struct fib<0> { static constexpr int value = 0; };"
  "template <> struct fib<1> { static constexpr int value = 1; };"
  "template <int N> struct int_ {};";

#ifndef METASHELL_DISABLE_TEMPLIGHT_TESTS
JUST_TEST_CASE(test_mdb_evaluate_int) {
  metadebugger_test_shell sh = metadebugger_test_shell::create_default();

  sh.line_available("evaluate int");

  JUST_ASSERT_EQUAL(sh.get_output(), "int\n");
}
#endif

#ifndef METASHELL_DISABLE_TEMPLIGHT_TESTS
JUST_TEST_CASE(test_mdb_evaluate_fib_10) {
  metadebugger_test_shell sh =
    metadebugger_test_shell::create_with_environment(fibonacci_mp);

  sh.line_available("evaluate int_<fib<10>::value>");

  JUST_ASSERT_EQUAL(sh.get_output(), "int_<55>\n");
}
#endif