{
  config,
  pkgs,
  lib,
  ...
}: let
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${lib.getExe pkgs.nixgl.nixGLIntel} $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in {
  programs.wezterm = {
    enable = true;
    package = nixGLWrap pkgs.wezterm;
  };
  programs.rofi = {
    enable = true;
    package = nixGLWrap pkgs.rofi;
    extraConfig = {
      mode = "drun";
    };
  };
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "viins";
    dirHashes = {
      code = "$HOME/code";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "vi-mode"
        "docker"
        "fzf"
      ];
      theme = "af-magic";
      extraConfig = ''
        VI_MODE_SET_CURSOR=true
        VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
      '';
    };
    shellAliases = {
      ls = "lsd";
      sail = "./vendor/bin/sail";
      "docker-compose -T" = "docker-compose";
      mine = "sudo chown -R $USER:$USER";
    };
    initExtra = ''
      fpath+=(/usr/share/zsh/site-functions)
      if [ -d "$HOME/.local/zsh" ] ; then
          for f in ~/.local/zsh/*; do source $f; done
      fi
    '';
  };

  programs.git = {
    enable = true;
    userName = "Ariel D'Alessandro";
    userEmail = "dalessandro.ariel@gmal.com";
    extraConfig = {
      init = {defaultBranch = "main";};
      branch = {autosetuprebase = "always";};
      pull = {rebase = true;};
    };
  };
}
