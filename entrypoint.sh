#!/bin/bash

echo "=====test1"

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --add safe.directory /github/workspace

python3 /usr/bin/feed.py

git add -A  & git commit -m "update feed"

git push --set-upstream origin main

echo "=====test2"
