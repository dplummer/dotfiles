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
plugins=(git github nyan)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...


alias ssh='nocorrect ssh'
export PATH=/usr/local/bin:$HOME/.rvm/bin:/opt/local/bin:/opt/local/sbin:${PATH}:/usr/local/Cellar/mysql/5.1.54/bin:~/bin:~/.cabal/bin:/opt/java/jre/bin:/opt/ruby-enterprise-1.8.7-2011.03/bin
test -r /sw/bin/init.sh && . /sw/bin/init.sh
export EDITOR=vim
export GIT_EDITOR='vim -f'
export AUTOFEATURE=true
export LDFLAGS=-L/usr/local/lib:$LDFLAGS
function authme {
ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}

unsetopt auto_name_dirs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_HEAP_FREE_MIN=500000
export RUBY_GC_MALLOC_LIMIT=200000000

alias pdf='apvlv'

# Set the display for remote selenium
export DISPLAY=:0
