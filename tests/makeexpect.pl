#!/usr/bin/perl

# Copyright 2018 Google LLC
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     https://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use strict;
use warnings;
use feature 'unicode_strings';
use open qw(:std :utf8);
use utf8;

my $resrc = `cat $ARGV[0]`;
chomp $resrc;
open my $minfile, $ARGV[1] or die $ARGV[1];
while (my $line = <$minfile>) {
  chomp($line);
  my @captures = $line =~ /$resrc/u;
  if (@captures) {
    print "«$&»\n";
    my $i = 1;
    for my $cap (@captures) {
      if (!defined($cap)) {
        print "$i: «null»\n";
      } else {
        print "$i: «$cap»\n";
      }
      $i++;
    }
  } else {
    print "\n";
  }
}
