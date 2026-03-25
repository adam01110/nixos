{
  config,
  pkgs,
  lib,
  vars,
  ...
}:
# Text-based greeter (greetd + tuigreet).
let
  inherit
    (lib)
    getExe
    getExe'
    ;
  inherit (vars) username;

  tomlFormat = pkgs.formats.toml {};
in {
  services.greetd = {
    enable = true;

    # Extra required tweaks for tty greeters with greetd, do not touch.
    useTextGreeter = true;

    # Start tuigreet.
    settings.default_session.command = getExe pkgs.tuigreet;
  };

  environment = {
    etc."tuigreet/config.toml".source = let
      uwsm = getExe config.programs.uwsm.package;
      hyprland = getExe' config.programs.hyprland.package "start-hyprland";
    in
      tomlFormat.generate "tuigreet-config.toml" {
        session = {
          command = "${uwsm} start -eD Hyprland -- ${hyprland}";
          sessions_dirs = [];
          xsessions_dirs = [];
        };

        display = {
          show_time = true;
          time_format = "%Y-%m-%d %H:%M:%S";
          greeting = "ready when you are.";
        };

        remember = {
          default_user = username;
          username = true;
        };

        secret.mode = "characters";

        layout = {
          window_padding = 1;
          container_padding = 1;
          prompt_padding = 1;
        };

        power = {
          shutdown = "systemctl poweroff";
          reboot = "systemctl reboot";
          use_setsid = false;
        };

        theme = {
          border = "blue";
          text = "white";
          time = "green";
          container = "black";
          title = "white";
          greet = "white";
          prompt = "blue";
          input = "white";
          action = "white";
          button = "green";
        };
      };
  };

  # Ensure tuigreet is present system-wide.
  environment.systemPackages = [pkgs.tuigreet];
}
