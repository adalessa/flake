{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alpha";
  home.homeDirectory = "/home/alpha";

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

  home.packages = with pkgs; [ htop godot tmuxPlugins.sensible tmuxPlugins.fzf-tmux-url];

  home.file = {
    "${config.xdg.configHome}/kitty" = {
      source = ./applications/kitty;
      recursive = true;
    };
    "${config.home.homeDirectory}/.tmux.conf" = {
      source = ./applications/tmux/tmux.conf;
    };
  };

  programs.git = {
    enable = true;
    userName = "Ariel D'Alessandro";
    userEmail = "dalessandro.ariel@gmail.com";
  };

  programs.tmux.extraConfig = ''
    run-shell ${pkgs.tmuxPlugins.sensible}/share/tmux-plugins/sensible/sensible.tmux
    run-shell ${pkgs.tmuxPlugins.fzf-tmux-url}/share/tmux-plugins/fzf-tmux-url/fzf-url.tmux
    set -g @fzf-url-bind 'm'
  '';
}
