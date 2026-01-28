#!/bin/bash
mkdir -p ~/.config

ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
ln -sf ~/dotfiles/fastfetch ~/.config/fastfetch

# macOS only
if [[ "$OSTYPE" == "darwin"* ]]; then
    ln -sf ~/dotfiles/skhd ~/.config/skhd
    ln -sf ~/dotfiles/yabai ~/.config/yabai
fi

echo "Dotfiles installed!"
