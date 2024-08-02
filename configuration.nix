{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
#     inputs.home-manager.nixosModules.default
    ];

  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true; 
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  security.polkit.enable = true;
  security.pam.services.hyprlock = {};

  networking.hostName = "caladan"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Minsk";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     # earlySetup = true;
     packages = [ pkgs.terminus_font ];
     font = "ter-124b";
     useXkbConfig = true; 
   };

   # Sound
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     pulse.enable = true;
   };

  hardware.graphics = {
     enable = true;
        extraPackages = with pkgs; [
          intel-media-driver # LIBVA_DRIVER_NAME=iHD
          libvdpau-va-gl
      ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  hardware.bluetooth.enable = true;

  
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # ...

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  services.thermald.enable = true;
  services.tlp = {
      enable = true;
  };
  services.gnome.gnome-keyring.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
];
stylix.enable = true;
stylix.autoEnable = true;
stylix.homeManagerIntegration.autoImport = true;
stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
stylix.polarity = "dark";

stylix.image = /home/sergio/Downloads/nice.png;

stylix.cursor.package = pkgs.bibata-cursors;
stylix.cursor.name = "Bibata-Modern-Ice";
stylix.cursor.size = 24;

stylix.fonts = {
  monospace = {
    package = pkgs.fira-code;
    name = "Fira Code";
  };

  sansSerif = {
    package = pkgs.noto-fonts;
    name = "Noto Sans";
  };

  serif = config.stylix.fonts.sansSerif;

  emoji = {
    package = pkgs.noto-fonts-emoji;
    name = "Noto Color Emoji"; 
  };

  sizes = {
    desktop = 11;
    applications = 13;
    popups = 11;
    terminal = 13;
  };
  };

programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.sergio = {
     isNormalUser = true;
     extraGroups = [ "wheel" "input" "networkmanager" "video" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.fish;
     packages = with pkgs; [
     ];
   };

   # home-manager = {
   #    extraSpecialArgs = { inherit inputs; };
   #    users = { 
   #        "sergio" = import ./home.nix;
   #    };
   # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     helix
     wget
     git
     stow
     tmux
     lm_sensors

   ];
  system.stateVersion = "24.05"; # Did you read the comment?

}

