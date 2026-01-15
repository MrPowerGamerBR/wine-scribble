#!/usr/bin/env bash
set -euxo pipefail

echo "Building Wine32..."
bash build-wine32.sh
echo "Building Wine WoW64..."
bash build-wine-wow64.sh
