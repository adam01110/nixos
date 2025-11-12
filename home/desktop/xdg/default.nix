{ ... }:

{
  imports = [
    ./applications.nix
    ./autostart.nix
    ./cleanup.nix
    ./polkit.nix
  ];

  # enable xdg integration for user-level options.
  xdg.enable = true;
}
