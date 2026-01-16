#!/usr/bin/env bash
set -euxo pipefail

export CC="ccache gcc"
export CXX="ccache g++"

mkdir -p output/wine-wow64
mkdir -p build/wine

WINE_OUTPUT=$(realpath -m output/wine-wow64)

cd build/wine
../../wine/configure --prefix="$WINE_OUTPUT" --enable-archs=i386,x86_64 --with-x --with-vulkan
make -j$(nproc)
make install
cd -
