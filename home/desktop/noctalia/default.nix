{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  # expose an enable toggle for battery widgets.
  options.noctalia.battery.enable = mkEnableOption "Enable the battery service & widgets.";

  # enable the Noctalia shell and wire up its package.
  config.programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    # enable calendar support in the flake-provided Noctalia build.
    packageOverrides = {
      calendarSupport = true;
    };

    # keep template generation under explicit control.
    settings.colorschemes.generateTemplatesForPredefined = false;
  };
}
