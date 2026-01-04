#!/usr/bin/env
set -euxo pipefail
source scribble_vars.sh

echo "Generating patches..."

rm -f patches/*
cd wine
git format-patch $WINE_COMMIT_HASH --subject-prefix="" --zero-commit --no-numbered -o ../patches
