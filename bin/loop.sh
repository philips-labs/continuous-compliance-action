#!/bin/bash
[ -n "$1" ] && GITHUB_TOKEN=$1 || exit 1
[ -n "$2" ] && RULESET_FILE_URL=$2 || exit 1 
[ -n "$3" ] && TARGET_REPOS=$3 || exit 1

for i in $(echo "$TARGET_REPOS" | sed "s/,/ /g"); do
  export TARGET_REPO=$i
  echo " checking: $i"
  /app/repolinter/bin/repolinter.js lint \
    --rulesetUrl "$RULESET_FILE_URL" \
    -g https://x-access-token:"$GITHUB_TOKEN"@github.com/"${i}"
done
