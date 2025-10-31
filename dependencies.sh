#!/bin/env bash

echo "---------------------------"
echo ">> updating pkg packages <<"
echo "---------------------------"
# Update Termux package lists and upgrade all installed packages
pkg update
yes | pkg upgrade

echo "--------------------------------"
echo ">> updating luarocks packages <<"
echo "--------------------------------"
# Re-installing is the standard way to update a luarock
luarocks install luacheck

echo "---------------------------"
echo ">> updating npm packages <<"
echo "---------------------------"
# Update npm packages by name
npm update -g @fsouza/prettierd bash-language-server \
  markdownlint-cli jsonlint stylelint

echo "---------------------------"
echo ">> updating pip packages <<"
echo "---------------------------"
# Upgrade the specific python package
pip install --upgrade yamllint

echo "--------------------------"
echo ">> updating go packages <<"
echo "--------------------------"
# Re-installing @latest will fetch the newest version
go install github.com/hyprland-community/hyprls/cmd/hyprls@latest

echo "--------------------------"
echo ">> ALL UPDATES COMPLETE <<"
echo "--------------------------"
