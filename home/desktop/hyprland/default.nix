{
  config,
  pkgs,
  ...
}:
# Home manager hyprland configuration: plugins, quickshell, and extras.
let
  inherit (builtins) attrValues;
in {
  # Make home manager session variables available to uwsm.
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  # Enable hyprland.
  wayland.windowManager.hyprland = {
    enable = true;

    # Packages are null because its installed sytem wide.
    package = null;
    portalPackage = null;

    # Add hyprfocus and hyprsplit plugins.
    plugins = attrValues {
      inherit
        (pkgs.hyprlandPlugins)
        hyprfocus
        hyprsplit
        ;
    };
  };

  # Add hyprpicker to packages.
  home.packages = [pkgs.hyprpicker];

  # Enable hyprcursor theme support.
  home.pointerCursor.hyprcursor.enable = true;

  programs = {
    # Enable quickshell.
    quickshell = {
      enable = true;
      systemd.enable = true;

      activeConfig = "overview";
      configs.overview = ./overview;
    };

    # Enable hyprshot for screenshotting with hyprland.
    hyprshot.enable = true;
  };
}
