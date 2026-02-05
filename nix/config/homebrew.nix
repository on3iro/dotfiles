{ homebrew-core, homebrew-cask, homebrew-bundle, sandstorm-tap, tirith-tap, ... }:
{ config, pkgs, ...}: {
  homebrew = {
    enable = true;
    brews = [
      "ain"
      "nixpacks"
      "sandstorm/tap/dev-script-runner"
      "sandstorm/tap/sandstorm-yubikey-agent"
      "sandstorm/tap/sku"
      "sandstorm/tap/synco"
      "sheeki03/tap/tirith"
    ];
    casks = [
      "android-commandlinetools"
      "chromium"
    ];
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "theo";
    autoMigrate = true;
    mutableTaps = true;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "sandstorm/tap" = sandstorm-tap;
      "sheeki03/tap" = tirith-tap;
    };
  };
}
