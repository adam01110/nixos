{
  pkgs,
  inputs,
  system,
  ...
}:

let
  inherit (builtins) attrValues;
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

  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    plugins = with inputs; [
      hyprland-plugins.packages.${system}.hyprfocus
      hyprsplit.packages.${system}.hyprsplit
    ];
  };

  home.packages = attrValues {
    inherit (pkgs)
      hyprpicker
      brightnessctl
      ;
  };

  home.pointerCursor.hyprcursor.enable = true;

  programs.quickshell = {
    enable = true;
    systemd.enable = true;

    package = pkgs.quickshell.overrideAttrs (prev: {
      buildInputs = (prev.buildInputs or [ ]) ++ [ pkgs.qt6Packages.qt5compat ];
    });

    activeConfig = "overview";
    configs.overview = ./overview;
  };
}
