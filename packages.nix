{ pkgs, config, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    kitty
    wget
    firefox
    tmux
    docker
    gcc
    ripgrep
    gnumake
    xclip
    tldr
    exa
    gh

    bitwarden
    bitwarden-cli

    # GoLang
    go

    # PHP
    php81
    php81Packages.composer

    fzf
    zsh
  ];
}
