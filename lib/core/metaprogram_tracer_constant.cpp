// Metashell - Interactive C++ template metaprogramming shell
// Copyright (C) 2016, Abel Sinkovics (abel@sinkovics.hu)
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

#include <metashell/metaprogram_tracer_constant.hpp>

namespace metashell
{
  data::metaprogram
  metaprogram_tracer_constant::eval(iface::environment&,
                                    const boost::filesystem::path&,
                                    const boost::optional<data::cpp_code>&,
                                    data::metaprogram::mode_t,
                                    iface::displayer&)
  {
    return {data::metaprogram::mode_t::normal, data::cpp_code{}, {}, {}};
  }
}
