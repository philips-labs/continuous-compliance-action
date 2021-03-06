#!/bin/bash
[ -n "$1" ] && GITHUB_TOKEN=$1 || exit 1
[ -n "$2" ] && RULESET=$2 || exit 1 
[ -n "$3" ] && TARGET_REPOS=$3 || exit 0

# Function that checks the target repositories with repolinter
# $1 is the ruleset argument, valid examples here are:
# 1. --rulesetFile /config/ruleset.json
# 2. --rulesetUrl https://gist.github.com/ruleset.json
function check_target_repos {
    echo '### Overview checked repositories' >> $GITHUB_STEP_SUMMARY
    echo '' >> $GITHUB_STEP_SUMMARY
    echo '| Repository | Link |' >> $GITHUB_STEP_SUMMARY
    echo '| ---------- | ---- |' >> $GITHUB_STEP_SUMMARY
    for i in $(echo "$TARGET_REPOS" | sed "s/,/ /g"); do
      export TARGET_REPO=$i
      echo "Checking repository: $i"
      echo "Using ruleset parameter: $1"
      /app/repolinter/bin/repolinter.js lint \
        "$1" \
        -g https://x-access-token:"$GITHUB_TOKEN"@github.com/"${i}"
      echo "| $i | <https://github.com/$i> |" >> $GITHUB_STEP_SUMMARY
    done
    echo '' >> $GITHUB_STEP_SUMMARY
    echo 'Done checking the compliance :rocket: ' >> $GITHUB_STEP_SUMMARY
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
