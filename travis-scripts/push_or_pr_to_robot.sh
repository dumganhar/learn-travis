#!/bin/bash

# exit this script if any commmand fails
set -e

MY_NAME=CocosRobot2
MY_PW=cc1234567890

ELAPSEDSECS=`date +%s`
#Set git user
git config user.email yoursister@gmail.com
git config user.name ${MY_NAME}

git checkout -B master
git remote add upstream https://${MY_NAME}:${MY_PW}@github.com/${MY_NAME}/learn-travis.git 2> /dev/null > /dev/null

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
# It's a Pull Request, so we send a PR to repo of robot
    #git push -fq upstream ${TRAVIS_BRANCH}_${ELAPSEDSECS} 2> /dev/null
    echo "it's a pr"
else
# It's a push or merge, so we push to repo of robot
    git push upstream ${TRAVIS_BRANCH}
    #curl --user "${MY_NAME}:${MY_PW}" --request POST --data "{ \"title\": \"test : test, ${ELAPSEDSECS}\", \"body\": \"\", \"head\": \"dumganhar:${TRAVIS_BRANCH}\", \"base\": \"${TRAVIS_BRANCH}\"}" https://api.github.com/repos/CocosRobot2/learn-travis/pulls
fi
