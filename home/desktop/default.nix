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
  ];

  home.packages = [ pkgs.brightnessctl ];

  # enable cliphist for clipboard history.
  services.cliphist.enable = true;
}
