function _seedbox_tmux_setup -e seedbox-tmux_install -e seedbox-tmux_update
  _seedbox_tmux_install
  _seedbox_tmux_config
end

function _seedbox_tmux_install
  if not type -q tmux
    mkdir -p $HOME/.local/bin
    dpkg -i https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage
  end
end

function _seedbox_tmux_config
  mkdir -p $HOME/.config/tmux
  echo '

set-option -g @HOME "#(realpath $HOME)"

##########
# OPTIONS
##########

set-option -g base-index 1
set-option -g pane-base-index 1
set-option -g renumber-windows on

# Faster command sequence
set-option -s escape-time 0

# Have a very large history
set-option -g history-limit 1000000

# Mouse mode on
set-option -ga terminal-overrides \'xterm*:smcup@:rmcup@\'
set-option -g mouse on

# Set title
set-option -g set-titles on
set-option -g set-titles-string "#T"

set -g @thumbs-key F

###############
# KEY BINDINGS
###############

# Disable confirm before killing
bind x kill-pane

# Reload config
set-option -g display-time 500
unbind r
bind -n C-r source-file $HOME/.config/tmux/tmux.conf \; display "Config reloaded!"

bind -n C-_ split-window -c "#{pane_current_path}"
bind -n C-\\\\ split-window -h -c "#{pane_current_path}"
bind -n C-t new-window -c "#{pane_current_path}"

bind -n C-x kill-pane

bind -n M-1 select-window -t 1
bind -n M-2 select-window -t 2
bind -n M-3 select-window -t 3
bind -n M-4 select-window -t 4
bind -n M-5 select-window -t 5
bind -n M-6 select-window -t 6
bind -n M-7 select-window -t 7
bind -n M-8 select-window -t 8
bind -n M-9 select-window -t 9
bind -n M-0 select-window -t 10

bind -n M-h select-pane -L
bind -n M-j select-pane -D
bind -n M-k select-pane -U
bind -n M-l select-pane -R

# Clear scroll buffer with Ctrl-K
bind -n C-k send-keys C-l \; send-keys -R \; clear-history

set-option -wg automatic-rename-format "tmux"
set-option -wg  @pane_current_path ""
set-option -wga @pane_current_path "#{s|^#{@HOME}|~|;"
set-option -wga @pane_current_path   "s|/|//|;"
set-option -wga @pane_current_path   "s|/([^A-Za-z0-9/]*[A-Za-z0-9])[^/]*/|\\\\1/|;"
set-option -wga @pane_current_path   "s|//|/|;"
set-option -wga @pane_current_path   "s|[^/]+$|#[bold]\\\\0#[nobold]|:"
set-option -wga @pane_current_path     "pane_current_path"
set-option -wga @pane_current_path "}"
set-option -g @window_title "#{?#{!=:#{E:window_name},tmux},#{E:window_name},#{E:@pane_current_path}}"
set-option -g status-interval 1
set-option -g window-status-separator \'\'
set-option -g window-status-format " #[bold]#I#[none]:#{E:@window_title} "
set-option -g window-status-current-format "#[reverse] #[bold]#I#[none,reverse]:#{E:@window_title} "

' > $HOME/.config/tmux/tmux.conf
end
