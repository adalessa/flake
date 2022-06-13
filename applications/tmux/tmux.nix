pkgs:
{
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    plugins = with pkgs;[
      tmuxPlugins.sensible
      tmuxPlugins.tmux-fzf
      {
        plugin = tmuxPlugins.fzf-tmux-url;
        extraConfig = "set -g @fzf-url-bind 'x'";
      }
    ];
    extraConfig = ''
set -g default-terminal "screen-256color"
set -g terminal-overrides ',xterm-256color:Tc'
set -g history-limit 8000

## copy to system clipboard
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

## decrease command delay (increases vim responsiveness)
set -sg escape-time 1

## increase repeat time for repeatable commands
set -g repeat-time 1000

## start window index at 1
set -g base-index 1

## start pane index at 1
setw -g pane-base-index 1

##disable auto rename
set-option -g allow-rename off

## highlight window when it has new activity
#setw -g monitor-activity on
#set -g visual-activity on

## re-number windows when one is closed
set -g renumber-windows on

## set -g status-left-length 25
set -g status-right-length 150


############################
##  Key Bindings
############################

## tmux prefix
unbind C-b
set -g prefix C-a


## paste
#unbind C-p
#bind C-p paste-buffer

## window splitting
unbind %
bind | split-window -h -c '#{pane_current_path}'

unbind '"'
bind - split-window -v -c '#{pane_current_path}'

bind C new-window -c '#{pane_current_path}'
## quickly switch panes
# unbind ^J
#bind ^J select-pane -t :.+

bind N new-session

##move throw panels
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind -r H resize-pane -L 5
bind -r L resize-pane -R 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5

bind e new-window -c ~/.dotfiles/nvim/.config/nvim nvim

bind C-a last-window

## force a reload of the config file
unbind r
bind r source-file ~/.tmux.conf \; display "Reloaded!"

## Popup stuff
bind-key S run-shell 'tmux popup -E tshort select'
bind-key ` switch-client -t Main

bind-key y new-window -n Wiki 'nvim -c VimwikiIndex'

bind-key u run-shell  'tmux popup -E tshort bind -key=1'
bind-key i run-shell  'tmux popup -E tshort bind -key=2'
bind-key o run-shell  'tmux popup -E tshort bind -key=3'
bind-key p run-shell  'tmux popup -E tshort bind -key=4'

bind-key b set -g status

# # Status update interval
set -g status-interval 1

# Will go next session on killing a session
set-option -g detach-on-destroy off

set -g mode-style "fg=#719cd6,bg=#131a24"
set -g message-style "fg=#719cd6,bg=#131a24"
set -g message-command-style "fg=#719cd6,bg=#131a24"
set -g pane-border-style "fg=#131a24"
set -g pane-active-border-style "fg=#719cd6"
set -g status "on"
set -g status-justify "left"
set -g status-style "fg=#719cd6,bg=#131a24"
set -g status-left-length "100"
set -g status-right-length "400"
set -g status-left-style NONE
set -g status-right-style NONE
set -g status-left "#[fg=#393b44,bg=#719cd6,bold] #S #[fg=#719cd6,bg=#131a24,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#131a24,bg=#131a24,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#131a24] #(tshort list -format=text) #[fg=#212e3f,bg=#131a24,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#212e3f] %Y-%m-%d  %I:%M %p #[fg=#719cd6,bg=#212e3f,nobold,nounderscore,noitalics]#[fg=#393b44,bg=#719cd6,bold] #h "
setw -g window-status-activity-style "underscore,fg=#71839b,bg=#131a24"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#71839b,bg=#131a24"
setw -g window-status-format "#[fg=#131a24,bg=#131a24,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#131a24,bg=#131a24,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#131a24,bg=#212e3f,nobold,nounderscore,noitalics]#[fg=#719cd6,bg=#212e3f,bold] #I  #W #F #[fg=#212e3f,bg=#131a24,nobold,nounderscore,noitalics]"
    '';
  }
