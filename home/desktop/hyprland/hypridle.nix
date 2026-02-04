{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
# configure hypridle timeouts, screen lock, and dpms.
let
  inherit
    (lib)
    getExe
    getExe'
    mkEnableOption
    optionals
    ;
in {
  # create a toggle for the suspend timeout.
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
        # command to invoke the lockscreen.
        lock_cmd = "${noctalia} lockScreen lock";
        # lock before suspend to avoid flashing unlocked session.
        before_sleep_cmd = "loginctl lock-session && ${noctalia} lockScreen lock";
        # wake display(s) after sleep.
        after_sleep_cmd = "${hyprctl} dispatch dpms on";
        # allow short inhibitions (e.g., video) before sleeping.
        inhibit_sleep = 3;
      };

      listener = let
        brightnessctl = getExe pkgs.brightnessctl;
      in
        [
          # dim screen brightness.
          {
            # 2.5min.
            timeout = 150;

            on-timeout = "${brightnessctl} - s set 10";
            on-resume = "${brightnessctl} - r";
          }
          # turn off keyboard backlight.
          {
            # 2.5min.
            timeout = 150;

            on-timeout = "${brightnessctl} -sd rgb:kbd_backlight set 0";
            on-resume = "${brightnessctl} -rd rgb:kbd_backlight";
          }
          # lock the session.
          {
            # 5min.
            timeout = 300;

            on-timeout = "loginctl lock-session";
          }
          # power off displays via dpms.
          {
            # 5.5min.
            timeout = 330;

            on-timeout = "${hyprctl} dispatch dpms off";
            on-resume = "${hyprctl} dispatch dpms on && ${brightnessctl} - r";
          }
        ]
        ++ optionals cfgSuspend [
          # suspend the system.
          {
            # 30min.
            timeout = 1800;

            on-timeout = "systemctl suspend";
          }
        ];
    };
  };
}
