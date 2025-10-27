{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

let
  inherit (lib)
    mkOption
    mkIf
    optionals
    types
    ;
in
{
  imports = [
    ./appearance.nix
    ./hypridle.nix
    ./keybinds.nix
    ./general.nix
    ./plugins.nix
    ./rules.nix
  ];

  options.hyprland.overview = mkOption {
    type = types.enum [
      "quickshell"
      "hyprexpo"
    ];
    default = "hyprexpo";
    description = "Which overview to use for Hyprland.";
  };

  config =
    let
      cfgOverview = config.hyprland.overview;
    in
    {
      wayland.windowManager.hyprland = {
        enable = true;

        package = null;
        portalPackage = null;

        plugins =
          (
            with inputs.hyprland-plugins.packages.${system};
            [ hyprfocus ] ++ optionals (cfgOverview == "hyprexpo") [ hyprexpo ]
          )
          ++ [ pkgs.hyprlandPlugins.hyprsplit ];
      };

      home.packages = builtins.attrValues {
        inherit (pkgs)
          hyprpicker
          brightnessctl
          ;
      };

      home.pointerCursor.hyprcursor.enable = true;

      programs.quickshell = mkIf (cfgOverview == "quickshell") {
        enable = true;
        systemd.enable = true;

        activeConfig = "overview";
        configs.overview = {
          source = ./overview;
        };
      };
    };
}
