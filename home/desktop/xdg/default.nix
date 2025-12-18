{ ... }:

{
  imports = [
    ./applications.nix
    ./autostart.nix
    ./cleanup.nix
    ./terminal.nix
  ];

  # enable xdg integration for user-level options.
  xdg.enable = true;

  # manage xdg userDirs and create missing paths on login.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # enable the gnome polkit.
  services.polkit-gnome.enable = true;
}
