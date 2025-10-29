# txconfig

lua and bash config for neovim in termux using kickstart.nvim
take in mind this is experimental

## install

to install you can just copy paste (review the script before installing it, take in mind it calls to another script to get nerd fonts!)

```
pkg update &&
yes | pkg install git &&
git clone https://github.com/dotsilva/txconfig.git &&
chmod +x ~/txconfig/setup.sh &&
./txconfig/setup.sh
```
