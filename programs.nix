{
  config,
  pkgs,
  lib,
  ...
}: let
  nixGLWrap = import ./nixgl.nix pkgs;
in {
  fonts.fontconfig.enable = true;
  programs.kitty = {
    enable = true;
    package = nixGLWrap pkgs.kitty;
    theme = "Tokyo Night";
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
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-esr;
    profiles.default = {
      isDefault = true;
      name = "Default";
      settings = {
        "browser.startup.homepage" = "https://home.ad-impeldown.synology.me";
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      };
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
    userEmail = "dalessandro.ariel@gmail.com";
    extraConfig = {
      init = {defaultBranch = "main";};
      branch = {autosetuprebase = "always";};
      pull = {rebase = true;};
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    historyLimit = 8000;
    keyMode = "vi";
    escapeTime = 1;
    baseIndex = 1;
    shortcut = "a";
    extraConfig = ''
      set -g terminal-overrides ',kitty:Tc'

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      set -g repeat-time 1000
      setw -g pane-base-index 1
      set-option -g allow-rename off

      set -g renumber-windows on
      set -g status-right-length 150

      unbind %
      bind | split-window -h -c '#{pane_current_path}'

      unbind '"'
      bind - split-window -v -c '#{pane_current_path}'

      bind C new-window -c '#{pane_current_path}'

      bind N new-session

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind -r H resize-pane -L 5
      bind -r L resize-pane -R 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5

      bind e new-window -c ~/.config/nvim nvim
      bind E new-window -c ~/.flake nvim

      bind C-a last-window

      unbind r
      bind r source-file ~/.tmux.conf \; display "Reloaded!"

      ## Popup stuff
      bind-key S run-shell 'tmux popup -E tshort'
      ## bind-key s run-shell 'tmux popup -E tmux_fuzzy_session'
      bind-key ` new-session -A -s Main -c ~

      bind-key y new-window -n Wiki 'nvim -c VimwikiIndex'

      bind-key u run-shell  'tmux popup -E tshort bind 1'
      # bind-key C-u run-shell  'tmux_bind_session u #S'
      bind-key i run-shell  'tmux popup -E tshort bind 2'
      # bind-key C-i run-shell  'tmux_bind_session i #S'
      bind-key o run-shell  'tmux popup -E tshort bind 3'
      # bind-key C-o run-shell  'tmux_bind_session o #S'
      bind-key p run-shell  'tmux popup -E tshort bind 4'
      # bind-key C-p run-shell  'tmux_bind_session p #S'

      bind-key b set -g status

      # # Status update interval
      set -g status-interval 1

      set-option -g detach-on-destroy off

      set-option -g status-position top

      set -g mode-style "fg=#719cd6"
      set -g message-style "fg=#719cd6"
      set -g message-command-style "fg=#719cd6,bg=#131a24"
      set -g pane-border-style "fg=#131a24"
      set -g pane-active-border-style "fg=#719cd6"

      set -g status "on"
      set -g status-justify "left"
      set -g status-style "fg=#719cd6,bg=default"
      set -g status-left-length "100"
      set -g status-right-length "400"
      set -g status-left-style NONE
      set -g status-right-style NONE
      set -g status-left "#[fg=#719cd6,bold] #S #[fg=#719cd6,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#131a24,nobold,nounderscore,noitalics]#[fg=#719cd6] #(tshort list) #[fg=#212e3f,nobold,nounderscore,noitalics]#[fg=#719cd6] %Y-%m-%d  %I:%M %p #[fg=#719cd6,nobold,nounderscore,noitalics]#[fg=#719cd6,bold] #h "
      setw -g window-status-activity-style "underscore,fg=#71839b"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=#71839b"
      setw -g window-status-format "#[fg=#131a24,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#131a24,nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#131a24,nobold,nounderscore,noitalics]#[fg=#719cd6,bold] #I #W #F #[fg=#212e3f,nobold,nounderscore,noitalics]"
    '';
  };
}
