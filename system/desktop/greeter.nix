{
  config,
  pkgs,
  lib,
  ...
}:

# text-based greeter (greetd + tuigreet).
let
  inherit (lib)
    concatStringsSep
    getExe
    getExe'
    ;

  pkg = pkgs.tuigreet;
in
{
  services.greetd = {
    enable = true;

    # extra required tweaks for tty greeters with greetd, do not touch.
    useTextGreeter = true;

    settings = {
      default_session = {
        command =
          let
            tuigreet = getExe pkg;
            uwsm = getExe config.programs.uwsm.package;
            hyprland = getExe' config.programs.hyprland.package "start-hyprland";
          in
          concatStringsSep " " [
            "${tuigreet}"
            "--no-xsession-wrapper"
            "--asterisks"
            "--time"
            "--time-format '%Y-%m-%d %H:%M:%S'"
            "--remember"
            "--user-menu"
            "--cmd '${uwsm} start -F -eD Hyprland -- ${hyprland}'"
          ];
      };
    };
  };

  # ensure tuigreet is present system-wide.
  environment.systemPackages = [ pkg ];
}
