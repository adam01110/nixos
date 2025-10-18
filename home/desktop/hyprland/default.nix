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
      pkgs.hyprlandPlugins.hyprsplit
    ];
  };

  home.packages = with pkgs; [
    hyprpicker
    brightnessctl
  ];

  home.pointerCursor.hyprcursor.enable = true;

  programs.quickshell = {
    enable = true;
    systemd.enable = true;

    activeConfig = "overview";
    configs.overview = ./overview;
  };
}
