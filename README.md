# brewp

A simple interactive shell script to manage outdated brew packages.

## Required dependencies 

- [brew](https://brew.sh)
- [gum](https://github.com/charmbracelet/gum)

## Installation

Easiest way to install `brewp` is with this oneliner. You can also just
download `brewp.sh` and place it in desired directory.

```sh
curl -L https://raw.githubusercontent.com/erikjuhani/brewp/main/install.sh | sh
```

By default the install script assumes that executable scripts are found under
`$HOME/bin` folder. The script will automatically create such folder if it does
not exist. However one should remember to add this location to `PATH`.

### Note

`brewp` expects that `brew` and `gum` are installed and found in the `PATH`.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install gum
```