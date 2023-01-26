{
  config,
  pkgs,
  ...
}: let
  nixGLWrap = import ./nixgl.nix pkgs;
in {
  programs.rofi = {
    enable = true;
    package = nixGLWrap pkgs.rofi;
    extraConfig = {
      mode = "drun";
    };
  };
}
