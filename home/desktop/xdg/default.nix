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
  ];

  xdg.userDirs.enable = true;
}
