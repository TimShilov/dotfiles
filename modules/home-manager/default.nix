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
    asdf-vm
    ast-grep
    atac
    bkt # Bash caching
    fd
    fswatch
    gnupg
    go
    grizzly
    helm-dashboard
    jira-cli-go
    kondo
    kubectx
    luarocks
    mysql84
    nixfmt-rfc-style
    rainfrog # Database management TUI
    sleek
    sshs
    taskopen
    tasksh
    taskwarrior-tui
    tlrc
    tokei
    tree
    watchexec
    wget
    yq-go

    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  launchd = {
    enable = true;
    agents = {
      bugwarrior-pull = {
        enable = true;
        config = {
          Label = "com.bugwarrior.pull";
          # TODO: Find a way to not use macOS's built-in Python
          Program = "/Users/tim.shilov/Library/Python/3.9/bin/bugwarrior-pull";
          RunAtLoad = true;
          ProcessType = "Background";
          StartInterval = 900; # 15 minutes
          EnvironmentVariables = {
            PATH = "${config.home.profileDirectory}/bin:/usr/local/bin:/usr/bin:/bin";
          };
        };
      };
    };
  };

  home.file = {
    ".config/borders/bordersrc" = {
      source = dotfiles/bordersrc;
    };
    ".aerospace.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink /Users/tim.shilov/dotfiles/modules/home-manager/dotfiles/.aerospace.toml;
    };
    ".config/bugwarrior/bugwarriorrc" = {
      source = config.lib.file.mkOutOfStoreSymlink /Users/tim.shilov/dotfiles/modules/home-manager/dotfiles/bugwarrior/bugwarriorrc;
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
    password-store = {
      enable = true;
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

            GITHUB_PR_COUNT="#(~/dotfiles/scripts/github-prs-count.sh)"
            JIRA_TICKET_COUNT="#(bkt --ttl=60s --discard-failures -- task jiraid +READY count)"
            JIRA_HOTFIX_COUNT="#(bkt --ttl=55s --discard-failures -- task jiraissuetype:HotFix +READY count)"

            STATUS_SEPARATOR=" "

            set -g status-right "#[fg=#{@thm_subtext_1},align=centre]#(task _get $(task next limit:1 | tail -n +4 | head -n 1 | sed 's/^ //' | cut -d ' ' -f1).description)#[align=right]"

            set -ag status-right "#[fg=#{@thm_blue}]󰌃 "
            set -ag status-right "#[fg=#{@thm_red}]#{?#{>:$JIRA_HOTFIX_COUNT,0},$JIRA_HOTFIX_COUNT ,}"
            set -ag status-right "#[fg=#{@thm_blue}]$JIRA_TICKET_COUNT "
            set -ag status-right "$STATUS_SEPARATOR"

            set -ag status-right "#[fg=#{@thm_peach}] "
            set -ag status-right "#[fg=#{@thm_peach}]$GITHUB_PR_COUNT "
            set -ag status-right "$STATUS_SEPARATOR"

            set -ag status-right "#{E:@catppuccin_status_session}"
          '';
      };

      extraConfig = (builtins.readFile ./configs/tmux.conf);
    };

    taskwarrior = {
      enable = true;
      package = pkgs.taskwarrior3;
      config = {
        uda.taskwarrior-tui.shortcuts = {
          "1" = "~/dotfiles/scripts/taskopen.sh";
        };
      };
      extraConfig = # bash
        ''
          # Bugwarrior UDAs
          uda.githubtitle.type=string
          uda.githubtitle.label=Github Title
          uda.githubbody.type=string
          uda.githubbody.label=Github Body
          uda.githubcreatedon.type=date
          uda.githubcreatedon.label=Github Created
          uda.githubupdatedat.type=date
          uda.githubupdatedat.label=Github Updated
          uda.githubclosedon.type=date
          uda.githubclosedon.label=GitHub Closed
          uda.githubmilestone.type=string
          uda.githubmilestone.label=Github Milestone
          uda.githubrepo.type=string
          uda.githubrepo.label=Github Repo Slug
          uda.githuburl.type=string
          uda.githuburl.label=Github URL
          uda.githubtype.type=string
          uda.githubtype.label=Github Type
          uda.githubnumber.type=numeric
          uda.githubnumber.label=Github Issue/PR #
          uda.githubuser.type=string
          uda.githubuser.label=Github User
          uda.githubnamespace.type=string
          uda.githubnamespace.label=Github Namespace
          uda.githubstate.type=string
          uda.githubstate.label=GitHub State
          uda.jiraissuetype.type=string
          uda.jiraissuetype.label=Issue Type
          uda.jirasummary.type=string
          uda.jirasummary.label=Jira Summary
          uda.jiraurl.type=string
          uda.jiraurl.label=Jira URL
          uda.jiradescription.type=string
          uda.jiradescription.label=Jira Description
          uda.jiraid.type=string
          uda.jiraid.label=Jira Issue ID
          uda.jiraestimate.type=numeric
          uda.jiraestimate.label=Estimate
          uda.jirafixversion.type=string
          uda.jirafixversion.label=Fix Version
          uda.jiracreatedts.type=date
          uda.jiracreatedts.label=Created At
          uda.jirastatus.type=string
          uda.jirastatus.label=Jira Status
          uda.jirasubtasks.type=string
          uda.jirasubtasks.label=Jira Subtasks
          # END Bugwarrior UDAs
        '';
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
        nixclean = "nix-collect-garbage --delete-older-than 14d";

        dcw = "~/dotfiles/scripts/docker-compose-watch.sh";
        cat = "bat";
        tt = "taskwarrior-tui";
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
