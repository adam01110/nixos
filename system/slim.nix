{lib, ...}:
# Trim down default packages and documentation to keep install small.
let
  inherit (lib) mkForce;
  inherit (builtins) filter;
in {
  documentation = {
    doc.enable = mkForce false;
    info.enable = mkForce false;
  };

  environment.defaultPackages = mkForce [];

  services = {
    orca.enable = mkForce false;
    speechd.enable = mkForce false;
  };

  # Slim xdg-desktop-portal-gtk globally to avoid duplicate user units.
  nixpkgs.overlays = [
    (_final: prev: {
      xdg-desktop-portal-gtk = prev.xdg-desktop-portal-gtk.overrideAttrs (old: {
        buildInputs =
          filter (
            pkg: pkg != prev.gnome-desktop && pkg != prev.gnome-settings-daemon
          )
          old.buildInputs;
        mesonFlags = (old.mesonFlags or []) ++ ["-Dwallpaper=disabled"];
      });
    })
  ];
}
