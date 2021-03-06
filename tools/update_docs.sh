#!/bin/bash
# Metashell - Interactive C++ template metaprogramming shell
# Copyright (C) 2015, Abel Sinkovics (abel@sinkovics.hu)
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

set -e

METASHELL="app/metashell/metashell"

function process_one {
  SRC_ROOT=".."

  "$1" "$2" \
    | "$SRC_ROOT/tools/replace_part" \
      -i "$SRC_ROOT/$3" \
      -m "$4" \
      -o "$SRC_ROOT/$3" \
      -r -
}

if [ -d cmake ]
then
  mkdir -p bin
  cd bin
    cmake ..
    make

    . ../tools/template/generated_doc.sh
else
  echo "Please run this script from the root directory of the Metashell source code"
fi

