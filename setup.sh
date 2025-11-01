#!/bin/env bash

echo "--------------------------------"
echo ">> pkg dependencies and tools <<"
echo "--------------------------------"
pkg update
yes | pkg upgrade &&
  yes | pkg install build-essential termux-api which \
    mlocate nodejs-lts openssl lua51 \
    luajit lua-language-server \
    htop wget luarocks stylua marksman cmake ninja clang golang ripgrep fzf curl tmux \
    ncurses-utils python zig zls tree-sitter tree-sitter-lua taplo \
    fastfetch shfmt shellcheck binutils neovim

echo "--------------"
echo ">> dotfiles <<"
echo "--------------"
cp -r ~/txconfig/dotfiles/*.ttf ~/.termux/font.ttf
cp -r ~/txconfig/dotfiles/*.properties ~/.termux/colors.properties
cp -r ~/txconfig/dotfiles/tmux.conf ~/.tmux.conf
cp -r ~/txconfig/dotfiles/profile ~/.profile
termux-reload-settings

echo "----------------"
echo ">> FLEXING 💪 <<"
echo "----------------"
fastfetch
sleep 5

#You need to install Termux:API from f-droid to work
echo "-------------------------------"
echo ">> checking termux clipboard <<"
echo "-------------------------------"
command -v termux-clipboard-set

echo "-----------------------"
echo ">> luarocks packages <<"
echo "-----------------------"
luarocks install luacheck

echo "------------------"
echo ">> npm packages <<"
echo "------------------"
npm install -g @fsouza/prettierd bash-language-server \
  jsonlint stylelint

echo "------------------"
echo ">> pip packages <<"
echo "------------------"
pip install yamllint

echo "-----------------"
echo ">> go packages <<"
echo "-----------------"
go install github.com/hyprland-community/hyprls/cmd/hyprls@latest

echo "-----------------------------"
echo ">> git cloning nvim config <<"
echo "-----------------------------"
# required
mv ~/.config/nvim{,.bak}
# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/dotsilva/kstermux.nvim.git ~/.config/nvim/

echo "----------------------------------------------"
echo ">> giving permission to maintenance scripts <<"
echo "----------------------------------------------"
chmod +x ~/txconfig/dependencies.sh
chmod +x ~/txconfig/dotfiles.sh

source .profile
