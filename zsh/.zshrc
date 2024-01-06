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


export KUBECONFIG="$HOME/.kube/config"
export EDITOR=nvim
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_361.jdk/Contents/Home
# export PATH="$JAVA_HOME/bin:$PATH"

source <(kubectl completion zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Uncomment for profiling
# zprof > /tmp/foo
