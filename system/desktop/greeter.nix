{
  pkgs,
  lib,
  inputs,
  system,
  ...
}:

let
  inherit (lib)
    concatStringsSep
    getExe
    ;
in
{
  services.greetd = {
    enable = true;
    useTextGreeter = true;

    settings = {
      default_session = {
        command =
          let
            tuigreet = getExe pkgs.tuigreet;
            hyprland = getExe inputs.hyprland.packages.${system}.hyprland;
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
}
