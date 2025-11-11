{
  # home manager hyprland configuration: plugins, quickshell, and extras.
  config,
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

  # make hm's session variables available to uwsm.
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  wayland.windowManager.hyprland = {
    enable = true;

    package = null;
    portalPackage = null;

    plugins = with inputs; [
      hyprland-plugins.packages.${system}.hyprfocus
      hyprsplit.packages.${system}.hyprsplit
    ];
  };

  # useful desktop utilities.
  home.packages = attrValues {
    inherit (pkgs)
      hyprpicker
      brightnessctl
      ;
  };

  home.pointerCursor.hyprcursor.enable = true;

  # enable quickshell and add qt5compat for compatibility.
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
