{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "qs -c noctalia-shell ipc call lockScreen toggle";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        inhibit_sleep = 3;
      };

      listener = [
        {
          # 2.5min.
          timeout = 150;

          on-timeout = "brightnessctl - s set 10";
          on-resume = "brightnessctl - r";
        }
        {
          # 2.5min.
          timeout = 150;

          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
          on-resume = "brightnessctl -rd rgb:kbd_backlight";
        }
        {
          # 5min
          timeout = 300;

          on-timeout = "loginctl lock-session";
        }
        {
          # 5.5min
          timeout = 330;

          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on && brightnessctl - r";
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
