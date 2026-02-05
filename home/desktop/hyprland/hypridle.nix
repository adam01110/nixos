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
  # Create a toggle for the suspend timeout.
  options.hyprland.suspend.enable = mkEnableOption "Enable hypridle suspend timeout.";

  config.services.hypridle = {
    enable = true;

    settings = let
      cfgSuspend = config.hyprland.suspend.enable;
      hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";
    in {
      general = let
        noctalia = "${getExe' config.programs.noctalia-shell.package "noctalia-shell"} ipc call";
      in {
        # Command to invoke the lockscreen.
        lock_cmd = "${noctalia} lockScreen lock";
        # Lock before suspend to avoid flashing unlocked session.
        before_sleep_cmd = "loginctl lock-session && ${noctalia} lockScreen lock";
        # Wake display(s) after sleep.
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
        # Allow short inhibitions (e.g., video) before sleeping.
        inhibit_sleep = 3;
      };

      listener = let
        brightnessctl = getExe pkgs.brightnessctl;
      in
        [
          # Dim screen brightness.
          {
            # 2.5min.
            timeout = 150;

            on-timeout = "${brightnessctl} - s set 10";
            on-resume = "${brightnessctl} - r";
          }
          # Turn off keyboard backlight.
          {
            # 2.5min.
            timeout = 150;

            on-timeout = "${brightnessctl} -sd rgb:kbd_backlight set 0";
            on-resume = "${brightnessctl} -rd rgb:kbd_backlight";
          }
          # Lock the session.
          {
            # 5min.
            timeout = 300;

            on-timeout = "loginctl lock-session";
          }
          # Power off displays via dpms.
          {
            # 5.5min.
            timeout = 330;

            on-timeout = "${hyprctl} dispatch dpms off";
            on-resume = "${hyprctl} dispatch dpms on && ${brightnessctl} - r";
          }
        ]
        ++ optionals cfgSuspend [
          # Suspend the system.
          {
            # 30min.
            timeout = 1800;

            on-timeout = "systemctl suspend";
          }
        ];
    };
  };
}
