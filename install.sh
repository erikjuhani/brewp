#!/usr/bin/env sh

BREWP_DOWNLOAD_URL="https://raw.githubusercontent.com/erikjuhani/brewp/main/brewp.sh"
BREWP_LATEST_COMMIT_URL="https://github.com/erikjuhani/brewp/commit/HEAD.patch"
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

function download_brewp() {
  curl -sSL "$BREWP_DOWNLOAD_URL" -o /tmp/brewp
  if  [ $? != 0 ]; then
    echo "error downloading brewp"
    exit 1
  fi 
  mv -f /tmp/brewp "$HOME_BIN_DIR"
  chmod +x "$HOME_BIN_DIR/brewp"
}

function annotate_version() {
  HEAD_SHA_THEIRS="${2:-$(awk 'NR==1{ print substr($2,0,7); }' $1)}"
  echo "# @annotated_version $HEAD_SHA_THEIRS" >> "$HOME_BIN_DIR/brewp"
}

# Download brewp if it does not exist
if [ ! -f "$HOME_BIN_DIR/brewp" ]; then
  echo "Installing \`brewp\` to $HOME_BIN_DIR"
  download_brewp
  curl -sSL "$BREWP_LATEST_COMMIT_URL" -o /tmp/brewp_head
  annotate_version /tmp/brewp_head
else 
  curl -sSL "$BREWP_LATEST_COMMIT_URL" -o /tmp/brewp_head

  HEAD_SHA_THEIRS=$(awk 'NR==1{ print substr($2,0,7); }' /tmp/brewp_head)
  HEAD_SHA_OURS=$(tail -n 1 "$HOME_BIN_DIR/brewp" | awk '{ print $3; }')

  if [ "$HEAD_SHA_THEIRS" != "$HEAD_SHA_OURS" ]; then
    echo "\`brewp\` is outdated"
    echo "Updating \`brewp\` $HEAD_SHA_OURS -> $HEAD_SHA_THEIRS"
    download_brewp
    annotate_version /tmp/brewp_head $HEAD_SHA_THEIRS
    echo "Updated \`brewp\` to latest version $HEAD_SHA_THEIRS"
    exit 0
  fi

  echo "brewp already found in $HOME_BIN_DIR folder and version "$HEAD_SHA_OURS" is up to date"
  exit 1
fi
