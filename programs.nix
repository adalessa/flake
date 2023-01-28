{
  config,
  pkgs,
  lib,
  ...
}: let
  nixGLWrap = import ./nixgl.nix pkgs;
in {
  fonts.fontconfig.enable = true;

  programs = {
    wezterm = import ./programs/wezterm.nix {
      inherit nixGLWrap pkgs;
    };

    kitty = import ./programs/kitty.nix {
      inherit nixGLWrap pkgs;
    };

    firefox = import ./programs/firefox.nix {
      inherit pkgs;
    };

    zsh = import ./programs/zsh.nix {
      inherit config;
    };

    git = import ./programs/git.nix {
      inherit config;
    };

    tmux = import ./programs/tmux.nix {
      inherit config;
    };
  };
}
