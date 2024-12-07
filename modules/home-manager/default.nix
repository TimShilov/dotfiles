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
