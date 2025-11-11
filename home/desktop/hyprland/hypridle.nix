{
  osConfig,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

let
  inherit (lib)
    getExe
    getExe'
    ;
in
{
  services.hypridle = {
    enable = true;

    settings =
      let
        hyprctl = getExe' osConfig.programs.hyprland.package "hyprctl";
      in
      {
        general = {
          lock_cmd =
            let
              noctalia = "${getExe' inputs.noctalia.packages.${system}.default "noctalia-shell"} ipc call";
            in
            "${noctalia} lockScreen lock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "${hyprctl} dispatch dpms on";
          inhibit_sleep = 3;
        };

        listener =
          let
            brightnessctl = getExe pkgs.brightnessctl;
          in
          [
            {
              # 2.5min.
              timeout = 150;

              on-timeout = "${brightnessctl} - s set 10";
              on-resume = "${brightnessctl} - r";
            }
            {
              # 2.5min.
              timeout = 150;

              on-timeout = "${brightnessctl} -sd rgb:kbd_backlight set 0";
              on-resume = "${brightnessctl} -rd rgb:kbd_backlight";
            }
            {
              # 5min
              timeout = 300;

              on-timeout = "loginctl lock-session";
            }
            {
              # 5.5min
              timeout = 330;

              on-timeout = "${hyprctl} dispatch dpms off";
              on-resume = "${hyprctl} dispatch dpms on && ${brightnessctl} - r";
            }
            {
              # 30min
              timeout = 1800;

              on-timeout = "systemctl suspend";
            }
          ];
      };
  };
}
