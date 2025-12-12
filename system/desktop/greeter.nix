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
            hyprland = getExe config.programs.hyprland.package;
          in
          concatStringsSep " " [
            "${tuigreet}"
            "--no-xsession-wrapper"
            "--asterisks"
            "--time"
            "--time-format '%Y-%m-%d %H:%M:%S'"
            "--remember"
            "--remember-user-session"
            "--user-menu"
            "--cmd ${hyprland}"
          ];
      };
    };
  };

  # ensure tuigreet is present system-wide.
  environment.systemPackages = [ pkg ];
}
