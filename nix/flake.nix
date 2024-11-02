{
  description = "My darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    sandstorm-tap = {
      url = "github:sandstorm/homebrew-tap";
      flake = false;
    };
  };

 outputs = { self, nix-darwin, nixpkgs, home-manager, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, sandstorm-tap, ... }:
    let
      # Import the Darwin and Homebrew configurations
      darwinConfig = import ./config/darwin.nix;
      homebrewConfig = import ./config/homebrew.nix {
        inherit homebrew-core homebrew-cask homebrew-bundle sandstorm-tap;
      };
    in
    {
      darwinConfigurations."ssmnaut" = nix-darwin.lib.darwinSystem {
        modules = [
          darwinConfig
          homebrewConfig
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."ssmnaut".pkgs;
    };
}
