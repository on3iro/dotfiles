###############
# FZF Goodies #
###############


# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-p:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_COMMAND="fd --hidden . $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# Easy git branch checkout
chk() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git switch $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

# Setup fzf
# ---------
if [[ ! "$PATH" == */run/current-system/sw/bin/fzf* ]]; then
  export PATH="${PATH:+${PATH}:}/run/current-system/sw/bin/fzf"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.config/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.config/fzf/key-bindings.zsh"
