# Metashell - Interactive C++ template metaprogramming shell
# Copyright (C) 2013, Abel Sinkovics (abel@sinkovics.hu)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

aux_source_directory(. SOURCES)
add_library(metashell_core_lib STATIC ${SOURCES})

enable_warnings()
use_cpp11()

# mIndent
include_directories(SYSTEM "${CMAKE_SOURCE_DIR}/3rd/mindent/include")

# Just
include_directories(SYSTEM "${CMAKE_SOURCE_DIR}/3rd/just_console/include")
include_directories(SYSTEM "${CMAKE_SOURCE_DIR}/3rd/just_environment/include")
include_directories(SYSTEM "${CMAKE_SOURCE_DIR}/3rd/just_lines/include")
