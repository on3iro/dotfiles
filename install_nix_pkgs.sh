#!/bin/bash

# abort on premature error
set -e

nix-env -iA \
  nixpkgs.chezmoi \
	nixpkgs.bat \
  nixpkgs.bottom \
  nixpkgs.curl \
	nixpkgs.fzf \
	nixpkgs.git \
	nixpkgs.neovim \
	nixpkgs.ripgrep \
	nixpkgs.zsh \
  nixpkgs.bottom \
  nixpkgs.curl \
  nixpkgs.dbmate \
  nixpkgs.fd \
  nixpkgs.fnm \
  nixpkgs.jq \
  nixpkgs.just \
  nixpkgs.lazygit \
  nixpkgs.lua \
  nixpkgs.nmap \
  nixpkgs.marksman \
  nixpkgs.sd \
  nixpkgs.shellclear \
  nixpkgs.starship \
  nixpkgs.tealdeer \
  nixpkgs.tree-sitter \
  nixpkgs.universal-ctags \
  nixpkgs.zellij \
  nixpkgs.zoxide \
  nixpkgs.yazi \
