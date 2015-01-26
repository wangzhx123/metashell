// Metashell - Interactive C++ template metaprogramming shell
// Copyright (C) 2015, Abel Sinkovics (abel@sinkovics.hu)
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

#include "mock_cxtranslationunit.hpp"

using namespace metashell;

mock_cxtranslationunit::mock_cxtranslationunit() :
  _get_error([this] (int n_) { return this->_errors[n_]; })
{}

void mock_cxtranslationunit::visit_nodes(const visitor&)
{
  // ignore
}

mock_cxtranslationunit::error_iterator
mock_cxtranslationunit::errors_begin() const
{
  return error_iterator(_get_error, 0);
}

mock_cxtranslationunit::error_iterator
mock_cxtranslationunit::errors_end() const
{
  return error_iterator(_get_error, _errors.size());
}

void mock_cxtranslationunit::code_complete(std::set<std::string>&) const
{
  // ignore
}

void mock_cxtranslationunit::add_error(const std::string& msg_)
{
  _errors.push_back(msg_);
}
