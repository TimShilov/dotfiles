{
  config,
  pkgs,
  lib,
  ...
}:
let
  nerdFontWindowNamePlugin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-nerd-font-window-name";
    version = "v2.1.2";
    rtpFilePath = "tmux-nerd-font-window-name.tmux";
    src = pkgs.fetchFromGitHub {
      owner = "joshmedeski";
      repo = "tmux-nerd-font-window-name";
      rev = "2f5131f01b6cc052069211f6dce02c3fec564da2";
      sha256 = "sha256-bnlOAfdBv5Rg4z1hu1jtdx5oZ6kAZE40K4zqLxmyYQE=";
    };
  };
in
{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  xdg = {
    enable = true;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ast-grep
    atac
    calcurse
    fswatch
    gnupg
    go
    grizzly
    kondo
    luarocks
    mysql84
    nixfmt-rfc-style
    rainfrog # Database management TUI
    sleek
    sshs
    taskwarrior-tui
    watchexec
    yq-go
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
    "./config/borders/bordersrc" = {
      source = dotfiles/bordersrc;
    };
    ".aerospace.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink /Users/tim.shilov/dotfiles/modules/home-manager/dotfiles/.aerospace.toml;
    };
    ".asdfrc" = {
      source = dotfiles/.asdfrc;
    };
    # TODO: Find a way to make this work with relative path
    ".config/nvim/" = {
      source = config.lib.file.mkOutOfStoreSymlink /Users/tim.shilov/dotfiles/modules/home-manager/dotfiles/nvim;
      recursive = true;
    };
    ".config/karabiner/karabiner.json" = {
      source = dotfiles/karabiner/karabiner.json;
    };
    ".config/sesh/" = {
      source = dotfiles/sesh;
      recursive = true;
    };
    ".config/sketchybar/" = {
      source = config.lib.file.mkOutOfStoreSymlink /Users/tim.shilov/dotfiles/modules/home-manager/dotfiles/sketchybar;
      recursive = true;
    };
    ".config/skhd/" = {
      enable = false;
      source = dotfiles/skhd;
      recursive = true;
    };
    ".gitconfig" = {
      source = config.lib.file.mkOutOfStoreSymlink /Users/tim.shilov/dotfiles/modules/home-manager/dotfiles/.gitconfig;
    };
    ".ideavimrc" = {
      source = dotfiles/.ideavimrc;
    };
    ".jqp.yaml" = {
      source = dotfiles/.jqp.yaml;
    };
    # TODO: Find a way to make this work with relative path
    ".ssh/config" = {
      source = config.lib.file.mkOutOfStoreSymlink /Users/tim.shilov/dotfiles/modules/home-manager/dotfiles/ssh/config;
    };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    PAGER = "less";
    LANG = "en_GB.UTF-8";
    KUBECONFIG = "$HOME/.kube/config";
    USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
    HOMEBREW_NO_ANALYTICS = 1;
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
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    k9s = {
      enable = true;
      settings = {
        k9s = {
          liveViewAutoRefresh = true;
          skipLatestRevCheck = false;
          logger = {
            textWrap = true;
            sinceSeconds = 300;
            buffer = 5000;
          };
          ui = {
            crumbsless = true;
            logoless = true;
            reactive = true;
            noIcons = false;
          };
        };
      };
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

    wezterm = {
      enable = true;
      enableZshIntegration = true;
      extraConfig = (builtins.readFile ./configs/wezterm.lua);
    };

    atuin = {
      enable = true;
      enableZshIntegration = true;
      flags = [ "--disable-up-arrow" ];
      settings = {
        filter_mode_shell_up_key_binding = "session";
      };
    };
    bat = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      defaultOptions = [
        "--ansi"
        "--border rounded"
        "--reverse"
      ];
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    starship = {
      enable = false;
      enableZshIntegration = true;
      settings = {
        format = "$directory$git_branch$git_state$git_status$nix_shell$sudo$line_break$jobs$battery$character";
        right_format = "$cmd_duration";
        character = {
          success_symbol = "[>](bold green)";
          error_symbol = "[x](bold red)";
        };
        git_branch = {
          format = "[\\($branch(:$remote_branch)\\)]($style) ";
          symbol = " ";
        };
      };
    };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (
        builtins.unsafeDiscardStringContext (builtins.readFile ./configs/oh-my-posh.toml)
      );
    };

    gh = {
      enable = true;
    };
    gh-dash = {
      enable = true;
      catppuccin.enable = true;
    };
    git = {
      enable = true;
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };

    lazygit = {
      enable = true;
      settings = {
        promptToReturnFromSubprocess = false;

        customCommands = [
          {
            key = "X";
            prompts = [
              {
                type = "input";
                title = "Commit";
                initialValue = "";
              }
            ];
            command = # bash
              ''git commit -m "{{index .PromptResponses 0}}" --no-verify'';
            context = "global";
            subprocess = true;
          }
        ];

        gui = {
          showFileTree = false;
          mouseEvents = false;
          nerdFontsVersion = "3";
          filterMode = "fuzzy";
        };
      };
    };

    ripgrep = {
      enable = true;
    };

    tmux = {
      enable = true;
      mouse = true;
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        tmux-floax
        nerdFontWindowNamePlugin
        sensible
        resurrect
        continuum
        vim-tmux-navigator
      ];
      terminal = "wezterm";
      catppuccin = {
        extraConfig = # bash
          ''
            set -g @catppuccin_status_background "none"
            # TODO: Make sure that all the options are correct as they were changed in 2.0.0 (@see https://github.com/catppuccin/tmux/blob/main/docs/reference/configuration.md)
            set -g @catppuccin_status_modules_right "session"

            set -g @catppuccin_window_current_text " #W"
            set -g @catppuccin_window_flags "icon"
            set -g @catppuccin_window_flags_icon_activity "󱅫"
            set -g @catppuccin_window_flags_icon_bell "󰂞"
            set -g @catppuccin_window_flags_icon_current ""
            set -g @catppuccin_window_flags_icon_last ""
            set -g @catppuccin_window_flags_icon_zoom "󰁌 "
            set -g @catppuccin_window_text " #W"

            set -g status-right "#{E:@catppuccin_status_session}"
          '';
      };

      extraConfig = (builtins.readFile ./configs/tmux.conf);
    };

    taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      sessionVariables = {
        LANG = "en_GB.UTF-8";
      };
      shellAliases = {
        nixswitch = "darwin-rebuild switch --flake ~/dotfiles/.#";
        nixup = "pushd ~/dotfiles; nix flake update; nixswitch; popd";
        nixclean = "nix-collect-garbage --delete-older-than 14";

        dcw = "~/dotfiles/scripts/docker-compose-watch.sh";
        cat = "bat";
        v = "nvim";
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
      initExtraFirst = # bash
        ''
          # source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
          # source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
          #
          # source <(kubectl completion zsh)
          . /opt/homebrew/opt/asdf/libexec/asdf.sh
        '';

      initExtra = # bash
        ''
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
        '';
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
