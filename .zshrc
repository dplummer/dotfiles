# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export DEFAULT_USER=dplummer
export ZSH_THEME=agnoster
#export ZSH_THEME="powerlevel9k/powerlevel9k"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git bundler mix)

# To keep tmux window names from changing
# http://superuser.com/questions/306028/tmux-and-zsh-custom-prompt-bug-with-window-name
DISABLE_AUTO_TITLE=true

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
unsetopt correct_all

export AWS_AUTO_SCALING_HOME=/home/dplummer/src/ec2-autoscaling/AutoScaling-1.0.49.1
export PATH=~/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:${PATH}:/usr/local/Cellar/mysql/5.1.54/bin:~/bin:~/.cabal/bin:/opt/java/jre/bin:/opt/ruby-enterprise-1.8.7-2011.03/bin:$AWS_AUTO_SCALING_HOME/bin:/home/dplummer/bin:/opt/android-sdk/tools
test -r /sw/bin/init.sh && . /sw/bin/init.sh
export EDITOR=vim
export GIT_EDITOR='vim -f'
export AUTOFEATURE=true
export LDFLAGS=-L/usr/local/lib
function authme {
ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}
export GOROOT=/usr/local/Cellar/go/1.3.1/libexec

unsetopt auto_name_dirs

export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=200000000

alias pdf='apvlv'

# Set the display for remote selenium
export DISPLAY=:0

export BROWSER=google-chrome
alias make='make -j3'

# tmuxinator!
# [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# fix locale for cucumber
export LC_CTYPE=en_US.UTF-8
export GOPATH=/Users/dplummer
export PATH="$PATH:$GOPATH/bin"
export PATH=$PATH:/usr/local/opt/go/libexec/bin

alias vim-install=rake -f ~/.vim/rakefile-vim-install
alias make='make -j5'

alias rtest='bundle exec ruby -I"lib:test"'
alias retag='/usr/local/bin/ctags -R .'

source ~/.avvo.env
source ~/.secrets.env

export SSL_CERT_FILE=/Library/Java/JavaVirtualMachines/jdk1.8.0_65.jdk/Contents/Home/jre/lib/security/cacerts

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

eval "$(rbenv init -)"

## rbenv-related functions
rb+() { rbenv install $1; }
rb-() { rbenv uninstall $1; }
rbis_() { ruby-build --definitions; }
rbis() { rbis_ | column; }
rbup_() { brew upgrade rbenv 2> /dev/null; brew upgrade ruby-build 2> /dev/null; rbenv -v; ruby-build --version; }
rbup() { rbis_ > rbis0.txt; rbup_; rbis_ > rbis1.txt; gdiff rbis0.txt rbis1.txt; }
rbs() { rbenv -v; ruby-build --version; rbenv versions; echo "CURRENT RUBY: $(ruby -v)"; }
rb0() { rbenv local system; rbs; }
rb2() { rbenv local 2.3.1; rbs; }
rb225() { rbenv local 2.2.5; rbs; }
rb212() { rbenv local 2.1.2; rbs; }
rb2110() { rbenv local 2.1.10; rbs; }
rbe() { rbenv each "$@"; }
rgs() { rbe -v gem list; }
rgo() { rbe -v gem outdated; }
rgu() { rbe -v gem update "$@"; }
rgc() { rbe -v gem cleanup; }

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"

t() {
  if [[ -f mix.exs ]]; then
    /usr/bin/env time mix test "$@"
  else
    if [[ -n $(find spec -type f -name '*_spec.rb' 2> /dev/null) ]]; then
      local cmd='rspec --color' # Rspec
    elif [[ -d 'test' ]]; then
      local cmd='rake test' # minitest
    fi
    [[ -z "${cmd}" ]] && echo -e 'no tests found' && return 1
    LOGGER_LEVEL='debug' RAILS_ENV='test' /usr/bin/env time bundle exec "${cmd} $@"
  fi
}
