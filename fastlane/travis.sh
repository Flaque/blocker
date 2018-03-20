#! /bin/sh

if [[ $TRAVIS_COMMIT_MESSAGE == *"[fastlane deploy beta]"* ]]; then
  ./fastlane/setupGit.sh
  bundle exec fastlane beta
  exit $?
elif [[ $TRAVIS_COMMIT_MESSAGE == *"[fastlane deploy release]"* ]]; then
  ./fastlane/setupGit.sh
  bundle exec fastlane release
  exit $?
elif [[ $TRAVIS_COMMIT_MESSAGE == *"[fastlane capture screenshots]"*  ]]; then
  bundle exec fastlane screenshots
  exit $?
elif [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
    bundle exec fastlane test
    exit $?
else
  bundle exec fastlane test
  exit $?
fi
