{
  pkgs,
  ...
}:

{
  imports = [
    ./hyprland
    ./stylix
    ./xdg
    ./noctalia.nix
  ];

  home.packages = [ pkgs.brightnessctl ];

  # enable cliphist for clipboard history.
  services.cliphist.enable = true;
}
