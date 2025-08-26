{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

{
  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app -- wl-clip-persist --clipboard regular"
  ];

  home.packages = with pkgs; [ wl-clip-persist ];
}
