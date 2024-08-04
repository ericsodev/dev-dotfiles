#!/bin/bash
parent=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent"

# Install or update 
brew install zsh

# Ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# Plugins
brew install zsh-syntax-highlighting fzf zoxide zsh-autosuggestions

# Install zsh syntax highlighting theme
mkdir -p ~/.zsh
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git
cp zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ~/.zsh/
rm -rf zsh-syntax-highlighting

# Install powerlevel10k through oh-my-zsh
# Append powerlevel10k theme to config.
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
cat "$parent/.p10k.zsh" >> ~/.p10k.zsh



# Link configs
ln -s "$parent/.zshrc" ~/.zshrc
