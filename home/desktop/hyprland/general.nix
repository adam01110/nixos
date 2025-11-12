{
  config,
  lib,
  ...
}:

# define hyprland options for touch and monitor layout.
let
  inherit (lib)
    mapAttrsToList
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;
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
        Example:
        monitors = {
          "DP-1" = {
            resolution = "2560x1440@170";
            position = "0x0";
            scale = 1;
            transform = 0;  # optional: 0-7 for rotation
            mirror = "DP-2";  # optional: mirror another display
            bitdepth = 10;  # optional: 10-bit color
            cm = "wide";  # optional: color management preset
            sdrbrightness = 1.2;  # optional: SDR brightness in HDR mode
            sdrsaturation = 0.98;  # optional: SDR saturation in HDR mode
            vrr = 1;  # optional: variable refresh rate mode
          };
        };
      '';
    };
  };

  # merge base settings and conditional sections.
  config =
    let
      cfgTouch = config.hyprland.touch.enable;
      cfgMonitors = config.hyprland.monitors;
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
        };
      }

      # enable touchpad gestures and natural scroll when touch is on.
      (mkIf cfgTouch {
        wayland.windowManager.hyprland.settings = {
          input.touchpad.natural_scroll = true;

          gesture = [ "3, horizontal, workspace" ];
        };
      })

      # format monitor declarations from the option set.
      (mkIf (cfgMonitors != { }) {
        wayland.windowManager.hyprland.settings = {
          monitor =
            let
              formatMonitor =
                name: cfg:
                let
                  base = "${name}, ${cfg.resolution}, ${cfg.position}, ${toString cfg.scale}";

                  # optional parameters.
                  transform =
                    if (cfg.transform or null) != null then ", transform, ${toString cfg.transform}" else "";
                  mirror = if (cfg.mirror or null) != null then ", mirror, ${cfg.mirror}" else "";
                  bitdepth = if (cfg.bitdepth or null) != null then ", bitdepth, ${toString cfg.bitdepth}" else "";
                  cm = if (cfg.cm or null) != null then ", cm, ${cfg.cm}" else "";
                  sdrbrightness =
                    if (cfg.sdrbrightness or null) != null then
                      ", sdrbrightness, ${toString cfg.sdrbrightness}"
                    else
                      "";
                  sdrsaturation =
                    if (cfg.sdrsaturation or null) != null then
                      ", sdrsaturation, ${toString cfg.sdrsaturation}"
                    else
                      "";
                  vrr = if (cfg.vrr or null) != null then ", vrr, ${toString cfg.vrr}" else "";
                in
                base + transform + mirror + bitdepth + cm + sdrbrightness + sdrsaturation + vrr;

              formattedMonitors = mapAttrsToList formatMonitor cfgMonitors;
            in
            formattedMonitors;
        };
      })
    ];
}
