{ pkgs, ... }: {

  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      orientation = "left";
    };
    NSGlobalDomain = {
      _HIHideMenuBar = true;
    };
  };
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    btop
    cargo
    fd
    gh-ost
    gofumpt
    htop
    jq
    jqp
    neovim
    sesh
  ];

  # Auto upgrade nix package and the daemon service.
  nix.package = pkgs.nixVersions.latest;
  nix.gc = { automatic = true; };
  services = {
    nix-daemon = { enable = true; };
  };
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  fonts.packages = [
    (pkgs.nerdfonts.override {
      fonts = [
        "JetBrainsMono"
      ];
    })
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
  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

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
      autoUpdate = true;
    };
    masApps = {
      "Bitwarden" = 1352778147;
      "In Your Face" = 1476964367;
      "Sequel Ace" = 1518036000;
      "StudyCards" = 1534325530;
      "Telegram" = 747648890;
      "rcmd" = 1596283165;
    };
    casks = [
      "aerospace"
      "arc"
      "firefox@developer-edition"
      "gather"
      "github"
      "google-cloud-sdk"
      "karabiner-elements"
      "macs-fan-control"
      "nikitabobko/tap/aerospace"
      "raycast"
      "sf-symbols"
      "tableplus"
    ];
    taps = [
      "FelixKratz/formulae"
      "ankitpokhrel/jira-cli"
      "homebrew/bundle"
      "homebrew/services"
      "nikitabobko/tap"
    ];
    brews = [
      "asdf"
      "borders"
      "fd"
      "gofumpt"
      "golangci-lint"
      "helm"
      "htop"
      "jira-cli"
      "kubectx"
      "kustomize"
      "lf"
      "mas"
      # For some reason it is installing fine manually but not via Darwin. TODO: Figure out
      # "music-decoy"
      "ncdu"
      "neovim"
      "pam-reattach"
      # { name = "sketchybar"; restart_service = "changed"; start_service = true; }
      "gnu-sed"
      "stow"
      "temporal"
      "tokei"
      "tree"
      "watch"
      "wget"
    ];
  };
}
