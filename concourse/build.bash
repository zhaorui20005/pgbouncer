#!/bin/bash -l

set -ex

cd pgbouncer_src
git submodule init
git submodule update
./autogen.sh
./configure
make
