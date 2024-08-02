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

  programs.hyprlock.enable = true;
}
