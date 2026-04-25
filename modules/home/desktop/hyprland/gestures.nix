{
  # keep-sorted start
  config,
  lib,
  # keep-sorted end
  ...
}: let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    mkEnableOption
    mkIf
    # keep-sorted end
    ;

  # keep-sorted start
  noctalia = "${getExe' config.programs.noctalia-shell.package "noctalia-shell"} ipc call";
  overzicht = getExe config.programs.overzicht.package;
  # keep-sorted end
in {
  options.hyprland.touch.enable = mkEnableOption "Enable touch-specific configuration";

  config = mkIf config.hyprland.touch.enable {
    # Enable touchpad gestures and natural scroll when touch is on.
    wayland.windowManager.hyprland.settings = {
      gesture = [
        "3, horizontal, workspace"

        # keep-sorted start
        "3, down, dispatcher, exec, ${noctalia} launcher close"
        "3, up, dispatcher, exec, ${noctalia} launcher open"
        # keep-sorted end

        # keep-sorted start
        "3, pinchin, dispatcher, exec, ${overzicht} ipc call overview open"
        "3, pinchout, dispatcher, exec, ${overzicht} ipc call overview close"
        # keep-sorted end
      ];

      # keep-sorted start
      input.touchpad.natural_scroll = true;
      # keep-sorted end
    };
  };
}
