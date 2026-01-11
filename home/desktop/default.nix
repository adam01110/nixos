{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  imports = [
    ./hyprland
    ./noctalia
    ./stylix
    ./xdg
    ./mangohud.nix
  ];

  # packages: hardware control utilities for brightness and display management.
  home.packages = attrValues {
    inherit
      (pkgs)
      brightnessctl
      ddcutil
      ;
  };

  # enable cliphist for clipboard history.
  services.cliphist.enable = true;
}
