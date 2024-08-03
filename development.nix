{ pkgs, lib, ... }:

# development.nix lists home packages for developing.

{
  home.packages = with pkgs; [
    nixfmt-rfc-style
    tree
    kitty
    fish
    neovim
    git
    gh
    httpie
    curl

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
