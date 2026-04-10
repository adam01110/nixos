{
  # keep-sorted start
  config,
  lib,
  pkgs,
  vars,
  # keep-sorted end
  ...
}:
# Text-based greeter (greetd + tuigreet).
let
  inherit
    (lib)
    # keep-sorted start
    getExe
    getExe'
    # keep-sorted end
    ;
  inherit (vars) username;

  tomlFormat = pkgs.formats.toml {};
in {
  # keep-sorted start block=yes newline_separated=yes
  environment = {
    etc."tuigreet/config.toml".source = let
      # keep-sorted start
      hyprland = getExe' config.programs.hyprland.package "start-hyprland";
      uwsm = getExe config.programs.uwsm.package;
      # keep-sorted end
    in
      tomlFormat.generate "tuigreet-config.toml" {
        session = {
          command = "${uwsm} start -eD Hyprland -- ${hyprland}";
          sessions_dirs = [];
          xsessions_dirs = [];
        };

        display = {
          show_time = true;
          greeting = "authentication required.";
          time_format = "%Y-%m-%d %H:%M:%S";
        };

        remember = {
          username = true;
          default_user = username;
        };

        secret.mode = "characters";

        layout = {
          # keep-sorted start
          container_padding = 1;
          prompt_padding = 1;
          window_padding = 1;
          # keep-sorted end
        };

        power = {
          use_setsid = false;
          shutdown = "systemctl poweroff";
          reboot = "systemctl reboot";
        };

        theme = {
          # keep-sorted start
          action = "white";
          border = "blue";
          button = "green";
          container = "black";
          greet = "white";
          input = "white";
          prompt = "blue";
          text = "white";
          time = "green";
          title = "white";
          # keep-sorted end
        };
      };
  };

  services.greetd = {
    enable = true;

    # Extra required tweaks for tty greeters with greetd, do not touch.
    useTextGreeter = true;

    # Start tuigreet.
    settings.default_session.command = getExe pkgs.tuigreet;
  };
  # keep-sorted end
}
