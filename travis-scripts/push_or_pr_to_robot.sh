#!/bin/bash

# exit this script if any commmand fails
set -e

#Set git user
git config --global user.email yoursister@gmail.com
git config --global user.name ${MY_NAME}

git checkout -B master
git remote add upstream https://${MY_NAME}:${MY_PW}@github.com/angeltown/learn-travis.git 2> /dev/null > /dev/null

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
# It's a Pull Request, so we send a PR to repo of robot
    curl --user "${MY_NAME}:${MY_PW}" --request POST --data "{ \"title\": \"Test :${TRAVIS_REPO_SLUG} PR${TRAVIS_PULL_REQUEST}\", \"body\": \"\", \"head\": \"${MY_NAME}:${TRAVIS_BRANCH}\", \"base\": \"${TRAVIS_BRANCH}\"}" https://api.github.com/repos/angeltown/learn-travis/pulls 2> /dev/null > /dev/null

else
# It's a push or merge, so we push to repo of robot
    git push -fq upstream ${TRAVIS_BRANCH} 2> /dev/null
fi
