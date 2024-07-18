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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
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
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.k9s = {
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

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.bat = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "rg --files --hidden";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship = {
    enable = true;
    # TODO: Enable after migrating config
    # enableZshIntegration = true;
  };

  programs.gh = { enable = true; };
  programs.gh-dash = { enable = true; };
  programs.git = { enable = true; };
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    autocd = true;
    shellAliases = {
      nixswitch = "darwin-rebuild switch --flake ~/.dotfiles/.#";
      nixup = "pushd ~/.dotfiles; nix flake update; nixswitch; popd";

      cat = "bat --paging=never";
    };
    history = {
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      ignoreSpace = true;
      save = 10000;
      share = true;
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
  programs.home-manager.enable = true;
}
