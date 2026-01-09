{
  config,
  lib,
  ...
}:
# define hyprland options for touch and monitor layout.
let
  inherit
    (lib)
    mkEnableOption
    mkIf
    mkMerge
    ;
in {
  options.hyprland.touch = {
    enable = mkEnableOption "Enable touch-specific configuration";
  };

  # merge base settings and conditional sections.
  config = let
    cfgTouch = config.hyprland.touch.enable;
  in
    mkMerge [
      {
        # core defaults for input, rendering, and behavior.
        wayland.windowManager.hyprland.settings = {
          # don't show a cursor icon when hovering over borders
          general.hover_icon_on_border = false;

          # input preferences for mouse and touch.
          input = {
            mouse_refocus = false;
            accel_profile = "flat";

            touchdevice.enable = false;
          };

          # renderer tweaks.
          render = {
            direct_scanout = 0;
            ctm_animation = 0;
          };

          # keep xwayland windows scaled correctly.
          xwayland.force_zero_scaling = true;

          # reduce noise from optional ecosystem features.
          ecosystem = {
            # no popups
            no_update_news = true;
            no_donation_nag = true;

            enforce_permissions = true;
          };

          # suppress noisy logs and watchdog timeouts.
          debug = {
            suppress_errors = true;
            watchdog_timeout = 0;
          };

          # misc toggles for branding, performance, and dpms.
          misc = {
            # disable Hyprland branding visuals
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            force_default_wallpaper = 0;

            vrr = 1;
            middle_click_paste = false;
            render_unfocused_fps = 1;

            # lockscreen monitor wakeup
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;

            enable_swallow = true;
            swallow_regex = "^(ghostty)$";

            # open windows on the workspace they were invoked on
            initial_workspace_tracking = 2;

            # wait longer until app not responding popup
            anr_missed_pings = 8;
          };

          dwindle.preserve_split = true;
        };
      }

      # enable touchpad gestures and natural scroll when touch is on.
      (mkIf cfgTouch {
        wayland.windowManager.hyprland.settings = {
          input.touchpad.natural_scroll = true;

          gesture = ["3, horizontal, workspace"];
        };
      })
    ];
}
