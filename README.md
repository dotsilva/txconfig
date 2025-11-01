# txconfig

thats my script to easily set an environment for using my neovim config in termux;
it has support for lua, bash, zig and some other nice to haves for other languages/filetypes as well;
you can review [my config](https://github.com/dotsilva/kstermux.nvim);

## install

to install you can just copy paste

```
pkg update &&
yes | pkg install git &&
git clone https://github.com/dotsilva/txconfig.git &&
chmod +x ~/txconfig/setup.sh &&
./txconfig/setup.sh
```

#updates

to update dependencies used by this config just run in termux:

```
txdeps
```

you can also fork this repo so you can have better management;
you can change dotfiles in the repo and apply by running:

```
txdots
```

to easily setup git with ssh:

```
txgit
```
