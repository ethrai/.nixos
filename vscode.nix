{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  stylix.targets.vscode.enable = false;
  programs.vscode = {
    package = pkgs.vscodium;
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      jnoortheen.nix-ide
    ];
  };
}
