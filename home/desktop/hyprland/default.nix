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

    plugins = with inputs; [
      hyprland-plugins.packages.${system}.hyprfocus
      split-monitor-workspaces.packages.${system}.split-monitor-workspaces
    ];
  };
}
