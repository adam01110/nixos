{
  config,
  lib,
  ...
}:
# Format hyprland monitor declarations.
let
  inherit
    (lib)
    mapAttrsToList
    mkOption
    types
    ;
in {
  options.hyprland.monitors = mkOption {
    type = types.attrsOf (types.attrsOf types.anything);
    default = {};
    description = ''
      Example:
      monitors = {
        "DP-1" = {
          resolution = "2560x1440@170";
          position = "0x0";
          scale = 1;
          disabled = false;  # optional: disable the monitor when true
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

  # Format monitor declarations from the option set.
  config.wayland.windowManager.hyprland.settings.monitor = let
    cfgMonitors = config.hyprland.monitors;

    formatMonitor = name: cfg: let
      # Allow disabled monitors without resolution/position/scale.
      disabledLine = "${name}, disabled";
      base = "${name}, ${cfg.resolution}, ${cfg.position}, ${toString cfg.scale}";

      # Optional parameters.
      transform =
        if (cfg.transform or null) != null
        then ", transform, ${toString cfg.transform}"
        else "";
      mirror =
        if (cfg.mirror or null) != null
        then ", mirror, ${cfg.mirror}"
        else "";
      bitdepth =
        if (cfg.bitdepth or null) != null
        then ", bitdepth, ${toString cfg.bitdepth}"
        else "";
      cm =
        if (cfg.cm or null) != null
        then ", cm, ${cfg.cm}"
        else "";
      sdrbrightness =
        if (cfg.sdrbrightness or null) != null
        then ", sdrbrightness, ${toString cfg.sdrbrightness}"
        else "";
      sdrsaturation =
        if (cfg.sdrsaturation or null) != null
        then ", sdrsaturation, ${toString cfg.sdrsaturation}"
        else "";
      vrr =
        if (cfg.vrr or null) != null
        then ", vrr, ${toString cfg.vrr}"
        else "";
    in
      if cfg.disabled or false
      then disabledLine
      else base + transform + mirror + bitdepth + cm + sdrbrightness + sdrsaturation + vrr;

    formattedMonitors = mapAttrsToList formatMonitor cfgMonitors;
  in
    formattedMonitors;
}
