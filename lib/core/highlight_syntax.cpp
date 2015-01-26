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

#include <metashell/data/command.hpp>

#include <metashell/highlight_syntax.hpp>

namespace metashell {

data::colored_string::color_t color_of_token(const data::token& t) {
  switch (t.category())
  {
  case data::token_category::character_literal:
  case data::token_category::floating_literal:
  case data::token_category::integer_literal:
  case data::token_category::string_literal:
  case data::token_category::bool_literal:
  case data::token_category::preprocessor:
    return data::color::magenta;
  case data::token_category::keyword:
    return data::color::bright_green;
  case data::token_category::comment:
    return data::color::green;
  default:
    return boost::none;
  }
}

data::colored_string highlight_syntax(const std::string& str) {
  data::colored_string result;

  const data::command cmd(str);
  for (const data::token& t : cmd) {
    result += data::colored_string(t.value(), color_of_token(t));
  }

  return result;
}

}
