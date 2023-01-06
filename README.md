# brewp

A simple interactive shell script to manage outdated brew packages.

<img alt="Running brewp shell script" width="600" src="https://raw.githubusercontent.com/erikjuhani/brewp/main/demo.gif">

## Required dependencies 

- [brew](https://brew.sh)
- [gum](https://github.com/charmbracelet/gum)

## Installation

Easiest way to install `brewp` is with this oneliner. You can also just
download `brewp.sh` and place it in desired directory.

```sh
curl -sSL https://raw.githubusercontent.com/erikjuhani/brewp/main/install.sh | sh
```

By default the install script assumes that executable scripts are found under
`$HOME/bin` folder. The script will automatically create such folder if it does
not exist. However one should remember to add this location to `PATH`.

### Updating

`brewp` keeps track of HEAD commit hash as the version, which is annotated to
the `brewp` shell script file. To update `brewp` to latest version run the
install script again.

### Note

`brewp` expects that `brew` and `gum` are installed and found in the `PATH`.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install gum
```
