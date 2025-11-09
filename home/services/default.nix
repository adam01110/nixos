{ ... }:

{
  services.flatpak.overrides.global.Context.filesystems = [ "xdg-config/dconf:ro" ];
}
