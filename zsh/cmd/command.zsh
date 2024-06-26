#!/usr/bin/env zsh

if command -v bat &> /dev/null; then
  alias cat="bat -p"
  export MANPAGER="bat"
  export BAT_THEME="Visual Studio Dark+"
  show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
  export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
fi

if command -v k9s &> /dev/null; then
  alias k9s="k9s --logoless --headless --readonly --crumbsless"
fi

if command -v eza &> /dev/null; then
  alias ls="eza --icons=always --no-permissions --no-filesize --no-user --no-quotes --no-time --git"
  alias lt="ls --tree --level=2"
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
else
  alias ls="ls --color=auto"
fi

if command -v zoxide &> /dev/null; then
  alias cd="z"
fi

case "${OSTYPE}" in
  "Linux")
    export NVIM_PACKAGE_NAME="nvim-linux64"
    ;;
  "Darwin")
    export NVIM_PACKAGE_NAME="nvim-macos"
esac

if [ -d "/opt/pkg/${NVIM_PACKAGE_NAME}" ]; then
  export PATH="${PATH}:/opt/pkg/${NVIM_PACKAGE_NAME}/bin"
  export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/opt/pkg/${NVIM_PACKAGE_NAME}/lib"
  export MANPATH="${MANPATH}:/opt/pkg/${NVIM_PACKAGE_NAME}/share/man"
  export EDITOR=nvim
  alias vim="nvim"
fi

if [ -d "${HOME}/go/bin" ];
then
  export PATH="${HOME}/go/bin:${PATH}"
fi;

if [ -f "${HOME}/.cargo/env" ];
then
  . "$HOME/.cargo/env"
fi;
