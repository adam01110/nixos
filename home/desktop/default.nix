{
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland
    ./noctalia
    ./stylix
    ./xdg
    ./mangohud.nix
  ];

  home.packages = [ pkgs.brightnessctl ];

  # enable cliphist for clipboard history.
  services.cliphist.enable = true;
}
