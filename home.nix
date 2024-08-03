{ config, pkgs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sergio";
  home.homeDirectory = "/home/sergio";

  imports = [ ./hyprland.nix ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = lib.mkForce "solarized_light";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };

    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt-rfc-style";
    }];
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
