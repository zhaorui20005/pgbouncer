#!/bin/bash -l

set -ex
export HOME_DIR=$PWD
CWDIR=$HOME_DIR/gpdb_src/concourse/scripts/
source "${CWDIR}/common.bash"

function build_pgbouncer() {
    pushd pgbouncer_src
    git submodule init
    git submodule update
    ./autogen.sh
    ./configure --prefix=${HOME_DIR}/bin_pgbouncer/ --enable-evdns --with-pam --with-openssl
    make install
    popd
}


function _main() {
    build_pgbouncer
	pushd bin_pgbouncer
	tar -czf bin_pgbouncer.tar.gz *
}

_main "$@"
