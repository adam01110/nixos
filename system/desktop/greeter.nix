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
    ;
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
            tuigreet = getExe pkgs.tuigreet;
            hyprland = getExe config.programs.hyprland.package;
          in
          concatStringsSep " " [
            "${tuigreet}"
            "--no-xsession-wrapper"
            "--asterisks"
            "--time"
            "--time-format '%Y-%m-%d %H:%M:%S'"
            "--remember"
            "--user-menu"
            "--cmd ${hyprland}"
          ];
      };
    };
  };

  # ensure tuigreet is present system-wide.
  systemPackages = [ pkgs.tuigreet ];
}
