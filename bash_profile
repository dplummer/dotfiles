export PATH=/usr/local/bin:$HOME/.rvm/bin:/opt/local/bin:/opt/local/sbin:${PATH}:/usr/local/mysql/bin:~/bin
test -r /sw/bin/init.sh && . /sw/bin/init.sh
export EDITOR=vim
export GIT_EDITOR='mate -wl1'
export AUTOFEATURE=true
export LDFLAGS=-L/usr/local/lib:$LDFLAGS
function authme {
ssh $1 'cat >>.ssh/authorized_keys2' <~/.ssh/id_rsa.pub
}
function randpass {
openssl rand -base64 12
}
function sc {
./script/console
}
function ss {
./script/server
}
function rdm {
rake db:migrate
}
##
# Your previous /Users/donald/.bash_profile file was backed up as /Users/donald/.bash_profile.macports-saved_2010-03-25_at_14:35:34
##

# MacPorts Installer addition on 2010-03-25_at_14:35:34: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# Colors
export COLOR_NC='\033[0m' # No Color
export COLOR_WHITE='\033[1;37m'
export COLOR_BLACK='\033[0;30m'
export COLOR_BLUE='\033[0;34m'
export COLOR_LIGHT_BLUE='\033[1;34m'
export COLOR_GREEN='\033[0;32m'
export COLOR_LIGHT_GREEN='\033[1;32m'
export COLOR_CYAN='\033[0;36m'
export COLOR_LIGHT_CYAN='\033[1;36m'
export COLOR_RED='\033[0;31m'
export COLOR_LIGHT_RED='\033[1;31m'
export COLOR_PURPLE='\033[0;35m'
export COLOR_LIGHT_PURPLE='\033[1;35m'
export COLOR_BROWN='\033[0;33m'
export COLOR_YELLOW='\033[1;33m'
export COLOR_GRAY='\033[1;30m'
export COLOR_LIGHT_GRAY='\033[0;37m'

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

PS1="\[${COLOR_CYAN}\]\w/ $COLOR_BROWN\$(parse_git_branch)\[${COLOR_CYAN}\]>\[${COLOR_NC}\] "


[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

# Append to the history file, don't overwrite it!
shopt -s histappend
HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Load git completion
. ~/.git_completion
