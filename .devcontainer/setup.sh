#!/bin/bash

set -xe

# Completions
pipx install argcomplete
mkdir -p ~/.local/share/bash-completion/completions
echo '. <(register-python-argcomplete pipx)' > ~/.local/share/bash-completion/completions/pipx

# Project
make init
