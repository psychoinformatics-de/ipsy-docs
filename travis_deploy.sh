#!/bin/bash
# use travis-encrypted GitHub token and git user for updating output/
# whenever master branch is updated.

# It assumes that `make html` was performed beforehand and thus output/ is
# up-to-date.

set -x
git --version

# set up git and GitHub access
git config user.name 'AutoBuild'
git config user.email 'blackhole@ipsymd.de'
git config credential.helper "store --file=.git/credentials"
echo "https://${GH_TOKEN}:x-oauth-basic@github.com" > .git/credentials

# switch to branch gh-pages and get the fresh build
git remote set-branches --add origin gh-pages
git fetch origin
git branch -a
git checkout origin/gh-pages
rsync -rv --delete --exclude output/ --exclude .git/ --exclude .gitignore --exclude CNAME --exclude pelican-plugins/ output/ .

# commit new docs folder and push
git add .
git commit -m "Automatically updated GitHub pages"
git push origin HEAD:gh-pages

rm .git/credentials
