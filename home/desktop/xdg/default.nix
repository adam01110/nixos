{ ... }:

{
  imports = [
    ./applications.nix
    ./autostart.nix
    ./cleanup.nix
    ./polkit.nix
  ];

  xdg.enable = true;
}
