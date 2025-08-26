{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland
    ./quickshell
    ./stylix.nix
  ];
}
