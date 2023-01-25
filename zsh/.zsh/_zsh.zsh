#!/usr/bin/env zsh

# ZSH CONFIG
# ----------
export _ZSH_CONFIG_PATH="${ZSH_DOTFILES_DIR}/.zsh"
export _ZSH_PLUGINS_PATH="${_ZSH_CONFIG_PATH}/plugins"

# ZSH PLUGINS
# -----------

source "${_ZSH_CONFIG_PATH}/zsh-defer/zsh-defer.plugin.zsh"

for z in `ls "${_ZSH_PLUGINS_PATH}"`;
do
	if [ -d "${_ZSH_PLUGINS_PATH}/${z}" ];
	then
		zsh-defer "${_ZSH_PLUGINS_PATH}/${z}/${z}.zsh"
	fi
done

# ZSH FZF
# -------
source "${_ZSH_CONFIG_PATH}/fzf/fzf.zsh"
