{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgTouch = config.hyprland.touch.enable;
  cfgMonitors = config.hyprland.monitors;
in
{
  options.hyprland = {
    touch = {
      enable = mkEnableOption "Enable touch-specific configuration";
    };

    monitors = mkOption {
      type = types.attrsOf (types.attrsOf types.anything);
      default = { };
      description = ''
        Monitor configuration using monitorv2 format.
        Example:
        monitors = {
          "DP-1" = {
            resolution = "2560x1440@170";
            position = "0x0";
            scale = 1;
          };
        };
      '';
    };
  };

  wayland.windowManager.hyprland.settings = {
    # don't show a cursor icon when hovering over borders
    general.hover_icon_on_border = false;

    input = {
      mouse_refocus = false;
      accel_profile = "flat";

      touchdevice.enable = false;
    };

    render = {
      direct_scanout = 0;
      ctm_animation = 0;
    };

    xwayland.force_zero_scaling = true;

    ecosystem = {
      # no popups
      no_update_news = true;
      no_donation_nag = true;

      enforce_permissions = true;
    };

    debug = {
      suppress_errors = true;
      watchdog_timeout = 0;
    };

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
  };

  config = mkMerge [
    (mkIf cfgTouch {
      wayland.windowManager.hyprland.settings = {
        input.touchpad.natural_scroll = true;

        gesture = [ "3, horizontal, workspace" ];
      };
    })

    (mkIf (cfgMonitors != { }) {
      wayland.windowManager.hyprland.settings = {
        monitor = cfgMonitors;
      };
    })
  ];
}
