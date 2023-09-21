# Preventing 'command not found: compdef' error
autoload -Uz compinit
compinit

# NGROK shell completionss, add this to your profile:
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

export KUBECONFIG="$HOME/.kube/config"
export EDITOR=nvim
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_361.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Start or attach to tmux by default (if not already inside a tmux session)
if [[ ! $TERM =~ screen ]] && [ -z "$TMUX" ]; then
    SESSION_NAME=$(basename "$PWD" | tr "." "_")
    tmux has-session -t $SESSION_NAME 2>/dev/null

    if [ $? != 0 ]; then
        # No session exists with the current folder name, create one
        tmux new-session -s $SESSION_NAME -d
    fi
    
    # Attach to the session (either existing or newly created)
    tmux attach -t $SESSION_NAME
fi
source <(kubectl completion zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
