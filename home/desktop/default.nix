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
