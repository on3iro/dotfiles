{
  description = "My darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

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

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle, sandstorm-tap, ... }:
    let
      configuration = { pkgs, config, ... }: {
        environment.systemPackages = import ./pkgs.common.nix { pkgs = pkgs; } ++
          [
            pkgs.alacritty
            pkgs.ansible
            pkgs.dbmate 
            pkgs.delta 
            pkgs.deno
            pkgs.fnm 
            pkgs.httpie
            pkgs.imagemagick
            pkgs.just 
            pkgs.lazygit 
            pkgs.mariadb
            pkgs.nmap 
            pkgs.pika
            pkgs.postgresql
            pkgs.silver-searcher
            pkgs.tealdeer 
            pkgs.universal-ctags 
            pkgs.zsh-autosuggestions
            pkgs.zsh-completions
          ];

          homebrew = {
            enable = true;
            brews = [
              "ain"
              "sandstorm/tap/dev-script-runner"
              "sandstorm/tap/sandstorm-yubikey-agent"
              "sandstorm/tap/sku"
              "sandstorm/tap/synco"
            ];
            casks = [
              "android-commandlinetools"
              "chromium"
            ];
          };

          # Activation script to alias gui applications to the Nix Apps directory.
          system.activationScripts.applications.text = let
            env = pkgs.buildEnv {
              name = "system-applications";
              paths = config.environment.systemPackages;
              pathsToLink = "/Applications";
            };
          in
            pkgs.lib.mkForce ''
            # Set up applications.
            echo "setting up /Applications..." >&2
            rm -rf /Applications/Nix\ Apps
            mkdir -p /Applications/Nix\ Apps
            find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
            while read src; do
              app_name=$(basename "$src")
              echo "copying $src" >&2
              ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
                '';

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;  # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
  in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#ssmnaut
      darwinConfigurations."ssmnaut" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration 
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "theo";

              # Automatically migrate existing Homebrew installations
              autoMigrate = true;

              # onActivation.cleanup = "zap";
              mutableTaps = true;
              taps = {
                "homebrew/homebrew-core" = inputs.homebrew-core;
                "homebrew/homebrew-cask" = inputs.homebrew-cask;
                "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
                "sandstorm/tap" = inputs.sandstorm-tap;
              };
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."ssmnaut".pkgs;
    };
}
