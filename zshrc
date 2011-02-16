# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="mrtazz"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew github rails ruby)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:$HOME/.rvm/bin:/opt/local/bin:/opt/local/sbin:${PATH}:/usr/local/mysql/bin:~/bin
test -r /sw/bin/init.sh && . /sw/bin/init.sh
export EDITOR=vim
export GIT_EDITOR='mate -wl1'
export AUTOFEATURE=true
export LDFLAGS=-L/usr/local/lib:$LDFLAGS
function authme {
ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
