{ pkgs, lib, ... }:

{

  imports = [ ./tmux.nix ];

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = lib.mkForce "base16_default_dark";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
    ];
  };

  programs.alacritty.enable = true;
  programs.kitty.enable = true;

  home.packages = with pkgs; [
    alacritty
    kitty
    nixfmt-rfc-style
    tree
    fish
    neovim
    git
    gh
    httpie
    curl
    zsh

    go
    gopls
    gomodifytags
    jq
    nodejs_22
    cargo
    rustc

    docker
  ];
}
