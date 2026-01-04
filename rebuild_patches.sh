#!/usr/bin/env
set -euxo pipefail
source scribble_vars.sh

echo "Generating patches..."

cd wine
git format-patch $WINE_COMMIT_HASH --subject-prefix="" --no-numbered -o ../patches