{
  description = "System Flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    # private.url = "git+ssh://git@github.com/TimShilov/dotfiles-private";
    private.url = "git+file:///Users/tim.shilov/dotfiles/private";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      catppuccin,
      home-manager,
      nixpkgs,
      private,
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#client-Tim-Shilov
      darwinConfigurations."client-Tim-Shilov" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = {
                # example: inherit catppuccin;
              };
              verbose = true;
              users."tim.shilov".imports = [
                ./modules/home-manager
                catppuccin.homeManagerModules.catppuccin
              ] ++ private.modules;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."client-Tim-Shilov".pkgs;
    };
}
