#!/usr/bin/env bash
set -e

HELP=
BOOTSTRAP=
PLAYBOOK=
PASS=
DEBUG=
SUCCESS=
SUDOERS_DEVSTRAP="/etc/sudoers.d/devstrap"

trap cleanup EXIT

function cleanup() {
  set +e

  if [ -f "$SUDOERS_DEVSTRAP" ]; then
    sudo rm -f $SUDOERS_DEVSTRAP
  fi

  sudo -k

  if [ -z "$SUCCESS" ]; then
    echo_error "devstrap failed"
    # if [ -z "$DEBUG" ]; then
    #   echo "Run '$0 --debug' for debugging output." >&2
    # fi
  fi
}

# Echo Helpers
###############################################################################
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

function echo_ok() {
  COLOR=$GREEN
  echo -e "${COLOR}$1${NC}"
}

function echo_warn {
  COLOR=$ORANGE
  echo -e "WARNING: ${COLOR}$1${NC}"
}

function echo_error() {
  COLOR=$RED
  echo -e "ERROR: ${COLOR}$1${NC}"
}

# Parse arguments
###############################################################################
function usage() {
  if [ -n "$1" ]; then
    echo_error "$1"
  fi
  echo "Usage: $0  [-h] [-P] [-b] [-p playbook] [-d]"
  echo "  -h, --help      Show help"
  echo "  -P, --pass      Ask password when sudo required"
  echo "  -b, --bootstrap Bootstrap"
  echo "  -p, --playbook  Ansible playbook filename"
  echo "  -d, --debug     Enable debug"
  exit 1
}

while [[ "$#" > 0 ]]; do case $1 in
  -h|--help) HELP=1;shift;;
  -b|--bootstrap) BOOTSTRAP=1;shift;;
  -P|--pass) PASS=1;shift;;
  -p|--playbook) PLAYBOOK=$2;shift;shift;;
  -d|--debug) DEBUG=1;shift;;
  *) usage "Unknown parameter passed: $1"; shift; shift;;
esac; done
if [ ! -z "$HELP" ]; then
  usage
  exit 0
fi
if [ -z "$BOOTSTRAP" ] && [ -z "$PLAYBOOK" ]; then
  usage
  exit -1
fi
if [ ! -z "$DEBUG" ]; then
  set -x
fi

# Sudo management
###############################################################################
if ! sudo -vn &>/dev/null; then
  echo "Enter your password (for sudo access):"
fi
sudo /usr/bin/true
if [ -z "$PASS" ]; then
  sudo sh -c "echo '$(whoami) ALL=(ALL) NOPASSWD: ALL' > ${SUDOERS_DEVSTRAP}"
fi

if [ -n "$BOOTSTRAP" ]; then
  # Install Homebrew
  # HomeBrew takes care to install Xcode Command Line Tools
  ###############################################################################
  HOMEBREW_PREFIX="$(brew --prefix 2>/dev/null || true)"
  [ -n "$HOMEBREW_PREFIX" ] || HOMEBREW_PREFIX="/usr/local"
  if hash brew &> /dev/null; then
    echo_ok "Homebrew already installed"
  else
    echo_warn "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
    export PATH="$HOMEBREW_PREFIX/bin:$PATH"
  fi

  # Install Ansible
  ###############################################################################
  if hash ansible &> /dev/null; then
    echo_ok "Ansible already installed"
  else
    brew install ansible
  fi
fi

# Execute Ansible playbook
###############################################################################
if [ -n "$PLAYBOOK" ]; then
  ansible-playbook --connection=local --inventory localhost, $PLAYBOOK
  SUCCESS="1"
  echo_ok "$PLAYBOOK playbook executed"
else 
  SUCCESS="1"
  echo_ok "Your system is ready for configuration and installation"
fi
