#!/bin/bash
set -e
#env
apt install -y git httpie curl
DATA="$(printf '{"tag_name":"v%s",' $PR_VERSION)"
DATA="${DATA} $(printf '"target_commitish":"master",')"
DATA="${DATA} $(printf '"name":"v%s",' $PR_VERSION)"
DATA="${DATA} $(printf '"body":"Automated release based on keyword: %s",' "$*")"
DATA="${DATA} $(printf '"draft":false, "prerelease":false}')"
URL="https://api.github.com/repos/${GITHUB_REPOSITORY}/releases?access_token=${GITHUB_TOKEN}"
echo $DATA | http POST $URL
