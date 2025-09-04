#! /usr/bin/env bash

set -xe

# win gcc
# GCC="/c/Users/gregor.redelonghi/majstaf/majprogs/mingw64/bin/x86_64-w64-mingw32-gcc-11.1.0.exe"
# ---
# cygwin gcc
GCC=/usr/bin/gcc

# file to build:
CFILE=src/main_ppm.c

# original
# CFILE=src/ORIGINAL_main_ppm.c

# build:
${GCC} -Wall -Wextra -o bin/voronoi-ppm ${CFILE}

# ORIGINAL
# ${GCC} -Wall -Wextra -o voronoi-opengl ${CFILE} -lglfw -lGL -lm

