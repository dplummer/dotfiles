# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export DEFAULT_USER=donaldp
export ZSH_THEME=agnoster
#export ZSH_THEME=dplummer

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git bundler mix zsh-autosuggestions)

# To keep tmux window names from changing
# http://superuser.com/questions/306028/tmux-and-zsh-custom-prompt-bug-with-window-name
DISABLE_AUTO_TITLE=true

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
unsetopt correct_all

export PATH=~/bin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:${PATH}
test -r /sw/bin/init.sh && . /sw/bin/init.sh
export EDITOR=vim
export GIT_EDITOR='vim -f'
export AUTOFEATURE=true
export LDFLAGS=-L/usr/local/lib
function authme {
ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_rsa.pub
}
unsetopt auto_name_dirs

export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=200000000

alias pdf='apvlv'

# Set the display for remote selenium
export DISPLAY=:0

export BROWSER=google-chrome
alias make='make -j5'

alias rg='rg --color always'

# tmuxinator!
# [[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# fix locale for cucumber
export LC_CTYPE=en_US.UTF-8
export GOPATH=/Users/donaldp
export PATH="$PATH:$GOPATH/bin"
export PATH=$PATH:/usr/local/opt/go/libexec/bin

alias vim-install=rake -f ~/.vim/rakefile-vim-install
alias make='make -j5'

alias rtest='bundle exec ruby -I"lib:test"'
alias retag='/usr/local/bin/ctags -R .'

source ~/.secrets.env

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#. $HOME/.asdf/asdf.sh
#. $HOME/.asdf/completions/asdf.bash

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

export PATH="$HOME/.bin:$PATH"

source ~/ls_colors.zsh

libs=( \
  'gettext' \
  'icu4c' \
  'imagemagick@6' \
  'libxml2' \
  'mysql@5.6' \
  'openssl' \
  'qt' \
  'readline' \
)
for lib in ${libs[@]}; do
  # libpath="$(brew --prefix ${lib})"
  libpath="/usr/local/opt/${lib}" # faster than `brew --prefix`
  # headers
  export C_INCLUDE_PATH="${C_INCLUDE_PATH}:${libpath}/include"
  export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:${libpath}/include"
  export OBJC_INCLUDE_PATH="${OBJC_INCLUDE_PATH}:${libpath}/include"
  export OBJCPLUS_INCLUDE_PATH="${OBJCPLUS_INCLUDE_PATH}:${libpath}/include"
  # linkables
  export LDFLAGS="${LDFLAGS} -L${libpath}/lib"
  # packages
  export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${libpath}/lib/pkgconfig"
  # executables
  export PATH="${PATH}:${libpath}/bin"
done

mrm () { rm -rf deps/ _build/ tarballs/ "$@"; }

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/donaldp/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/donaldp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/donaldp/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/donaldp/google-cloud-sdk/completion.zsh.inc'; fi
