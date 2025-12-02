{ ... }:

{
  imports = [
    ./applications.nix
    ./autostart.nix
    ./cleanup.nix
    ./polkit.nix
    ./terminal.nix
  ];

  # enable xdg integration for user-level options.
  xdg.enable = true;

  # enable xdg userDirs.
  xdg.userDirs.enable = true;
}
