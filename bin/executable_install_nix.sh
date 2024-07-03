#!/bin/bash

# abort on premature error
set -e

if type nix-env >/dev/null 2>&1
then
    echo nix is already installed
  else
    echo installing nix
    curl -L https://nixos.org/nix/install | sh
fi

# Source nix
## Linux
if [ -e /home/$USER/.nix-profile/etc/profile.d/nix.sh ]; then . /home/$USER/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

## OSX
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
