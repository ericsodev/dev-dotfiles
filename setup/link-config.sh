# Link dotfiles 
base=$(dirname "$0")
mkdir -p ~/.config/fastfetch/
echo $base
cp $base/fastfetch/config.jsonc ~/.config/fastfetch/


# Neovim dotfiles
