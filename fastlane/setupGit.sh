#!/bin/sh

setup_git() {
  echo "Setting git user.email to support@tempo.team"
  git config --global user.email "hello@rudybermudez.io"
  echo "Setting git user.name to Tempo CI Bot"
  git config --global user.name "Blocker CI Bot"
}

setup_git
