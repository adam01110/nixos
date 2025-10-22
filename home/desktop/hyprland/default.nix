{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

with lib;
let
  cfgOverview = config.hyprland.overview;
in
{
  options.hyprland.overview = mkOption {
    type = types.enum [
      "quickshell"
      "hyprexpo"
    ];
    default = "hyprexpo";
    description = "Which overview to use for Hyprland.";
  };

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

    plugins =
      (
        with inputs.hyprland-plugins.packages.${system};
        [ hyprfocus ] ++ optionals (cfgOverview == "hyprexpo") [ hyprexpo ]
      )
      ++ (with pkgs.hyprlandPlugins; [ hyprsplit ]);
  };

  home.packages = with pkgs; [
    hyprpicker
    brightnessctl
  ];

  home.pointerCursor.hyprcursor.enable = true;

  programs.quickshell = mkIf (cfgOverview == "quickshell") {
    enable = true;
    systemd.enable = true;

    activeConfig = "overview";
    configs.overview = ./overview;
  };
}
