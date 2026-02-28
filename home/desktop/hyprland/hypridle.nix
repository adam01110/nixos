{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# Configure hypridle timeouts, screen lock, and dpms.
let
  inherit
    (lib)
    getExe
    getExe'
    mkEnableOption
    optionals
    ;
in {
  options.hyprland = {
    # Create a toggle for brightness dimming and restore actions.
    idle.brightness.enable = mkEnableOption "Enable hypridle brightness dimming actions.";

    # Create a toggle for the suspend timeout.
    suspend.enable = mkEnableOption "Enable hypridle suspend timeout.";
  };

  config.services.hypridle = {
    enable = true;

    settings = let
      cfgBrightness = config.hyprland.idle.brightness.enable;
      cfgSuspend = config.hyprland.suspend.enable;

      hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";
      noctalia = "${getExe' config.programs.noctalia-shell.package "noctalia-shell"} ipc call";
    in {
      general = {
        # Command to invoke the lockscreen.
        lock_cmd = "${noctalia} lockScreen lock";
        # Lock before suspend to avoid flashing unlocked session.
        before_sleep_cmd = "${noctalia} lockScreen lock";
        # Wake display(s) after sleep.
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
        # Allow short inhibitions (e.g., video) before sleeping.
        inhibit_sleep = 3;
      };

      listener = let
        brightnessctl = getExe pkgs.brightnessctl;
      in
        optionals cfgBrightness [
          # Dim screen brightness.
          {
            # 2.5 minutes.
            timeout = 150;

            on-timeout = "${brightnessctl} - s set 10";
            on-resume = "${brightnessctl} - r";
          }
          # Turn off keyboard backlight brightness.
          {
            # 2.5 minutes.
            timeout = 150;

            on-timeout = "${brightnessctl} -sd rgb:kbd_backlight set 0";
            on-resume = "${brightnessctl} -rd rgb:kbd_backlight";
          }
        ]
        ++ [
          # Lock the session.
          {
            # 5 minutes.
            timeout = 300;

            on-timeout = "${noctalia} lockScreen lock";
          }
          # Power off displays via dpms.
          {
            # 5.5 minutes.
            timeout = 330;

            on-timeout = "${hyprctl} dispatch dpms off";
            on-resume = "${hyprctl} dispatch dpms on && ${brightnessctl} - r";
          }
        ]
        ++ optionals cfgSuspend [
          # Suspend the system.
          {
            # 8 minutes.
            timeout = 480;

            on-timeout = "systemctl suspend";
          }
        ];
    };
  };
}
