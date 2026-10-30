#!/bin/bash

grep ^work, data_lua_51.csv > data_lua_51_work.csv
grep ^empty, data_lua_51.csv > data_lua_51_empty.csv
grep ^work, data_lua_54.csv > data_lua_54_work.csv
grep ^empty, data_lua_54.csv > data_lua_54_empty.csv
grep ^work, data_lua_55.csv > data_lua_55_work.csv
grep ^empty, data_lua_55.csv > data_lua_55_empty.csv

gnuplot --persist -e "
  set datafile separator ',';
  set title 'Capture vs Standard Performance Lua 5.1';
  plot 'data_lua_51_empty.csv' using 2:3 with lp title 'Standard',
       'data_lua_51_empty.csv' using 2:4 with lp title 'Capture';
"

gnuplot --persist -e "
  set datafile separator ',';
  set title 'Capture vs Standard Performance Lua 5.5';
  plot 'data_lua_55_empty.csv' using 2:3 with lp title 'Standard',
       'data_lua_55_empty.csv' using 2:4 with lp title 'Capture';
"

gnuplot --persist -e "
  set datafile separator ',';
  set title 'Standard Performance Among Lua Version';
  plot 'data_lua_51_empty.csv' using 2:3 with lp title 'Lua 5.1',
       'data_lua_54_empty.csv' using 2:3 with lp title 'Lua 5.4',
       'data_lua_55_empty.csv' using 2:3 with lp title 'Lua 5.5';
"


gnuplot --persist -e "
  set datafile separator ',';
  set title 'Standard Performance in Lua 5.1 vs Capture Performance in Lua 5.5';
  plot 'data_lua_51_empty.csv' using 2:3 with lp title 'Lua 5.1',
       'data_lua_55_empty.csv' using 2:4 with lp title 'Lua 5.5';
"
