#!/bin/bash -l

set -ex

export HOME_DIR=$PWD
CWDIR=$HOME_DIR/gpdb_src/concourse/scripts/
source "${CWDIR}/common.bash"

function setup_gpdb_cluster() {
    export TEST_OS=centos
    export PGPORT=15432
    export CONFIGURE_FLAGS=" --with-openssl"

   # time install_gpdb
    time configure
    cd gpdb_src
    time make -j4 install
    cd ../
    time ./gpdb_src/concourse/scripts/setup_gpadmin_user.bash "$TEST_OS"
    time make_cluster
    . /usr/local/greenplum-db-devel/greenplum_path.sh
    . gpdb_src/gpAux/gpdemo/gpdemo-env.sh
}

function _main(){
    setup_gpdb_cluster
    echo "gpadmin ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
    chown -R gpadmin:gpadmin pgbouncer_src
    cd pgbouncer_src/test
    sudo -u gpadmin -E ./test.sh
    cd ssl
    sudo -u gpadmin -E ./gpdb6-test.sh
}

_main "$@"
