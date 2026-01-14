#!/usr/bin/env
set -euxo pipefail

source scribble_vars.sh

if [ ! -d "wine" ]; then
  git clone https://github.com/wine-mirror/wine wine
fi

cd wine
git fetch
git reset --hard $WINE_COMMIT_HASH
git am ../patches/*.patch

echo "Patches applied!"
