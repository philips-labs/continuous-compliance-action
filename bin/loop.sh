#!/bin/bash

MAX_TRIGGERS=${2:-5}
TIMEOUT_SECONDS=${3:-86400}

generate_post_data()
{
  cat <<EOF
{
   "ref":"main",
   "inputs" : {
      "repositories_input": "${REPOSITORIES_INPUT%?}"
    }
}
EOF
}

trigger_workflow () {
  REPOSITORIES_INPUT=$1

  # Remove last character.
  echo " Queue to process: ${REPOSITORIES_INPUT%?}"
  # Get Workflow ID by running: curl https://api.github.com/repos/philips-labs/continuous-compliance/actions/workflows

  [ -z "$REPOSITORIES_INPUT" ] && return

  # lint: 14482097
  # lint-badge: 14482096
  curl \
    -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token $GH_TOKEN" \
    https://api.github.com/repos/philips-labs/continuous-compliance/actions/workflows/14482096/dispatches \
    -d "$(generate_post_data)" 
}

repo_previous_check() {
  repo=$(./bin/check-tracked-repo.sh data/checked-repos.txt $1)
  # Timestamp
  echo "$repo" | cut -d' ' -f2
}

add_workflow_in_queue() {
  echo "    - Adding to queue ${1}"
  queue="${1},${queue}"
}

# -------------------------------------------------------------------------------------------------------

[ -n "$1" ] && REPO_LIST=$1 || exit 1

echo "max_triggers: ${MAX_TRIGGERS}"
echo "timeout_seconds: ${TIMEOUT_SECONDS}"

triggers=0
queue=""

echo "- Read 'gh-repos.txt'"
while IFS="" read -r p || [ -n "$p" ]
do
  if [ $(($triggers)) -ge $(($MAX_TRIGGERS)) ]; then
    echo "Enough workflows in queue... let's trigger the workflow"
    break
  fi
  previous_timestamp=$(repo_previous_check "$p")
  if [ -n "$previous_timestamp" ]; then
    need_checking=$(./bin/compare-timeout-times.sh "$TIMEOUT_SECONDS" "$previous_timestamp")
    if [ "$need_checking" == "true" ]; then
      triggers=$((triggers + 1))
      printf '  - %s: triggering: %s - %s is too long ago\n' "$triggers" "$p" "$previous_timestamp"
      add_workflow_in_queue "$p"
    else
      echo "    - already checked $p at $previous_timestamp."
    fi
  else
    echo "    - never checked $p"
    triggers=$((triggers + 1))
    printf '  - %s: triggering: %s\n' "$triggers" "$p"
    add_workflow_in_queue "$p"
  fi
done < "$REPO_LIST"
trigger_workflow "$queue"
