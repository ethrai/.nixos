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
        insert = "bar";
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

  # services.hypridle.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
      disable_loading_bar = true;
      grace = 300;
      hide_cursor = true;
      no_fade_in = false;
    };

    background = [
      {
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
      }
    ];

    input-field = [
      {
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = '\'<span foreground="##cad3f5">Password...</span>'\';
        shadow_passes = 2;
      }
    ];
    };
  };
}
