#!/usr/bin/env bash
set -e

DEVSTRAP_BASE_PATH=$HOME/devstrap

DEVSTRAP_MACOS_GIT=https://github.com/reyerstudio/devstrap-macos.git
DEVSTRAP_MACOS_PATH=$DEVSTRAP_BASE_PATH/devstrap-macos
PLAYBOOKS_GIT=$1
PLAYBOOKS_PATH=$DEVSTRAP_BASE_PATH/playbooks
PLAYBOOK=devstrap.yml

if [ -z "$PLAYBOOKS_GIT" ]; then
  echo "Missing Git URL"
  exit -1
fi

# Prepare
mkdir -p $DEVSTRAP_BASE_PATH
rm -rf $DEVSTRAP_MACOS_PATH
rm -rf $PLAYBOOKS_PATH
cd $DEVSTRAP_BASE_PATH

# Clone itself
git clone -q $DEVSTRAP_MACOS_GIT $DEVSTRAP_MACOS_PATH

# Clone playbooks
git clone -q $PLAYBOOKS_GIT $PLAYBOOKS_PATH

# Devstrap with given parameters
cd $DEVSTRAP_MACOS_PATH
export ANSIBLE_NOCOWS=1
export ANSIBLE_ROLES_PATH=$DEVSTRAP_MACOS_PATH/roles
./devstrap.sh -b -p $PLAYBOOKS_PATH/$PLAYBOOK
