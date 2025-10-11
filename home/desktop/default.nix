{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland
    ./hyprshot.nix
    ./noctalia.nix
    ./stylix.nix
  ];

  services.cliphist.enable = true;
}
