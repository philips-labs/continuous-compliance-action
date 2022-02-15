#!/bin/bash
[ -n "$1" ] && GITHUB_TOKEN=$1 || exit 1
[ -n "$2" ] && RULESET=$2 || exit 1 
[ -n "$3" ] && TARGET_REPOS=$3 || exit 1

# Function that checks the target repositories with repolinter
# $1 is the ruleset argument, valid examples here are:
# 1. --rulesetFile /config/ruleset.json
# 2. --rulesetUrl https://gist.github.com/ruleset.json
function check_target_repos {
    for i in $(echo "$TARGET_REPOS" | sed "s/,/ /g"); do
      export TARGET_REPO=$i
      echo "Checking repository: $i"
      echo "Using ruleset parameter: $1"
      /app/repolinter/bin/repolinter.js lint \
        "$1" \
        -g https://x-access-token:"$GITHUB_TOKEN"@github.com/"${i}"
    done
} 

regex='(https?)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'

if [[ $RULESET =~ $regex ]]
then 
    echo "Link valid"
    check_target_repos "--rulesetUrl ""$RULESET"""
else
    echo "No link, assuming base64 encoded file"
    check_target_repos "-c ""$RULESET"""
fi
