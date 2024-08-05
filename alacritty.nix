{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      env = {
        TERM = "xterm-256color";
      };
      font.offset = {
        x = 0;
        y = 0;
      };

      cursor = {
        style = "Block";
        unfocused_hollow = true;

        vi_mode_style = {
          shape = "Block";
          blinking = "Off";
        };
      };

      shell = {
        args = [
          "new-session"
          "-ADs"
          "main"
        ];
        program = "tmux";
      };
      # [shell]
      # args = ["new-session", "-A", "-D", "-s", "main"]
      # program = "/usr/bin/tmux"

      keyboard.bindings = [
        {
          action = "Paste";
          key = "V";
          mods = "Control|Shift";
        }
        {
          action = "Copy";
          key = "C";
          mods = "Control|Shift";
        }
        {

          action = "PasteSelection";
          key = "Insert";
          mods = "Shift";
        }

        {

          action = "ResetFontSize";
          key = "Key0";
          mods = "Control";

        }
        {

          action = "IncreaseFontSize";
          key = "Equals";
          mods = "Control";
        }
        {

          action = "IncreaseFontSize";
          key = "Plus";
          mods = "Control";
        }
        {

          action = "DecreaseFontSize";
          key = "Minus";
          mods = "Control";
        }
      ];

    };
  };
}
