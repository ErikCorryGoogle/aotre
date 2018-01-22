// Copyright 2018 Google Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//    https://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

struct AotreState {
  char* start_of_string;
  // TODO: We need to handle the correct sizing of this.
  int captures_and_registers[32];
};

extern "C" int aotre(AotreState* state, const char* s);

int main(int argc, const char* const* argv) {
  AotreState state;
  while (--argc) {
    const char* fn = *++argv;
    std::ifstream input(fn);
    std::string line;
    while (std::getline(input, line)) {
      if (aotre(&state, line.c_str())) {
        std::cout << line << "\n";
      }
    }
  }
  return 0;
}
