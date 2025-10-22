{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./applications.nix
    ./autostart.nix
    ./polkit.nix
    ./portals.nix
  ];

  xdg.userDirs.enable = true;
}
