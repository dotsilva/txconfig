#!/bin/env bash

echo "  ----------------------------  "
echo ">> PKG UPGRADE && INSTALL <<"
echo "  ----------------------------  "
pkg update
yes | pkg upgrade &&
  yes | pkg install build-essential termux-api which \
    mlocate nodejs-lts openssl lua51 \
    luajit lua-language-server \
    htop wget luarocks stylua \
    cmake ninja clang golang ripgrep fzf curl tmux \
    ncurses-utils python zig zls tree-sitter tree-sitter-lua taplo \
    fastfetch shfmt shellcheck binutils neovim

echo "----------------------------"
echo ">> NERD FONTS AND DOTFILES <<"
echo "----------------------------"
cp -r ~/txconfig/dotfiles/*.ttf ~/.termux/font.ttf
cp -r ~/txconfig/dotfiles/*.properties ~/.termux/colors.properties
cp -r ~/txconfig/dotfiles/tmux.conf ~/.tmux.conf
cp -r ~/txconfig/dotfiles/profile ~/.profile
termux-reload-settings

echo "----------------------------"
echo ">> FLEXING 💪 <<"
echo "----------------------------"
fastfetch
sleep 5

echo "----------------------------"
echo ">> CONFIRMING CLIPBOARD <<"
echo "----------------------------"
command -v termux-clipboard-set

echo "----------------------------"
echo ">> LUAROCKS INSTALL LUACHECK <<"
echo "----------------------------"
luarocks install luacheck

echo "----------------------------"
echo ">> NPM -G INSTALL <<"
echo "----------------------------"
npm install -g @fsouza/prettierd bash-language-server \
  markdownlint-cli jsonlint stylelint

echo "----------------------------"
echo ">> PIP INSTALL <<"
echo "----------------------------"
pip install yamllint

echo "----------------------------"
echo ">> GO: HYPRLS <<"
echo "----------------------------"
go install github.com/hyprland-community/hyprls/cmd/hyprls@latest

echo "----------------------------"
echo ">> INSTALLING MY KICKSTART CONFIG <<"
echo "----------------------------"
# required
mv ~/.config/nvim{,.bak}
# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/dotsilva/kstermux.nvim.git ~/.config/nvim/

echo "----------------------------"
echo ">> PERMISSION TO UPGRADE SCRIPT <<"
echo "----------------------------"
chmod +x ~/txconfig/txupgrade.sh

echo "----------------------------"
echo ">> STARTING NEOVIM IN 5 SECONDS <<"
echo "----------------------------"
sleep 5
nvim
