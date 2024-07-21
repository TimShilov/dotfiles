{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.
  xdg.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    kondo
    mysql84
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    LANG = "en_UK.UTF-8";
    KUBECONFIG = "$HOME/.kube/config";
    USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
  };
  home.sessionPath = [
    "$HOME/.grit/bin"
    "$HOME/.krew/bin"
    "$HOME/.dotnet/tools"
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  programs = {
    eza = { enable = true; enableZshIntegration = true; };

    k9s = {
      enable = true;
      aliases = {
        aliases = {
          dp = "apps/v1/deployments";
          sec = "v1/secrets";
          jo = "batch/v1/jobs";
          cr = "rbac.authorization.k8s.io/v1/clusterroles";
          crb = "rbac.authorization.k8s.io/v1/clusterrolebindings";
          ro = "rbac.authorization.k8s.io/v1/roles";
          rb = "rbac.authorization.k8s.io/v1/rolebindings";
          np = "networking.k8s.io/v1/networkpolicies";
        };
      };
    };

    alacritty = {
      enable = true;
      settings = {
        live_config_reload = true;
        env = {
          TERM = "alacritty-direct";
        };
        window = {
          # blur = true;
          decorations = "buttonless";
          opacity = 1;
          padding = { x = 0; y = 0; };
        };
        font = {
          size = 18;
          normal = {
            family = "JetBrainsMono Nerd Font";
            style = "Regular";
          };
        };
      };
    };
    atuin = {
      enable = true;
      enableZshIntegration = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        filter_mode_shell_up_key_binding = "session";
      };
    };
    bat = { enable = true; };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      defaultOptions = [ "--ansi" "--border rounded" "--reverse" ];
    };
    zoxide = { enable = true; enableZshIntegration = true; };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        format = "$directory$git_branch$git_state$git_status$nix_shell$sudo$cmd_duration$line_break$jobs$battery$character";
        git_branch = {
          format = "[\\($branch(:$remote_branch)\\)]($style) ";
          symbol = " ";
        };
      };
    };

    gh = { enable = true; };
    gh-dash = { enable = true; };
    git = { enable = true; };
    yazi = { enable = true; enableZshIntegration = true; };

    lazygit = {
      enable = true;
      settings = {
        gui.mouseEvents = false;
        customCommands = [
          {
            key = "W";
            prompts = [
              {
                type = "input";
                title = "Commit";
                initialValue = "";
              }
            ];
            command = "git commit -m \"{{index .PromptResponses 0}}\" --no-verify";
            context = "global";
            subprocess = true;
          }
        ];
      };
    };

    ripgrep = { enable = true; };

    tmux = {
      enable = true;
      mouse = true;
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins;
        [
          sensible
          resurrect
          continuum
          vim-tmux-navigator
        ];
      catppuccin = {
        extraConfig = ''
          set -g @catppuccin_icon_window_activity "󱅫"
          set -g @catppuccin_icon_window_bell "󰂞"
          set -g @catppuccin_icon_window_current "null"
          set -g @catppuccin_icon_window_last "null"
          set -g @catppuccin_icon_window_zoom "󰁌 "
          set -g @catppuccin_status_background "default"
          set -g @catppuccin_status_modules_right "null"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_status_enable "yes"
        '';
      };

      extraConfig = ''
        set -g detach-on-destroy off
        set-option -a terminal-overrides ",alacritty:RGB"
        set-option -g status-position top

        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on

        # Open panes in the same directory
        bind '"' split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind-key -n C-f run-shell "sesh connect \"$(
            sesh list | fzf-tmux --ansi -p 55%,60% \
                --no-sort --border-label ' sesh ' --prompt '⚡  ' \
                --header '  ^a all ^t tmux ^x zoxide ^d tmux kill ^f find' \
                --bind 'tab:down,btab:up' \
                --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
                --bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
                --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
                --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
                --bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
        )\""
      '';
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      autocd = true;
      shellAliases = {
        nixswitch = "darwin-rebuild switch --flake ~/.dotfiles/.#";
        nixup = "pushd ~/.dotfiles; nix flake update; nixswitch; popd";

        cat = "bat";
      };
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        share = false;
        save = 10000;
        size = 10000;
      };
      initExtraFirst = ''
        source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
        source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

        source <(kubectl completion zsh)
        . /opt/homebrew/opt/asdf/libexec/asdf.sh
      '';

      initExtra = ''
        function gc() {
            local branches branch
            branches=$(git branch --all | grep -v HEAD) &&
                branch=$(echo "$branches" |
                    fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
                git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
        }

        function sc() {
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

        # tabtab source for packages
        # uninstall by removing these lines
        [[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

        # pnpm
        export PNPM_HOME="$HOME/Library/pnpm"
        case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
        esac
        # pnpm end
      '';
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}

