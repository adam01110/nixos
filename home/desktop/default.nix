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
    ./xdg
    ./noctalia.nix
  ];

  services.cliphist.enable = true;
  programs.hyprshot.enable = true;
}
