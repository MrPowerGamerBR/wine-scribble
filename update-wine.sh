#!/bin/bash
set -euo pipefail

if [ ! -d "wine" ]; then
  git clone https://github.com/wine-mirror/wine wine
fi

cd wine
git fetch
git reset origin/master
LATEST_COMMIT=$(git rev-parse origin/master)
LATEST_COMMIT_SHORT=$(git rev-parse --short origin/master)
cd ..

echo "Latest commit: $LATEST_COMMIT ($LATEST_COMMIT_SHORT)"

echo "Updating scribble_vars.sh..."
sed -i "s/WINE_COMMIT_HASH=.*/WINE_COMMIT_HASH=$LATEST_COMMIT/" scribble_vars.sh
echo "Updated scribble_vars.sh with commit $LATEST_COMMIT"

if bash update.sh; then
    echo "Patches apply successfully!"

    echo "Extracting Wine version..."
    cd wine
    WINE_VERSION=$(cat VERSION | sed 's/Wine version //')
    cd ..
    echo "Wine version: $WINE_VERSION"

    git add scribble_vars.sh
    COMMIT_MESSAGE="Update Wine ($LATEST_COMMIT_SHORT / $WINE_VERSION)"

    git -c user.name="Loritta Morenitta" -c user.email="47356322+LorittaMorenitta@users.noreply.github.com" commit -m "$COMMIT_MESSAGE" -m "This is an automated commit!"

    if [ -n "${GITHUB_TOKEN:-}" ]; then
        ORIGIN_URL=$(git config --get remote.origin.url | sed 's|https://||')
        git push "https://$GITHUB_TOKEN@$ORIGIN_URL"
    else
        git push
    fi
else
    echo "Patch failure!"
    exit 1
fi
