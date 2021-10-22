#!/bin/bash

[ -n "$1" ] && TRACKED_REPO_LIST=$1 || [ -r "$2" ] && REPO=$2 || exit 1

while IFS="" read -r p || [ -n "$p" ]
do
  REPO_FOUND=( $p )
    if [ "${REPO_FOUND}" = "${REPO}" ]; then
        echo $p
        break
    fi
done < "$TRACKED_REPO_LIST"
