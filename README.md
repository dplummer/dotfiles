My dot config files

# NeoVim

[Console nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
[macOS nvim](https://github.com/rogual/neovim-dot-app)

* `brew install neovim/neovim/neovim`
* `brew tap neovim/neovim`
* `brew tap rogual/neovim-dot-app`
* `brew install neovim-dot-app`
* `brew linkapps neovim-dot-app`

(dein package manager)[https://github.com/Shougo/dein.vim]

* `curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh`
* `sh ./installer.sh ~/.config/dein`

config:
* `mkdir ~/.config/nvim && cd ~/.config/nvim && ln -s ~/src/dotfiles/init.vim`
