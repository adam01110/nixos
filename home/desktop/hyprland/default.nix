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
  # compose hyprland configuration from module segments.
  imports = [
    ./appearance.nix
    ./hypridle.nix
    ./keybinds.nix
    ./general.nix
    ./plugins.nix
    ./rules.nix
  ];

  # make home manager session variables available to uwsm.
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  # enable hyprland.
  wayland.windowManager.hyprland = {
    enable = true;

    # packages are null because its installed sytem wide.
    package = null;
    portalPackage = null;

    # add hyprfocus and hyprsplit plugins.
    plugins = with inputs; [
      hyprland-plugins.packages.${system}.hyprfocus
      hyprsplit.packages.${system}.hyprsplit
    ];
  };

  # add hyprpicker to packages.
  home.packages = [ pkgs.hyprpicker ];

  # enable hyprcursor theme support.
  home.pointerCursor.hyprcursor.enable = true;

  programs = {
    # enable quickshell.
    quickshell = {
      enable = true;
      systemd.enable = true;

      # add qt5compat the overview.
      package = pkgs.quickshell.overrideAttrs (prev: {
        buildInputs = (prev.buildInputs or [ ]) ++ [ pkgs.qt6Packages.qt5compat ];
      });

      activeConfig = "overview";
      configs.overview = ./overview;
    };

    # enable hyprshot for screenshotting with hyprland.
    hyprshot.enable = true;
  };
}
