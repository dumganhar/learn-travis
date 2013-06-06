#!/bin/bash

# exit this script if any commmand fails
set -e

echo "CI                          = $CI                         "
echo "TRAVIS                      = $TRAVIS                     "
echo "DEBIAN_FRONTEND             = $DEBIAN_FRONTEND            "
echo "HAS_JOSH_K_SEAL_OF_APPROVAL = $HAS_JOSH_K_SEAL_OF_APPROVAL"
echo "USER                        = $USER                       "
echo "HOME                        = $HOME                       "
echo "LANG                        = $LANG                       "
echo "LC_ALL                      = $LC_ALL                     "
echo "RAILS_ENV                   = $RAILS_ENV                  "
echo "RACK_ENV                    = $RACK_ENV                   "
echo "MERB_ENV                    = $MERB_ENV                   "
echo "JRUBY_OPTS                  = $JRUBY_OPTS                 "

echo "TRAVIS_BRANCH          = $TRAVIS_BRANCH          "
echo "TRAVIS_BUILD_DIR       = $TRAVIS_BUILD_DIR       "
echo "TRAVIS_BUILD_ID        = $TRAVIS_BUILD_ID        "
echo "TRAVIS_BUILD_NUMBER    = $TRAVIS_BUILD_NUMBER    "
echo "TRAVIS_COMMIT          = $TRAVIS_COMMIT          "
echo "TRAVIS_COMMIT_RANGE    = $TRAVIS_COMMIT_RANGE    "
echo "TRAVIS_JOB_ID          = $TRAVIS_JOB_ID          "
echo "TRAVIS_JOB_NUMBER      = $TRAVIS_JOB_NUMBER      "
echo "TRAVIS_PULL_REQUEST    = $TRAVIS_PULL_REQUEST    "
echo "TRAVIS_SECURE_ENV_VARS = $TRAVIS_SECURE_ENV_VARS "
echo "TRAVIS_REPO_SLUG       = $TRAVIS_REPO_SLUG       "


