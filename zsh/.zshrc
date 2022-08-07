########################################################
#                      _ _
#  _ __  ___  __ _  __| (_)
# | '_ \/ __|/ _` |/ _` | |
# | |_) \__ \ (_| | (_| | |
# | .__/|___/\__,_|\__,_|_|
# |_|
## Name   : P S, Adithya
## email  : adithya3494@gmail.com
## gitlab : https://github.com/psadi
########################################################

# functions
dotpush(){
	cd /media/tb-vol/workspace/dotfiles
	git add . && git commit -am "$(date "+%Y-%m-%d %H:%M:%S") dotfiles updates" && git push
	cd -
}

lg()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# aliases
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ~="cd ~"

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -la'
alias lrth='ls -lrth'

alias sudo=doas

# z jumparound -  https://github.com/rupa/z
export _Z_DATA=${HOME}/.zsh/z/data
. ${HOME}/.zsh/z/z.sh

# exports

if ! command -v 'bat --version' &> /dev/null # setting bat as default manpager if exists
then
    alias cat='bat -p'
    export MANPAGER='bat'
fi

# history control
alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'


HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# zsh plguins
source "${HOME}/.zsh/_zsh.zsh"

autoload -Uz compinit
zstyle ':completion:*' menu select
#fpath+=~/.zfunc

export LOCAL_DIR=/home/psadi/.local
export EXTMOUNT=/media/tb-vol
export PATH=$LOCAL_DIR/bin:$LOCAL_DIR/opt/node/bin:$HOME/.emacs.d/bin:$HOME/.emacs.d/bin:$PATH

# prompt
eval "$(starship init zsh)"

