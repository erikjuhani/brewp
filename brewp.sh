#!/usr/bin/env sh

REQUIRED_DEPENDENCIES=(
  brew
  gum
)

############################
# TRACE AND ERROR HANDLING #
############################

# exit on error
set -o errexit

# exit on <Ctrl-c>
trap 'exit 2' SIGINT

# trace
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Check if runnning machine is a mac.
# If not end script.
if [[ "$OSTYPE" != "darwin"* ]]; then
  echo "Not on a darwin system, terminating"
  exit 1
fi

############################
#           BREWP          #
############################

JQ_BREW_PACKAGE_FILTER='[.formulae[] | [.name,(.installed_versions[0]),("-> "+.current_version)]] | .[] | join(" ")'

# Check that required dependencies are found in $PATH
for dependency in "${REQUIRED_DEPENDENCIES[@]}"
do
  if ! command -v $dependency > /dev/null; then
    echo "required dependency \"${dependency}\" does not exist"
    return 1
  fi
done

selected_for_upgrade="$(gum spin --show-output -- brew outdated --json \
  | jq "$JQ_BREW_PACKAGE_FILTER" -r \
  | gum filter --no-limit)"

if [ ${#selected_for_upgrade[@]} -gt 0 ]; then
  arr=()
  for pkg in "${selected_for_upgrade[@]}"
  do
    arr+=($(echo "${pkg}" | awk '{print $1}'))
  done

  gum join --align=left --vertical "Selected for upgrade" \
    "$(gum style --border=normal --padding="1 2" "$selected_for_upgrade")"

  gum confirm --affirmative="Yes" --negative="No"

  echo "$(HOMEBREW_COLOR=1 HOMEBREW_NO_INSTALL_UPGRADE=1 HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_ENV_HINTS=1 \
    gum spin --show-output --title "Upgrading packages..." -- brew upgrade -q "${arr[@]}")"
fi
