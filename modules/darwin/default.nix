{ pkgs, ... }: {
  system.defaults.dock.autohide = true;
  system.defaults.dock.orientation = "left";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    cargo
    fd
    gofumpt
    jq
    btop
    htop
    neovim
    pam-reattach # to allow tmux to work nice with TouchID for sudo
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  fonts.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  environment = {
    variables = {
      LANG = "en_UK.UTF-8";
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnsupportedSystem = true;

  security.pki.certificateFiles = [
    "/etc/nix/ca_cert.pem"
  ];

  # Enable using touch id for sudo.
  security.pam.enableSudoTouchIdAuth = true;

  users.users."tim.shilov" = {
    name = "tim.shilov";
    home = "/Users/tim.shilov";
  };

  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    global.brewfile = true;
    onActivation = {
      cleanup = "zap";
      upgrade = true;
    };
    masApps = {
      "Bitwarden" = 1352778147;
      "Ghostery – Privacy Ad Blocker" = 1436953057;
      "In Your Face" = 1476964367;
      "Sequel Ace" = 1518036000;
      "StudyCards" = 1534325530;
      "Telegram" = 747648890;
      "rcmd" = 1596283165;
    };
    casks = [
      "aerospace"
      "alacritty"
      "arc"
      "firefox@developer-edition"
      "font-jetbrains-mono-nerd-font"
      "gather"
      "github"
      "google-cloud-sdk"
      "karabiner-elements"
      "macs-fan-control"
      "ngrok"
      "nikitabobko/tap/aerospace"
      "raycast"
      "tableplus"
    ];
    taps = [
      "FelixKratz/formulae"
      "ankitpokhrel/jira-cli"
      "hashicorp/tap"
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/services"
      "jesseduffield/lazygit"
      "joshmedeski/sesh"
      "nikitabobko/tap"
      "noahgorstein/tap"
    ];
    brews = [
      "asdf"
      "bat"
      "borders"
      "eza"
      "fd"
      "fzf"
      "gh"
      "git"
      "gofumpt"
      "golangci-lint"
      "helm"
      "htop"
      "jira-cli"
      "joshmedeski/sesh/sesh"
      "jq"
      "k9s"
      "kubectx"
      "kustomize"
      "lazygit"
      "lf"
      "mas"
      "ncdu"
      "neovim"
      "noahgorstein/tap/jqp"
      "ripgrep"
      "starship"
      "stow"
      "temporal"
      "tmux"
      "tokei"
      "tree"
      "watch"
      "wget"
      "yazi"
      "zoxide"
      "zsh-autosuggestions"
    ];
  };
}
