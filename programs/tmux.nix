{config}: {
  enable = true;
  terminal = "tmux-256color";
  historyLimit = 8000;
  keyMode = "vi";
  escapeTime = 1;
  baseIndex = 1;
  shortcut = "a";
  extraConfig = ''
    set-option -sa terminal-features ',xterm-256color:RGB'

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

    ## Popup stuff
    bind-key S run-shell 'tmux popup -E tshort'
    ## bind-key s run-shell 'tmux popup -E tmux_fuzzy_session'
    bind-key ` new-session -A -s Main -c ~

    # Open vimwiki
    bind-key y new-window -n Mind 'nvim -c VimwikiIndex'

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
    set -g status-right "#[fg=#719cd6] #(tshort list) #[fg=#719cd6,nobold,nounderscore,noitalics]#[fg=#719cd6,bold] #h "
    setw -g window-status-activity-style "underscore,fg=#71839b"
    setw -g window-status-separator ""
    setw -g window-status-style "NONE,fg=#71839b"
    setw -g window-status-format "#[fg=#131a24,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#131a24,nobold,nounderscore,noitalics]"
    setw -g window-status-current-format "#[fg=#131a24,nobold,nounderscore,noitalics]#[fg=#719cd6,bold] #I #W #F #[fg=#212e3f,nobold,nounderscore,noitalics]"
  '';
}
