{
  pkgs,
  nixGLWrap,
}: {
  enable = true;
  package = nixGLWrap pkgs.wezterm;
  extraConfig = ''
    local wezterm = require 'wezterm'
    return {
      font = wezterm.font_with_fallback {
        { family = "Victor Mono", weight = "DemiBold" },
        "Symbols Nerd Font Mono"
      },
      color_scheme = "tokyonight",
      audible_bell = "Disabled",
      hide_tab_bar_if_only_one_tab = true,
      default_prog = { "zsh", "--login", "-c", "tmux new-session -A -s Main" },
    }
  '';
}
