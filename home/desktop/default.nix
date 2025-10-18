{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland
    ./stylix
    ./noctalia.nix
  ];

  services.cliphist.enable = true;
  programs.hyprshot.enable = true;
}
