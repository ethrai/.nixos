{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      font.offset = {
        x = 0;
        y = 0;
      };

      cursor = {
        style = "Block";
        infocused_hollow = true;

        vi_mode_style = {
          shape = "Block";
          blinking = "Off";
        };
      };

    };
  };
}
