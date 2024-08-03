{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sergio";
  home.homeDirectory = "/home/sergio";

  programs.helix = {
    enable = true;
    settings = {
      editor.cursor-shape = {
        normal = "block";
        insert = "block";
        select = "underline";
      };
    };

    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
    themes = { };
  };

  programs.chromium = {
    enable = true;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; }
    ];
  };

  programs.btop = { enable = true; };

  home.packages = with pkgs; [
    rofi-wayland
    hyprpaper
    hyprlock
    hypridle
    hyprshot
    waybar
    playerctl
    pamixer
    brightnessctl
    networkmanagerapplet
    pavucontrol
    nwg-look
    gnome-keyring
    seahorse
    tree
    kitty
    mpv
    fish
    chromium
    dunst
    btop
    gh
    neovim
    yt-dlp
  ];

  home.stateVersion = "24.05"; # Please read the comment before changing.

  qt = { enable = true; };

  home.file = { };

  home.sessionVariables = {
    EDITOR = "hx";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SCREENSHOTS_DIR = "~/screens";
    QT_QPA_PLATFONM_THEME = "qt5ct";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    QT_STYLE_OVERRIDE = "kvantum";

  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
  services.dunst.enable = true;

  # Let Home Manager install and manage itself.

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$term" = "kitty";
      bind = [
        "$mod, R, exec, rofi -show drun"
        "$mod, W, exec, rofi -show window"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"

        "$mod, R, exec, rofi -show drun"
        "$mod, W, exec, rofi -show window"
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mod, F2, exec, rofi -modi emoji -show emoji"
        "$mod, P, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"

        "$mod, Q, exec, $term"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, E, exec, $fileManager"
        "$mod, T, togglefloating,"
        "$mod, F, fullscreen"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        "$mod SHIFT, LEFT, movewindow, l"
        "$mod SHIFT, RIGHT, movewindow, r"
        "$mod SHIFT, UP, movewindow, u"
        "$mod SHIFT, DOWN, movewindow, d"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"

        "$mod, O, exec, hyprlock"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        "$mod, S, togglespecialworkspace, magic"
        "$mod, S, movetoworkspace, +0"
        "$mod, S, togglespecialworkspace, magic"
        "$mod, S, movetoworkspace, special:magic"
        "$mod, S, togglespecialworkspace, magic"

        "$mod, PRINT, exec, $screenshot -m window"
        "$mod, PRINT, exec, $screenshot -m region"

        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMicMute, exec, pamixer --default-source -t"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"

        # Window resizing                           X  Y
        "$mod CTRL, left,  resizeactive, -60 0"
        "$mod CTRL, right, resizeactive,  60 0"
        "$mod CTRL, up,    resizeactive,  0 -60"
        "$mod CTRL, down,  resizeactive,  0  60"

        "$mod CTRL, h,  resizeactive, -60 0"
        "$mod CTRL, l, resizeactive,  60 0"
        "$mod CTRL, k,    resizeactive,  0 -60"
        "$mod CTRL, j,  resizeactive,  0  60"
        # Waybar
        "$mod SHIFT, I, exec, pkill -SIGUSR2 waybar"

        "$mod, I, exec, ../scripts/restart_hyprpaper.sh"
      ];
      general = {
        layout = "master";
        gaps_in = 0;
        gaps_out = 0;
        allow_tearing = false;
        border_size = 1;
      };

      input = {
        kb_layout = "us,ru";
        kb_options =
          "grp:alt_shift_toggle,caps:swapescape,grp:alt_space_toggle";
        repeat_rate = 35;
        repeat_delay = 175;

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = { natural_scroll = false; };
      };
      gestures = { workspace_swipe = true; };
      animations = { enabled = false; };
      device = {
        name = "tpps/2-elan-trackpoint";
        sensitivity = -0.5;
      };
    };
  };

  programs.home-manager.enable = true;
  programs.fish.enable = true;
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    # theme = "dmenu";
  };

  programs.waybar = {
    enable = true;
    style = ''
      * {
        font-family: Fira Code, Fira Code Symbol;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 18;
        # output = [ "eDP-1" ];
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "temperature" "cpu" "memory" "battery" ];
      };
    };
  };

  programs.kitty = { enable = true; };
  programs.tmux = {
    enable = true;
    keyMode = "vi";
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [{
        path = "~/Downloads/nice.png";
        blur_passes = 3;
        blur_size = 8;
      }];

      input-field = [{
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';

        shadow_passes = 2;
      }];
    };
  };
}
