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

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
echo -ne '\e[1 q'
elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
echo -ne '\e[5 q'
fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
fi
}
bindkey -s '^o' 'lfcd\n'

export KUBECONFIG="$HOME/.kube/config"
export EDITOR=nvim
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval $(thefuck --alias)

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_361.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

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

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
