{
  config,
  osConfig,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

# configure hypridle timeouts, screen lock, and dpms.
let
  inherit (lib)
    getExe
    getExe'
    mkEnableOption
    optionals
    ;
in
{
  # create a toggle for the suspend timeout.
  options.hyprland.suspend.enable = mkEnableOption "Enable hypridle suspend timeout.";

  config.services.hypridle = {
    enable = true;

    settings =
      let
        cfgSuspend = config.hyprland.suspend.enable;
        hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";
      in
      {
        general = {
          # command to invoke the lockscreen.
          lock_cmd =
            let
              noctalia = "${getExe' inputs.noctalia.packages.${system}.default "noctalia-shell"} ipc call";
            in
            "${noctalia} lockScreen lock";
          # lock before suspend to avoid flashing unlocked session.
          before_sleep_cmd = "loginctl lock-session";
          # wake display(s) after sleep.
          after_sleep_cmd = "${hyprctl} dispatch dpms on";
          # allow short inhibitions (e.g., video) before sleeping.
          inhibit_sleep = 3;
        };

        listener =
          let
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
