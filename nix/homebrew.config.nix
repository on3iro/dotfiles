{ inputs, ... }: {
  nix-homebrew = {
    # Enable Homebrew
    enable = true;

    # Enable Rosetta for Apple Silicon (if applicable)
    enableRosetta = true;

    # Specify the user for Homebrew installation
    user = "theo";

    # Automatically migrate existing Homebrew installations
    autoMigrate = true;

    # Optional: Set cleanup on activation
    # onActivation.cleanup = "zap";

    # Allow mutable taps
    mutableTaps = true;

    # Define the taps using inputs
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "sandstorm/tap" = inputs.sandstorm-tap;
    };
  };
}

