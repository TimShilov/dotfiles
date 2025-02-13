{ pkgs, ... }:
{
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      orientation = "left";
    };
    spaces = {
      spans-displays = false;
    };
    NSGlobalDomain = {
      _HIHideMenuBar = true;
      KeyRepeat = 2;
      InitialKeyRepeat = 20;
    };
    CustomUserPreferences = {
      NSGlobalDomain = {
        NSStatusItemSpacing = 8;
        NSStatusItemSelectionPadding = 16;
      };
    };
  };

  environment = {
    # TODO: Remove when https://github.com/LnL7/nix-darwin/pull/1020 is merged
    etc."pam.d/sudo_local".text = ''
      # Managed by Nix Darwin
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';

    systemPackages = with pkgs; [
      pam-reattach
      btop
      cargo
      fd
      gh-ost
      htop
      jq
      jqp
      neovim
      sesh
    ];
  };

  # Auto upgrade nix package and the daemon service.
  nix = {
    package = pkgs.nixVersions.latest;
    gc.automatic = true;
    optimise.automatic = true;
  };
  services = {
    sketchybar = {
      enable = true;
      extraPackages = with pkgs; [
        bkt
        taskwarrior3
        notmuch
      ];
    };
    jankyborders = {
      # Catppuccin colors
      # active_color = "gradient(top_left=0xffcba6f7,bottom_right=0xfffab387)";
      # GitHub colors
      active_color = "gradient(top_left=0xff7C72FF,bottom_right=0xff2DA44E)";

      enable = true;
      hidpi = false;
      inactive_color = "0x00FFFFFF";
      # TODO: Enable after updating nix-darwin
      order = "above";
      style = "round";
      width = 8.0;
    };
  };
  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

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

  security.pki.certificateFiles = [ "/etc/nix/ca_cert.pem" ];

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
      "StudyCards" = 1534325530;
      "Irvue" = 1039633667;
    };
    casks = [
      "aerospace"
      "arc"
      "firefox"
      "firefox@nightly"
      "gather"
      "ghostty"
      "google-cloud-sdk"
      "karabiner-elements"
      "macs-fan-control"
      "nikitabobko/tap/aerospace"
      "raycast"
      "sf-symbols"
      "tableplus"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "nikitabobko/tap"
    ];
    brews = [
      "bitwarden-cli"
      "helm"
      "imapfilter"
      "dhth/tap/act3"
      "mas"
      "podman" # Must be installed with Brew to not have issues with Netskope
      "podman-compose"
      "posting" # API client
      "ncdu"
      "asdf"
      "gnu-sed"
      "watch"
    ];
  };
}
