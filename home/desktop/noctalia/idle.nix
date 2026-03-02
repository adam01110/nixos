{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (builtins) toJSON;
  inherit
    (lib)
    getExe
    mkEnableOption
    mkIf
    optionalAttrs
    ;

  cfg = config.noctalia.idle;
  brightnessctl = getExe pkgs.brightnessctl;
in {
  options.noctalia.idle = {
    brightness.enable = mkEnableOption "Enable noctalia idle brightness dimming actions.";
    suspend.enable = mkEnableOption "Enable noctalia idle suspend timeout.";
  };

  config.programs.noctalia-shell.settings.audio =
    {
      enabled = true;

      lockTimeout = 300;
      screenOffTimeout = 330;

      customCommands = mkIf cfg.brightness.enable (toJSON [
        {
          name = "Dim screen brightness";
          timeout = 150;
          command = "${brightnessctl} -s set 10";
          resumeCommand = "${brightnessctl} -r";
        }
        {
          name = "Turn off keyboard backlight brightness";
          timeout = 150;
          command = "${brightnessctl} -sd rgb:kbd:backlight set 0";
          resumeCommand = "${brightnessctl} -rd rgb:kbd:backlight";
        }
      ]);
    }
    // optionalAttrs cfg.suspend.enable {
      suspendTimeout = 480;
    };
}
