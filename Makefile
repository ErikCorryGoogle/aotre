# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

test:
	dart test.dart

all: aotre.png aotre.o aotre

clean:
	rm -f aotre.png aotre.s aotre.ll aotre.o aotredriver.o aotre

aotre.dot: aotre.dart
	dart aotre.dart -d -e 'a.{2}z$$' > aotre.dot

aotre.png: aotre.dot
	dot -Gdpi=150 -T png -o aotre.png aotre.dot
	#open aotre.png

aotre.ll: aotre.dart
	dart aotre.dart -l -e 'a.{2}z$$' -o aotre.ll

aotre.s: aotre.ll
	clang -O3 -S aotre.ll

aotre.o: aotre.s
	clang -O3 -c aotre.s

aotredriver.o: aotre.cc
	clang++ -O3 -c -o aotredriver.o aotre.cc

aotre: aotre.o aotredriver.o
	clang++ -O3 -o aotre aotre.o aotredriver.o
