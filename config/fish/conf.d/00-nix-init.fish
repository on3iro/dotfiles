# Check if ~/.nix-profile symlink is missing and create it if needed
if test -d "/nix" && not test -d "$HOME/.nix-profile"
    # Check for the per-user profile directory
    if test -d "/nix/var/nix/profiles/per-user/$USER/profile"
        ln -sf "/nix/var/nix/profiles/per-user/$USER/profile" "$HOME/.nix-profile"
    end
end

# Add user's Nix profile to PATH if it exists
if test -d "$HOME/.nix-profile/bin"
    fish_add_path --prepend --global "$HOME/.nix-profile/bin"
end

# Add NixOS system profile to PATH if it exists
if test -d "/run/current-system/sw/bin"
    fish_add_path --prepend --global "/run/current-system/sw/bin"
end

# Add Homebrew to PATH (for Intel Macs)
if test -d "/usr/local/bin"
    fish_add_path --prepend --global "/usr/local/bin"
    fish_add_path --prepend --global "/usr/local/sbin"
end

# Add Homebrew to PATH (for Apple Silicon Macs) - added last so it wins over both nix
# and /usr/local/bin; /opt/homebrew is this machine's actual Homebrew prefix
if test -d "/opt/homebrew/bin"
    fish_add_path --prepend --global "/opt/homebrew/bin"
    fish_add_path --prepend --global "/opt/homebrew/sbin"
end

if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

if test -f /nix/var/nix/profiles/default/share/fish/vendor_completions.d/nix.fish
    source /nix/var/nix/profiles/default/share/fish/vendor_completions.d/nix.fish
end

# Must win over nix/homebrew so conf.d files loading after this one (e.g. mise.fish,
# which bakes an absolute path into its activation function) resolve standalone-installed
# binaries instead of nix-provided ones.
fish_add_path --prepend --global "$HOME/.local/bin"
