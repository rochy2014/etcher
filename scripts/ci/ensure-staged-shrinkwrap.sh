#!/bin/bash

###
# Copyright 2017 resin.io
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
###

set -e
set -u

echo "node version: $(node --version)"
echo "npm version: $(npm --version)"

SHRINKWRAP_FILE=npm-shrinkwrap.json

npm shrinkwrap --dev

if [[ -n $(git status -s "$SHRINKWRAP_FILE") ]]; then
  echo "There are unstaged $SHRINKWRAP_FILE changes. Please commit the result of:" 1>&2
  echo ""
  echo "    npm shrinkwrap --dev" 1>&2
  echo ""
  git --no-pager diff "$SHRINKWRAP_FILE"
  exit 1
fi
