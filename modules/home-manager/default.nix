{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./packages.nix
    ./programs/ghostty.nix
    ./programs/aerospace
    ./programs/k9s.nix
    ./programs/lazygit.nix
    ./programs/starship.nix
    ./programs/taskwarrior.nix
    ./programs/tmux
    ./programs/zoxide.nix
    ./programs/zsh.nix
    ./programs/sketchybar/default.nix
    ./programs/superfile.nix

    ./services/bugwarrior.nix
    ./services/email-index.nix
    ./services/email-sync.nix
    ./services/home-manager.nix
    ./services/imapfilter.nix
    ./services/podman-machine.nix
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.file = {
    ".config/borders/bordersrc" = {
      source = dotfiles/bordersrc;
    };
    ".default-npm-packages" = {
      source = dotfiles/.default-npm-packages;
    };
    ".tool-version" = {
      source = dotfiles/.tool-versions;
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
  };

  xdg = {
    enable = true;
    dataFile = {
      "password-store/" = {
        source = config.lib.file.mkOutOfStoreSymlink /Users/tim.shilov/dotfiles/private/modules/password-store;
        recursive = true;
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man! \"+set relativenumber\"";
    PAGER = "less";
    LANG = "en_GB.UTF-8";
    KUBECONFIG = "$HOME/.kube/config";
    USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
    HOMEBREW_NO_ANALYTICS = 1;
  };
  home.sessionPath = [
    "$HOME/.grit/bin"
    "$HOME/.krew/bin"
    # "$HOME/.dotnet/tools"
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    k9s = {
      transparent = true;
    };
    tmux = {
      extraConfig = # bash
        ''
          set -g @catppuccin_status_background "none"
          # TODO: Make sure that all the options are correct as they were changed in 2.0.0 (@see https://github.com/catppuccin/tmux/blob/main/docs/reference/configuration.md)
          set -g @catppuccin_status_modules_right "session"

          set -g @catppuccin_window_current_text " #W"
          set -g @catppuccin_window_flags "icon"
          set -g @catppuccin_window_flags_icon_activity " 󱅫"
          set -g @catppuccin_window_flags_icon_bell " 󰂞"
          set -g @catppuccin_window_flags_icon_current ""
          set -g @catppuccin_window_flags_icon_last ""
          set -g @catppuccin_window_flags_icon_zoom " 󰁌 "
          set -g @catppuccin_window_text " #W"
        '';
    };
  };

  programs = {
    aerc = {
      enable = true;
      extraConfig = {
        general = {
          always-show-mime = true;
          unsafe-accounts-conf = true;
        };
        viewer = {
          alternatives = "text/html,text/plain";
        };
        filters = {
          "text/plain" = "colorize";
          "text/html" = "html | colorize";
          "text/calendar" = "calendar";
          "application/ics" = "calendar";
          ".headers" = "colorize";
        };
      };
    };
    mbsync = {
      enable = true;
    };
    notmuch = {
      enable = true;
      search = {
        excludeTags = [
          "deleted"
          "trash"
          "spam"
        ];
      };
    };
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    khal = {
      enable = true;
    };
    mise = {
      enable = false;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    password-store = {
      enable = true;
    };

    wezterm = {
      enable = false;
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
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (
        builtins.unsafeDiscardStringContext (builtins.readFile ./configs/oh-my-posh.toml)
      );
    };
    gh = {
      enable = true;
      extensions = with pkgs; [
        gh-notify
        gh-copilot
        gh-s
        gh-f
      ];
    };
    gh-dash = {
      enable = true;
      settings = {
        prSections = [
          {
            title = "Needs My Review";
            filters = "is:open review-requested:@me -label:dependencies ";
          }
          {
            title = "My Pull Requests";
            filters = "is:open author:@me -label:dependencies ";
            layout.author.hidden = true;
          }
          {
            title = "Dependencies";
            filters = "is:open label:dependencies ";
          }
        ];
        repoPaths = {
          "AffluentData/affluent-monorepo" = "~/IdeaProjects/affluent";
          "ImpactInc/etl-engine" = "~/IdeaProjects/affiliate-etl";
        };
        keybindings = {
          prs = [
            {
              key = "M";
              command = "gh pr merge {{.PrNumber}} --admin --squash --delete-branch --repo {{.RepoName}}";
            }
            {
              key = "E";
              command = "tmux new-window -c {{.RepoPath}} 'nvim -c \":silent Octo pr edit {{.PrNumber}}\"'";
            }
          ];
        };
        defaults = {
          preview = {
            open = false;
            width = 90;
          };
        };
      };
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep = {
      enable = true;
    };
    jqp = {
      enable = true;
      settings = {
        theme.name = "catppuccin-mocha";
      };
    };
    pet = {
      enable = true;
      snippets = [
        {
          command = "npx vitest run --disableConsoleIntercept --changed -u && pnpm lint:ci";
          description = "Test Everything (vitest + ts)";
          tag = [
            "vitest"
            "typescript"
          ];
        }
        {
          command = "pnpm index tasks run maintenance/migrate-db --debug";
          description = "Migrate DB (ETL Engine)";
          tag = [ "etl engine" ];
        }
        {
          command = "node temp/run-mysql-for-all-agencies.js";
          description = "Run MySQL for all agencies";
          tag = [ "agency" ];
        }
        {
          command = "pnpm index validate-staging-debug-files --debug";
          description = "Validate Staging Debug Files (ETL Engine)";
          tag = [ "etl engine" ];
        }
      ];
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
