#!/usr/bin/env bash
set -euxo pipefail

# A WOW64 build MUST BE ON THE SAME PREFIX
# As in: To build WOW64, you build Wine32 and Wine64 and install it "on top" of each other
WINE_OUTPUT=$(realpath output/wine-wow64)

mkdir -p output
mkdir -p build/wine-wow64
mkdir -p build/wine32

# Configure & Build Wine WOW64 build
cd build/wine-wow64
../../wine/configure --prefix=$WINE_OUTPUT --enable-win64 --with-x --with-vulkan
make -j$(nproc)
cd -

# Configure & Build Wine 32-bit build
cd build/wine32
../../wine/configure --prefix=$WINE_OUTPUT --with-wine64=../wine-wow64 --with-x --with-vulkan
make -j$(nproc)
cd -

# Install Wine 32-bit FIRST
cd build/wine32
echo "Installing Wine 32-bit..."
make install
cd -

# Install Wine WOW64 ON TOP
cd build/wine-wow64
echo "Installing Wine WOW64..."
make install
cd -
