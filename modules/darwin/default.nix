{ pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  system = {
    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        mineffect = "scale";
        mru-spaces = false;
        orientation = "bottom";
        persistent-apps = [ ];
        show-recents = false;
        static-only = true;
        tilesize = 24;
        # disable hot corners
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
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
  };

  environment = {
    systemPackages = with pkgs; [
      btop
      cargo
      fd
      gh-ost
      htop
      jq
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
  # Necessary for using flakes on this system.
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnsupportedSystem = true;

  # Enable using touch id for sudo.
  security.pam.services.sudo_local = {
    reattach = true;
    touchIdAuth = true;
  };

  homebrew = {
    enable = true;

    caskArgs.no_quarantine = true;
    global.brewfile = true;
    onActivation = {
      cleanup = "uninstall";
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
      "arc"
      "gather"
      "mouseless"
      "ghostty"
      "karabiner-elements"
      "macs-fan-control"
      "keymapp" # ZSA keyboard flashing tool

      "raycast"
      "sf-symbols"
      "tableplus"
      "zen"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/services"
      "nikitabobko/tap"
      "mk-5/mk-5" # fjira
    ];
    brews = [
      "bitwarden-cli"
      "helm"
      "imapfilter"
      "dhth/tap/act3"
      "mas"
      "podman" # Must be installed with Brew to not have issues with Netskope
      "podman-compose"
      "asdf"
      "gnu-sed"
      "fjira"
    ];
  };
}
