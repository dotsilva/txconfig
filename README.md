# txconfig

thats my script to easily set an environment for using my neovim config in termux
it has support for lua, bash, zig and some other nice to haves for other languages/filetypes as well
you can review (my config)[https://github.com/dotsilva/kickstart.nvim]

## install

to install you can just copy paste

```
pkg update &&
yes | pkg install git &&
git clone https://github.com/dotsilva/txconfig.git &&
chmod +x ~/txconfig/setup.sh &&
./txconfig/setup.sh
```

##updating

to upgrade the dependencies used by this config just run in termux:

```
txupgrade
```

it helps cause since i choose the approach to not trust mason for termux, upgrade the packages
one by one would be a pain
