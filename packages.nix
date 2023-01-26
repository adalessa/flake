{config, pkgs, lib, ...}:{
  home.packages = [
    pkgs.lazygit
    pkgs.gpick
    pkgs.insomnia
    pkgs.lsd
    pkgs.php82
    pkgs.php82Packages.composer
    pkgs.php82Packages.phpstan
    pkgs.php82Packages.phpcs
    pkgs.go
    pkgs.rustup
    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.bat
    pkgs.jq
    pkgs.ripgrep
    pkgs.screenkey
    #formatter for nix
    pkgs.alejandra
    # zsh needs
    pkgs.zsh-syntax-highlighting
    pkgs.nix-zsh-completions
  ];
}
