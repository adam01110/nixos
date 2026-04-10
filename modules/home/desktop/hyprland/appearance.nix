_:
# Set hyprland appearance, gaps, decoration, and animations.
{
  wayland.windowManager.hyprland.settings = {
    # keep-sorted start block=yes newline_separated=yes
    # Map animation groups to specific curves and speeds.
    animations.animation = [
      # Hyprfocus.
      # keep-sorted start
      "hyprfocusIn, 1, 0.75, focusIn"
      "hyprfocusOut, 1, 3, focusOut"
      # keep-sorted end

      # Window.
      # keep-sorted start
      "windows, 1, 4, objIn, popin"
      "windowsIn, 1, 3, objIn, popin"
      "windowsOut, 1, 1, objOut, popin"
      # keep-sorted end

      # keep-sorted start
      "fade, 1, 3.03, fadeGeneric"
      "fadeIn, 1, 1.73, fadeObjIn"
      "fadeOut, 1, 1, fadeObjOut"
      # keep-sorted end

      # Layer.
      # keep-sorted start
      "layers, 1, 4, objIn, popin"
      "layersIn, 1, 3, objIn, popin"
      "layersOut, 1, 1, objOut, popin"
      # keep-sorted end

      # keep-sorted start
      "fadeLayersIn, 1, 1.73, fadeObjIn"
      "fadeLayersOut, 1, 1, fadeObjOut"
      # keep-sorted end

      # Popups.
      # keep-sorted start
      "fadePopupsIn, 1, 1.73, fadeObjIn"
      "fadePopupsOut, 1, 1, fadeObjOut"
      # keep-sorted end

      # Workspaces.
      # keep-sorted start
      "specialWorkspace, 1, 3.5, smoothSlide, slidefadevert -50%"
      "workspaces, 1, 3.5, smoothSlide, slide"
      # keep-sorted end

      # Disable.
      # keep-sorted start
      "border, 0"
      "borderangle, 0"
      # keep-sorted end
    ];

    # Animation curves used by plugins and window transitions.
    bezier = [
      # Hyprfocus beziers.
      # keep-sorted start
      "focusIn 0.25, 0.46, 0.45, 0.94"
      "focusOut, 0.0, 0.5, 0.5, 1.0"
      # keep-sorted end

      # keep-sorted start
      "objIn, 0.19, 1.00, 0.22, 1.00"
      "objOut, 0.45, 0.05, 0.55, 0.95"
      # keep-sorted end

      # keep-sorted start
      "fadeObjIn, 0.5, 0.5, 0.75, 1.0"
      "fadeObjOut, 0.32, 0.74, 0.70, 0.82"
      # keep-sorted end

      # keep-sorted start
      "fadeGeneric, 0.00,0.00,0.20,1.00"
      "smoothSlide, 0.5, 1.15, 0.4, 1"
      # keep-sorted end
    ];

    # Window decoration options including blur and shadow.
    decoration = {
      rounding = 0;

      # keep-sorted start
      active_opacity = 0.95;
      inactive_opacity = 0.95;
      # keep-sorted end

      # keep-sorted start block=yes newline_separated=yes
      blur = {
        # keep-sorted start
        input_methods = true;
        popups = true;
        # keep-sorted end

        # keep-sorted start
        passes = 2;
        size = 16;
        # keep-sorted end
      };

      shadow = {
        # keep-sorted start
        range = 16;
        render_power = 2;
        scale = 2;
        # keep-sorted end
      };
      # keep-sorted end
    };

    # General outer and inner gaps and active border color.
    general = {
      # keep-sorted start
      gaps_in = 4;
      gaps_out = 4;
      # keep-sorted end
    };

    # Enable smooth resize and window dragging animations.
    misc = {
      # keep-sorted start
      animate_manual_resizes = true;
      animate_mouse_windowdragging = true;
      # keep-sorted end
    };
    # keep-sorted end
  };

  # Style hints for applications that read hypr conf snippets.
  xdg.configFile."hypr/application-style.conf".text = ''
    roundness=0
  '';
}
