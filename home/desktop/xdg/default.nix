# xdg desktop integration and mime type configuration module.
{...}: {
  imports = [
    ./applications.nix
    ./autostart.nix
    ./cleanup.nix
    ./terminal.nix
  ];

  # enable xdg integration.
  xdg.enable = true;

  # manage xdg userdirs and auto-create missing paths.
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # enable gnome polkit for graphical authentication prompts.
  services.polkit-gnome.enable = true;
}
