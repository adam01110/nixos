{
  config,
  lib,
  ...
}:
# Home manager hyprland configuration: plugins, quickshell, and extras.
let
  inherit (lib) getExe;
in {
  # Make home manager session variables available to uwsm.
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  # Enable hyprland.
  wayland.windowManager.hyprland = {
    enable = true;

    # Packages are null because its installed sytem wide.
    package = null;
    portalPackage = null;

    settings.exec-once = let
      app2unit = "${getExe config.programs.noctalia-shell.app2unit.package} --";
      ghostty = "${getExe config.programs.ghostty.package} --initial-window=false +new-window";
    in ["${app2unit} ${ghostty}"];
  };

  # Enable hyprcursor theme support.
  home.pointerCursor.hyprcursor.enable = true;

  # Enable hyprshot for screenshotting with hyprland.
  programs.hyprshot.enable = true;
}
