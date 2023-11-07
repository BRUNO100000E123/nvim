#! /usr/bin/bash

# cd .config/nvim/cpp/
rm a.out
g++ regex.cpp
./a.out /home/bruno/.config/nvim/lua/cmp_config.lua
