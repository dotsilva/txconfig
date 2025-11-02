#!/bin/env bash

#update dotfiles, you can replace the ones in txconfig/dotfiles/ , just remind it must be one file for each filetype, only one .ttf, only one .properties...
cp -r ~/txconfig/dotfiles/*.ttf ~/.termux/font.ttf
cp -r ~/txconfig/dotfiles/*.properties ~/.termux/colors.properties
cp -r ~/txconfig/dotfiles/tmux.conf ~/.tmux.conf
cp -r ~/txconfig/dotfiles/profile ~/.profile
termux-reload-settings
source ~/.profile
