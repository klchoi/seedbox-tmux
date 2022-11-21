function _seedbox-tmux_install -e seedbox-tmux_install -e seedbox-tmux_update
  mkdir -p $HOME/.local/bin
  wget https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b-x86_64.AppImage -O $HOME/.local/bin/tmux
  chmod +x $HOME/.local/bin/tmux
end
