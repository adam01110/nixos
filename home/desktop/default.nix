{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  # Packages: hardware control utilities for brightness and display management.
  home.packages = attrValues {
    inherit
      (pkgs)
      brightnessctl
      ddcutil
      ;
  };

  # Enable cliphist for clipboard history.
  services.cliphist.enable = true;
}
