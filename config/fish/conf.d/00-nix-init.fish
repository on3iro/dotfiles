# Check if ~/.nix-profile symlink is missing and create it if needed
if test -d "/nix" && not test -d "$HOME/.nix-profile"
    # Check for the per-user profile directory
    if test -d "/nix/var/nix/profiles/per-user/$USER/profile"
        ln -sf "/nix/var/nix/profiles/per-user/$USER/profile" "$HOME/.nix-profile"
    end
end

# Add Homebrew to PATH (for Apple Silicon Macs)
if test -d "/opt/homebrew/bin"
    fish_add_path --prepend --global "/opt/homebrew/bin"
    fish_add_path --prepend --global "/opt/homebrew/sbin"
end

# Add Homebrew to PATH (for Intel Macs)
if test -d "/usr/local/bin"
    fish_add_path --prepend --global "/usr/local/bin"
    fish_add_path --prepend --global "/usr/local/sbin"
end

# Add user's Nix profile to PATH if it exists
if test -d "$HOME/.nix-profile/bin"
    fish_add_path --prepend --global "$HOME/.nix-profile/bin"
end

# Add NixOS system profile to PATH if it exists
if test -d "/run/current-system/sw/bin"
    fish_add_path --prepend --global "/run/current-system/sw/bin"
end

if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

if test -f /nix/var/nix/profiles/default/share/fish/vendor_completions.d/nix.fish
    source /nix/var/nix/profiles/default/share/fish/vendor_completions.d/nix.fish
end
