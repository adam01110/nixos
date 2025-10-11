{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

{
  imports = [
    ./appearance.nix
    ./hypridle.nix
    ./keybinds.nix
    ./general.nix
    ./plugins.nix
    ./rules.nix
    ./startup.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    plugins = [
      inputs.hyprland-plugins.packages.${system}.hyprfocus
      inputs.hyprland-plugins.packages.${system}.hyprexpo
      pkgs.hyprlandPlugins.hyprsplit
    ];
  };

  home.packages = with pkgs; [
    hyprpicker
    brightnessctl
  ];

  home.pointerCursor.hyprcursor.enable = true;
}
