{ config, pkgs, ... }:

let
  customNeovim = import ./applications/nvim/nvim.nix;
  customTmux = import ./applications/tmux/tmux.nix;
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alpha";
  home.homeDirectory = "/home/alpha";

  home.shellAliases = {
      l = "exa --icons --all";
      ls = "exa --icons";
      ll = "exa --icons --all --long";
  };

  home.sessionVariables = {
    NIXOS_CONFIG_DIR = "${config.home.homeDirectory}/flake";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" "docker" "fzf" "gh" ];
      theme = "af-magic";
    };
    enableSyntaxHighlighting = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [ htop godot fzf ];

  home.file = {
    "${config.xdg.configHome}/kitty" = {
      source = ./applications/kitty;
      recursive = true;
    };
    "${config.xdg.configHome}/nvim/after" = {
      source = ./applications/nvim/config;
      recursive = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Ariel D'Alessandro";
    userEmail = "dalessandro.ariel@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.tmux = customTmux pkgs;
  programs.neovim = customNeovim pkgs;
}
