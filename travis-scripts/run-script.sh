#!/bin/bash

# exit this script if any commmand fails
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$DIR"/..

if [ $TEST_ON_MAC"aaa" = "YES"aaa ];then
    cd $DIR
    ./push_or_pr_to_robot.sh
else
    cd $PROJECT_ROOT
    $CXX helloworld.cpp -o helloworld
    ./helloworld
fi

