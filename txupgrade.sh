#!/bin/env bash

echo "  ----------------------------  "
echo ">> UPDATING TERMUX (PKG) <<"
echo "  ----------------------------  "
# Update Termux package lists and upgrade all installed packages
pkg update
yes | pkg upgrade

echo "----------------------------"
echo ">> UPDATING LUAROCKS (luacheck) <<"
echo "----------------------------"
# Re-installing is the standard way to update a luarock
luarocks install luacheck

echo "----------------------------"
echo ">> UPDATING GLOBAL NPM PACKAGES <<"
echo "----------------------------"
# Update all globally installed node packages
npm update -g

echo "----------------------------"
echo ">> UPDATING PIP (yamllint) <<"
echo "----------------------------"
# Upgrade the specific python package
pip install --upgrade yamllint

echo "----------------------------"
echo ">> UPDATING GO (hyprls) <<"
echo "----------------------------"
# Re-installing @latest will fetch the newest version
go install github.com/hyprland-community/hyprls/cmd/hyprls@latest

echo "  ----------------------------  "
echo ">> ALL UPDATES COMPLETE. <<"
echo "  ----------------------------  "
