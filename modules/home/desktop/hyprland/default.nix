{
  config,
  pkgs,
  ...
}:
# Home manager hyprland configuration: plugins, quickshell, and extras.
{
  # keep-sorted start block=yes newline_separated=yes
  # Install hyprpicker for the color-pick keybind.
  home.packages = [pkgs.hyprpicker];

  # Enable hyprcursor theme support.
  home.pointerCursor.hyprcursor.enable = true;

  # Enable hyprshot for screenshotting with hyprland.
  programs.hyprshot.enable = true;

  # Enable hyprland.
  wayland.windowManager.hyprland = {
    enable = true;

    # Packages are null because its installed sytem wide.
    package = null;
    portalPackage = null;
  };

  # Make home manager session variables available to uwsm.
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
  # keep-sorted end
}
