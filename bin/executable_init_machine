#!/bin/bash
./install_dotfiles.sh
./install_nix.sh
./install_nix_pkgs.sh

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER

# shellclear
if type shellclear >/dev/null 2>&1
then
    echo shellclear is already installed
  else
    echo installing shellclear
    curl -sS https://raw.githubusercontent.com/rusty-ferris-club/shellclear/main/install/install.sh | zsh
fi
