### Config dir
export XDG_CONFIG_HOME="$HOME/.config"

### ZSH HOME
export ZSH=$HOME/.zsh

### ---- history config -------------------------------------
export HISTFILE=$HOME/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=10000

# How many commands history will save on file.
export SAVEHIST=10000

# Don't save commands starting with a space to history
setopt HIST_IGNORE_SPACE

# History won't save duplicates.
setopt HIST_IGNORE_ALL_DUPS

# History won't show duplicates on search.
setopt HIST_FIND_NO_DUPS

#################
# Other options #
#################

# Auto cd behavior
setopt autocd

setopt MENU_COMPLETE
setopt AUTO_MENU
zmodload -i zsh/complist

# Do menu-driven completion.
zstyle ':completion:*' menu select
# Enable case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
# between quotation marks is the tool output for LS_COLORS
# https://geoff.greer.fm/lscolors/
export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"
# Linux
# LS_COLORS="di=33:ln=32:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
export LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt AUTO_PUSHD           # Push the current directory visited on the stack.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT

export EDITOR=nvim
export VISUAL="$EDITOR"


###########
# Plugins #
###########

# jeffreytse/zsh-vi-mode
function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}
source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# Append a command directly
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# zsh-users/zsh-autosuggestions
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# zsh-users/zsh-syntax-highlighting
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# /trystan2k/zsh-tab-title
source $ZSH/plugins/zsh-tab-title/zsh-tab-title.plugin.zsh

# Disable C-s
stty -ixon

# Node version manager
eval "$(fnm env --use-on-cd)"

export PATH=$HOME/.local/bin/:$PATH

# Aliases
if [ -f ~/.config/aliases ]; then
    source ~/.config/aliases
else
    print "404: ~/.config/aliases not found."
fi

fuzzyGrep() {
  rg --files $1 . | fzf --preview 'bat -n --color=always {}'
}

# Create named note for today inside inbox
function nt() {
  name=${1:-note}  # Use parameter expansion to set a default value
  file=$(touty -t ~/Nextcloud/Notes/inbox -n "$name")  # Capture the output in a variable
  nvim "$file"  # Pass the file directly to nvim
}

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

# Nix

# OSX location
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Linux location
#if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
#  . $HOME/.nix-profile/etc/profile.d/nix.sh; 
#fi # added by Nix installer

# End Nix


# Check for sensitive information in history
eval $(shellclear --init-shell)

eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

###############
# Completions #
###############

# zsh-users/zsh-completions
fpath=($ZSH/plugins/zsh-completions/src $fpath)

# site functions
fpath=($ZSH/site-functions $fpath)

fpath=($ZSH/completions $fpath)

# FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
export PATH="/opt/homebrew:/opt/homebrew/bin:$PATH"

# start zsh completion engine
# Check if the cache file exists and is up-to-date before running compinit
if [[ ! -f ~/.zcompdump || ~/.zcompdump -ot ~/.zshrc ]]; then
  autoload -U compinit; compinit -d ~/.zcompdump
else
  compinit -C
fi

# Use the same colors as `ls` for completions
if [[ -n "${LS_COLORS}" ]]; then
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# Initialize zoxide
eval "$(zoxide init zsh)"

# Wezterm cli path
PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

##############
# Lang paths #
##############

export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
