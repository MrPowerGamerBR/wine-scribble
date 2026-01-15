#!/usr/bin/env bash
set -euxo pipefail

WINE_OUTPUT=$(realpath output/wine32)

mkdir -p output
mkdir -p build/wine32

# Configure & Build Wine 32-bit build
cd build/wine32
../../wine/configure --prefix=$WINE_OUTPUT --with-x --with-vulkan
make -j$(nproc)
cd -

# Install Wine 32-bit
cd build/wine32
echo "Installing Wine 32-bit..."
make install
cd -
