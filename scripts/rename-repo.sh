#!/bin/bash


REPO_NAME=`basename $(git rev-parse --show-toplevel)`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $DIR
find "$DIR/../" -name scripts -prune -o -name .git -prune -o -type f -exec sed -i ''  s/go-project-template/$REPO_NAME/g {} \; -print
