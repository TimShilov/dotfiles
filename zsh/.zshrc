# Uncomment for profiling
# zmodload zsh/zprof

# vim: set filetype=sh :

# Enable colors
autoload -U colors && colors

# History configuration
HISTSIZE=10000
SAVEHIST=10000
LANG=en_UK.UTF-8
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

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
export PATH="$PATH:$HOME/.dotnet/tools"

# Replace default fzf search command with rg if available
export FZF_DEFAULT_COMMAND='rg --files --hidden'

# Aliases
alias cat='bat --paging=never'
alias ld='eza -lD'
alias lf='eza -lf --color=always | grep -v /'
alias lh='eza -dl .* --group-directories-first'
alias ll='eza -al --group-directories-first'
alias ls='eza -alf --color=always --sort=size | grep -v /'
alias lt='eza -al --sort=modified'

# ============ Load zsh plugins ============
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

source <(kubectl completion zsh)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(gh copilot alias -- zsh)"
eval "$(fzf --zsh)"
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Load fzf key bindings
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

gc() {
    local branches branch
    branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" |
            fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

sc() {
    if cat package.json >/dev/null 2>&1; then
        selected_script=$(cat package.json | jq .scripts | sed '1d;$d' | fzf --cycle --height 80% --header="Press ENTER to run the script. ESC to quit.")

        if [[ -n "$selected_script" ]]; then
            script_name=$(echo "$selected_script" | awk -F ': ' '{gsub(/"/, "", $1); print $1}' | awk '{$1=$1};1')

            print -s "npm run "$script_name
            npm run $script_name
        else
            echo "Exit: You haven't selected any script"
        fi
    else
        echo "Error: There's no package.json"
    fi
}

# Uncomment for profiling
# zprof > /tmp/foo

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# Hishtory Config:
export PATH="$PATH:/Users/tim.shilov/.hishtory"
source /Users/tim.shilov/.hishtory/config.zsh
