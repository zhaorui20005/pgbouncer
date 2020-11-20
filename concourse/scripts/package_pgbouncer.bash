#!/bin/bash

set -eox pipefail

pushd pgbouncer_src
VERSION=`git describe --tags`
popd

#TODO: Ubuntu arch should be amd64
#ARCH="x86_64"

tarball_dir=pgbouncer-${GPDB_MAJOR_VERSION}-${VERSION}-${TARGET_OS}-${PLATFORM}-${ARCH}

mkdir -p ${tarball_dir}
pushd ${tarball_dir}
cp -av ../bin_pgbouncer/ ./
cp -av ../pgbouncer_src/COPYRIGHT ./

# Create tarball for GPDB server package
  tar -czf ../component_pgbouncer/pgbouncer-${VERSION}.tar.gz *
popd

