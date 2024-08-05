{
  pkgs,
  config,
  stylix,
  ...
}:

{

  stylix.targets.tmux.enable = true;
  programs.tmux = {
    enable = true;
    package = pkgs.tmux;
    historyLimit = 100000;
    keyMode = "vi";
    escapeTime = 0;
    baseIndex = 1;
    plugins = with pkgs; [
      { plugin = tmuxPlugins.sensible; }
      { plugin = tmuxPlugins.vim-tmux-navigator; }
    ];
    extraConfig = ''

      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -g mouse on

      set-option -g status-position bottom

      unbind C-b
      # set -g prefix C-a
      # bind C-a send-prefix
      set -g prefix M-a
      bind M-a send-prefix

      # Session

      bind n command-prompt -p "New Session:" "new-session -A -s '%%'"
      bind i command-prompt -p "Kill Session:" "kill-session -t '%%'"

      bind p command-prompt -p "Go to Session:" "attach-session -t '%%'"


      # Pane resizing
      bind -n M-j resize-pane -Z # zoom
      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2

      bind r source-file "${config.home.homeDirectory}/.config/tmux/tmux.conf"

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      set -g base-index 1           # start windows numbering at 1
      setw -g pane-base-index 1     # make pane numbering consistent with windows

      bind 'h' split-window -v -c "#{pane_current_path}"
      bind 'v' split-window -h -c "#{pane_current_path}"

      set-window-option -g mode-keys vi

      bind Enter copy-mode # enter copy mode

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi H send -X start-of-line
      bind -T copy-mode-vi L send -X end-of-line

      # Zoom
      # copy to Windows clipboard
      if -b 'command -v clip.exe > /dev/null 2>&1' 'bind y run -b "tmux save-buffer - | clip.exe"'
      if -b '[ -c /dev/clipboard ]' 'bind y run -b "tmux save-buffer - > /dev/clipboard"'

    '';
  };
}
