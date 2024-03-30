# Uncomment for profiling
# zmodload zsh/zprof

# Enable colors
autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
LANG=en_US.UTF-8

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Navigate directories without cd
setopt autocd

export KUBECONFIG="$HOME/.kube/config"
export EDITOR=nvim
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"
export GRIT_INSTALL="$HOME/.grit"
export PATH="$GRIT_INSTALL/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# Replace default fzf search command with rg if available
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# ============ Load zsh plugins ============
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# Better vi mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source <(kubectl completion zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(gh copilot alias -- zsh)"
eval "$(fzf --zsh)"
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Load fzf key bindings
function zvm_after_init() {
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

# Uncomment for profiling
# zprof > /tmp/foo
