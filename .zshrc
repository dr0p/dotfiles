# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="3den"

plugins=(git rails ruby rvm tmux tmuxinator)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

source ~/.rvm/scripts/rvm

export TERM="xterm-256color"
setopt RM_STAR_WAIT
setopt interactivecomments

export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR

source ~/.oh-my-zsh/lib/alias.zsh

grepww() { (grep --exclude QUERIES --exclude-dir public --exclude-dir db --exclude-dir test.old --exclude-dir spec --exclude-dir vendor --exclude-dir .git --exclude-dir .bundle --exclude-dir log --exclude-dir tmp --exclude-dir coverage -r -n "$1" .) ; }

grepwwall() { (grep --exclude QUERIES --exclude-dir vendor --exclude-dir .git --exclude-dir .bundle --exclude-dir log --exclude-dir tmp --exclude-dir coverage -r -n "$1" .) ; }

alias wwgrep='grepww'
alias wwgrepa='grepwwall'
alias tmux="TERM=screen-256color-bce tmux"
