{ pkgs, config, ... }: {
  environment.systemPackages = import ./pkgs.common.nix { pkgs = pkgs; } ++ [
    pkgs.alacritty
    pkgs.ansible
    pkgs.dbmate 
    pkgs.delta 
    pkgs.deno
    pkgs.devbox
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

  # Activation script to alias GUI applications to the Nix Apps directory.
  system.activationScripts.applications.text = let
    env = pkgs.buildEnv {
      name = "system-applications";
      paths = config.environment.systemPackages;
      pathsToLink = "/Applications";
    };
  in
    pkgs.lib.mkForce ''
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

  # System-level services and Nix settings
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";

  # Shell configurations
  programs.zsh.enable = true;
  # programs.fish.enable = true;

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
    dock.mru-spaces = false;
    dock.wvous-bl-corner = 1;
    dock.wvous-br-corner = 1;
    dock.wvous-tl-corner = 1;
    dock.wvous-tr-corner = 1;

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
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Set platform and version for compatibility
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
}

