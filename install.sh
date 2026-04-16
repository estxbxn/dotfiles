#!/bin/bash

echo "Installing dotfiles..."

# Install dependencies
echo "Installing packages..."
sudo pacman -S --needed i3-wm polybar kitty rofi picom feh flameshot playerctl zsh ttf-jetbrains-mono-nerd otf-font-awesome bibata-cursor-theme

# Install yay if not present
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay
    cd /tmp/yay && makepkg -si
    cd -
fi

# Install AUR packages
yay -S --needed spotify google-chrome oh-my-zsh-git

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy configs
echo "Copying configs..."
mkdir -p ~/.config
cp -r i3 ~/.config/
cp -r polybar ~/.config/
cp -r kitty ~/.config/
cp -r rofi ~/.config/
cp -r picom ~/.config/
cp -r gtk-3.0 ~/.config/
cp -r gtk-4.0 ~/.config/
cp .zshrc ~/
cp .Xresources ~/

# Set zsh as default shell
chsh -s $(which zsh)

echo "Done! Please relogin to apply all changes."
