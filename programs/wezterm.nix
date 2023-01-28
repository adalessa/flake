{
  pkgs,
  nixGLWrap,
}: {
  enable = true;
  package = nixGLWrap pkgs.wezterm;
  extraConfig = ''
    local wezterm = require 'wezterm'
    return {
      font = wezterm.font("Victor Mono"),
      color_scheme = "tokyonight",
      hide_tab_bar_if_only_one_tab = true,
      default_prog = { "zsh", "--login", "-c", "tmux new-session -A -s Main" },
    }
  '';
}
