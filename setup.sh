#!/bin/bash
parent=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent"

./zsh/setup.sh
./tmux/setup.sh

