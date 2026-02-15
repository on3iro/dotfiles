{ pkgs, config, ... }: {
  environment.systemPackages = import ./pkgs.common.nix { pkgs = pkgs; } ++ [
    pkgs.aerospace
    pkgs.ain
    pkgs.ansible
    pkgs.cargo
    pkgs.dbmate 
    pkgs.delta 
    pkgs.direnv
    pkgs.go
    pkgs.httpie
    pkgs.imagemagick
    pkgs.just 
    pkgs.lazygit 
    pkgs.lazydocker
    pkgs.mariadb
    pkgs.mise
    pkgs.mycli
    pkgs.nmap 
    pkgs.usage
    pkgs.pika
    pkgs.postgresql
    pkgs.rustc
    pkgs.silver-searcher
    pkgs.tealdeer 
    pkgs.universal-ctags 
  ];

  system.activationScripts = {
    # Set up the alias for applications to be indexed by Spotlight
    applications = {
      text = ''
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${
          pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = [ "/Applications" ];
          }
        }/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
      '';
    };
};

  # services.aerospace.enable = true; -> use acutal package and manual toml file instead
  nix.settings.experimental-features = "nix-command flakes";
  nix.enable = false;

  # Shell configurations
  programs.zsh.enable = true;
  # programs.fish.enable = true;

  system.primaryUser = "theo";

  # System defaults for macOS
  system.defaults = {
    dock.autohide = true;
    dock.launchanim = false;
    dock.magnification = false;
    dock.mineffect = "scale";
    dock.orientation = "right";
    dock.persistent-apps = [];
    dock.persistent-others = [ "/Applications" ];
    dock.static-only = true;
    dock.expose-group-apps = true; # group windows by application
    dock.mru-spaces = false;
    dock.wvous-bl-corner = 1;
    dock.wvous-br-corner = 1;
    dock.wvous-tl-corner = 1;
    dock.wvous-tr-corner = 1;

    # WindowManager.AppWindowGroupingBehavior = true;

    finder.FXPreferredViewStyle = "icnv";
    finder.AppleShowAllExtensions = true;
    finder.AppleShowAllFiles = true;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    finder._FXShowPosixPathInTitle = true;
    finder._FXSortFoldersFirst = true;

    screencapture.location = "~/Pictures/screenshots";
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain.AppleShowScrollBars = "Automatic";
    NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    NSGlobalDomain."com.apple.keyboard.fnState" = false;
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Set platform and version for compatibility
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
}

