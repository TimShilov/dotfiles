{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./packages.nix
    ./programs/k9s.nix
    ./programs/lazygit.nix
    ./programs/starship.nix
    ./programs/taskwarrior.nix
    ./programs/tmux
    ./programs/zoxide.nix
    ./programs/zsh.nix

    ./services/bugwarrior.nix
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
          "text/calendar" = "bat";
          "application/ics" = "bat";
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
    neomutt = {
      enable = true;
      vimKeys = true;
      binds = [
        {
          key = "<return>";
          action = "display-message";
          map = [ "index" ];
        }
      ];
      sidebar = {
        enable = true;
      };
      extraConfig = # bash
        ''
          color normal		  default default         # Text is "Text"
          color index		    color2 default ~N       # New Messages are Green
          color index		    color1 default ~F       # Flagged messages are Red
          color index		    color13 default ~T      # Tagged Messages are Red
          color index		    color1 default ~D       # Messages to delete are Red
          color attachment	color5 default          # Attachments are Pink
          color signature	  color8 default          # Signatures are Surface 2
          color search		  color4 default          # Highlighted results are Blue

          color indicator		default color8          # currently highlighted message Surface 2=Background Text=Foreground
          color error		    color1 default          # error messages are Red
          color status		  color15 default         # status line "Subtext 0"
          color tree        color15 default         # thread tree arrows Subtext 0
          color tilde       color15 default         # blank line padding Subtext 0

          color hdrdefault  color13 default         # default headers Pink
          color header		  color13 default "^From:"
          color header	 	  color13 default "^Subject:"

          color quoted		  color15 default         # Subtext 0
          color quoted1		  color7 default          # Subtext 1
          color quoted2		  color8 default          # Surface 2
          color quoted3		  color0 default          # Surface 1
          color quoted4		  color0 default
          color quoted5		  color0 default
          color sidebar_flagged   color1 default    # Mailboxes with flagged mails are Red
          color sidebar_new       color10 default   # Mailboxes with new mail are Green

          color body		color2 default		[\-\.+_a-zA-Z0-9]+@[\-\.a-zA-Z0-9]+               # email addresses Green
          color body	  color2 default		(https?|ftp)://[\-\.,/%~_:?&=\#a-zA-Z0-9]+        # URLs Green
          color body		color4 default		(^|[[:space:]])_[^[:space:]]+_([[:space:]]|$)     # _underlined_ text Blue
          color body		color4 default		(^|[[:space:]])/[^[:space:]]+/([[:space:]]|$)     # /italic/ text Blue
          color body		color4 default		(^|[[:space:]])\\*[^[:space:]]+\\*([[:space:]]|$) # *bold* text Blue
        '';
    };

    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    khal = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
    mise = {
      enable = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    password-store = {
      enable = true;
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
    };
    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep = {
      enable = true;
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
