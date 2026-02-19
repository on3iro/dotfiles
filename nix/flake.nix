{
  description = "My darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

 outputs = { self, nix-darwin, nixpkgs,  ... }:
    let
      # Import the Darwin and Homebrew configurations
      darwinConfig = import ./config/darwin.nix;
    in
    {
      darwinConfigurations."ssmnaut" = nix-darwin.lib.darwinSystem {
        modules = [
          darwinConfig
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."ssmnaut".pkgs;
    };
}
