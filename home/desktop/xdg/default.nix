{ ... }:

{
  imports = [
    ./applications.nix
    ./autostart.nix
    ./cleanup.nix
    ./polkit.nix
    ./portals.nix
  ];

  xdg.enable = true;
}
