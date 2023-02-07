{
  pkgs,
  nixGLWrap,
}: {
  enable = true;
  package = nixGLWrap pkgs.kitty;
  theme = "Catppuccin-Mocha";
  font = {
    name = "Victor Mono Bold";
    size = 12;
    package = pkgs.victor-mono;
  };
  keybindings = {
    "ctrl+f>1" = "set_font_size 12";
    "ctrl+f>2" = "set_font_size 23";
  };
  settings = {
    background_opacity = "0.98";
    enable_audio_bell = false;
    adjust_line_height = "100%";
    close_on_child_death = true;
    window_padding_width = 1;
    hide_window_decorations = true;
    confirm_os_window_close = 0;
  };
  extraConfig = ''
    shell tmux new-session -A -s Main
    symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E634,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF Symbols Nerd Font Mono
  '';
}
