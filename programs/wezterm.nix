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
        "Symbols Nerd Font Mono",
        "Noto Color Emoji",
      },
      font_size = 12.5,
      color_scheme = "tokyonight",
      audible_bell = "Disabled",
      window_decorations = "RESIZE",
      window_padding = {
        left = 2,
        right = 2,
        top = 4,
        bottom = 0,
      },
      window_background_opacity = 0.8,
      hide_tab_bar_if_only_one_tab = true,
      default_prog = { "zsh", "--login", "-c", "tmux new-session -A -s Main" },
    }
  '';
}
