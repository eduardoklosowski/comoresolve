#!/bin/bash

set -xe
mkdir -p ~/.local/share/bash-completion/completions

# Config pipx
pipx install argcomplete
echo '. <(register-python-argcomplete pipx)' > ~/.local/share/bash-completion/completions/pipx

# Project
make init
