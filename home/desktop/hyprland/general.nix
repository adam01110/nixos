{
  config,
  lib,
  ...
}:
# Define hyprland options for touch and monitor layout.
let
  inherit
    (lib)
    attrNames
    filter
    head
    mkEnableOption
    mkIf
    mkMerge
    ;
in {
  options.hyprland.touch = {
    enable = mkEnableOption "Enable touch-specific configuration";
  };

  # Merge base settings and conditional sections.
  config = let
    cfgTouch = config.hyprland.touch.enable;
    cfgMonitors = config.hyprland.monitors;

    # Pick the output anchored at 0x0 for tablet mapping.
    tabletOutput = let
      candidates = filter (
        name: (cfgMonitors.${name}.position or null) == "0x0"
      ) (attrNames cfgMonitors);
    in
      head candidates;
  in
    mkMerge [
      {
        # Core defaults for input, rendering, and behavior.
        wayland.windowManager.hyprland.settings = {
          # Don't show a cursor icon when hovering over borders
          general.hover_icon_on_border = false;

          # Input preferences for mouse and touch.
          input = {
            mouse_refocus = false;
            accel_profile = "flat";

            # Swap caps lock and escape.
            kb_options = "caps:swapescape";

            touchdevice.enable = false;
          };

          # Map the virtual tablet device to the primary output.
          device = {
            name = "opentabletdriver-virtual-artist-tablet";
            transform = 0;
            output = tabletOutput;
          };

          # Renderer tweaks.
          render = {
            direct_scanout = 1;
            ctm_animation = 0;
          };

          # Keep xwayland windows scaled correctly.
          xwayland.force_zero_scaling = true;

          # Reduce noise from optional ecosystem features.
          ecosystem = {
            # No popups
            no_update_news = true;
            no_donation_nag = true;

            enforce_permissions = true;
          };

          # Suppress noisy logs and watchdog timeouts.
          debug = {
            suppress_errors = true;
            watchdog_timeout = 0;
          };

          # Misc toggles for branding, performance, and dpms.
          misc = {
            # Disable Hyprland branding visuals
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            force_default_wallpaper = 0;

            vrr = 1;
            middle_click_paste = false;
            render_unfocused_fps = 1;

            # Lockscreen monitor wakeup
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;

            enable_swallow = true;
            swallow_regex = "^(ghostty)$";

            # Open windows on the workspace they were invoked on
            initial_workspace_tracking = 2;

            # Wait longer until app not responding popup
            anr_missed_pings = 8;
          };

          dwindle.preserve_split = true;
        };
      }

      # Enable touchpad gestures and natural scroll when touch is on.
      (mkIf cfgTouch {
        wayland.windowManager.hyprland.settings = {
          input.touchpad.natural_scroll = true;

          gesture = ["3, horizontal, workspace"];
        };
      })
    ];
}
