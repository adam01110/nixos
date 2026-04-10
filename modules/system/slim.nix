{lib, ...}: let
  inherit (lib) mkForce;
  inherit (builtins) filter;
in {
  # keep-sorted start block=yes newline_separated=yes
  documentation = {
    doc.enable = mkForce false;
    info.enable = mkForce false;
  };

  # Drop the default package seed so profiles start empty.
  environment.defaultPackages = mkForce [];

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

  services = {
    # Disable speech stack.
    orca.enable = mkForce false;
    speechd.enable = mkForce false;
  };
  # keep-sorted end
}
