#!/usr/bin/env sh

BREWP_DOWNLOAD_URL="https://raw.githubusercontent.com/erikjuhani/brewp/main/brewp.sh"
HOME_BIN_DIR="$HOME/bin"

# Check if runnning machine is a mac.
# If not end script.
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "Not on a darwin system, terminating"
  exit 1
fi

# Create bin directory under $HOME if it does not exist
if [ ! -d "$HOME_BIN_DIR" ]; then
  mkdir "$HOME_BIN_DIR"
fi

# Download brewp if it does not exist
if [ ! -f "$HOME_BIN_DIR/brewp" ]; then
  curl -L "$BREWP_DOWNLOAD_URL" -o /tmp/brewp
  if  [ $? != 0 ]; then
    echo "error downloading brewp"
    exit 1
  fi 
  mv /tmp/brewp "$HOME_BIN_DIR"
  chmod +x "$HOME_BIN_DIR/brewp"
else 
  echo "brewp already found in $HOME_BIN_DIR folder"
  exit 1
fi
