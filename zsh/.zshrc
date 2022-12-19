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

# evals
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# functions
.p(){
    cd /tb-vol/workspace/dotfiles
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
alias m='micro'
alias nala='sudo nala'
alias reload='source ~/.zshrc'
alias ..='cd ..'
alias ~="cd ~"

alias ls='exa'
alias ll='ls -l'
alias la='ls -la'
alias lrth='ls -l --sort modified'
alias lt="ls --tree"
alias lzd=lazydocker
#alias ee="emacsclient -c -F \"'(fullscreen . fullboth)\" -a \"emacs\""


# history control
alias h='history'
alias hs='history | grep'
alias hsi='history | grep -i'


HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# zsh plguins
source "${HOME}/.zsh/_zsh.zsh"

#autoload -Uz compinit
#zstyle ':completion:*' menu select
#fpath+=~/.zfunc

export LOCAL_DIR=/home/psadi/.local
export OPT_PATH=/opt
export EXTMOUNT=/media/tb-vol
export PATH=$LOCAL_DIR/bin:$HOME/.local/platform-tools:$PATH

# Auto source available languages
if [ -d '/opt/lang' ];then
    for lang in $(ls /opt/lang);
    do
        export PATH=/opt/lang/${lang}/bin:$PATH
	      export LD_LIBRARY_PATH=/opt/lang/$lang/lib:$LD_LIBRARY_PATH
    done

    export PATH
fi

if [ -d "${HOME}/Android" ];then
  export ANDROID_HOME="${HOME}/Android"
  export PATH="${ANDROID_HOME}/Sdk/cmdline-tools/latest/bin:${PATH}"
	export LD_LIBRARY_PATH="${ANDROID_HOME}/Sdk/cmdline-tools/latest/lib:${LD_LIBRARY_PATH}"
fi

if [ -d "/opt/chrome-linux" ]; then
  export CHROME_EXECUTABLE="/opt/chrome-linux/chrome"
  export PATH="/opt/chrome-linux:${PATH}"
fi

# Set aliases and exports based on package availability
if ! command -v 'which bat' &> /dev/null
then
    alias cat='bat -p'
    export MANPAGER='bat'
fi

if ! command -v 'nvim --version' &> /dev/null
then
    alias vim='nvim'
    alias vi='nvim'
fi

#if ! command -v 'which pfetch' &>/dev/null
#then
#    pfetch
#fi

if [ -d "$HOME/.cargo" ]
then
	source "$HOME/.cargo/env"
fi

