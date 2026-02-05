{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  # Expose an enable toggle for battery widgets.
  options.noctalia.battery.enable = mkEnableOption "Enable the battery service & widgets.";

  # Enable the Noctalia shell and wire up its package.
  config.programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    # Enable calendar support in the flake-provided Noctalia build.
    packageOverrides = {
      calendarSupport = true;
    };

    # Keep template generation under explicit control.
    settings.colorschemes.generateTemplatesForPredefined = false;
  };
}
