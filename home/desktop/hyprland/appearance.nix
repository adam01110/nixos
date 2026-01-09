{lib, ...}:
# set hyprland appearance, gaps, decoration, and animations.
let
  inherit (lib) mkMerge;
in {
  wayland.windowManager.hyprland.settings = mkMerge [
    {
      # general outer and inner gaps and active border color.
      general = {
        gaps_in = 4;
        gaps_out = 4;
      };

      # window decoration options including blur and shadow.
      decoration = {
        rounding = 0;

        active_opacity = 0.95;
        inactive_opacity = 0.95;

        blur = {
          popups = true;
          input_methods = true;

          size = 16;
          passes = 2;
        };

        shadow = {
          range = 16;
          render_power = 2;
          scale = 2;
        };
      };

      # enable smooth resize and window dragging animations.
      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
      };

      # animation curves used by plugins and window transitions.
      bezier = [
        # hyprfocus beziers.
        "focusIn 0.25, 0.46, 0.45, 0.94"
        "focusOut, 0.0, 0.5, 0.5, 1.0"

        "objIn, 0.19, 1.00, 0.22, 1.00"
        "objOut, 0.45, 0.05, 0.55, 0.95"

        "fadeObjIn, 0.5, 0.5, 0.75, 1.0"
        "fadeObjOut, 0.32, 0.74, 0.70, 0.82"

        "fadeGeneric, 0.00,0.00,0.20,1.00"
        "smoothSlide, 0.5, 1.15, 0.4, 1"
      ];

      # map animation groups to specific curves and speeds.
      animations.animation = [
        # hyprfocus.
        "hyprfocusIn, 1, 0.75, focusIn"
        "hyprfocusOut, 1, 3, focusOut"

        # window.
        "windows, 1, 4, objIn, popin"
        "windowsIn, 1, 3, objIn, popin"
        "windowsOut, 1, 1, objOut, popin"

        "fade, 1, 3.03, fadeGeneric"
        "fadeIn, 1, 1.73, fadeObjIn"
        "fadeOut, 1, 1, fadeObjOut"

        # layer.
        "layers, 1, 4, objIn, popin"
        "layersIn, 1, 3, objIn, popin"
        "layersOut, 1, 1, objOut, popin"

        "fadeLayersIn, 1, 1.73, fadeObjIn"
        "fadeLayersOut, 1, 1, fadeObjOut"

        # popups.
        "fadePopupsIn, 1, 1.73, fadeObjIn"
        "fadePopupsOut, 1, 1, fadeObjOut"

        # workspaces.
        "workspaces, 1, 3.5, smoothSlide, slide"

        # disable.
        "border, 0"
        "borderangle, 0"
      ];
    }
  ];

  # style hints for applications that read hypr conf snippets.
  xdg.configFile."hypr/application-style.conf".text = ''
    roundness=2
  '';
}
