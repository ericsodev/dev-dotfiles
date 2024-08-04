#!/bin/bash
brew install tmux

parent=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent"

ln -s ".tmux.conf" ~/.tmux.conf
