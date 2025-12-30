{
  lib,
  inputs,
  system,
  ...
}:

# configure the Noctalia shell and related widgets.
{
  # pull in per-feature Noctalia modules.
  imports = [
    ./audio.nix
    ./bar.nix
    ./brightness.nix
    ./calendar.nix
    ./controlcenter.nix
    ./dock.nix
    ./general.nix
    ./hooks.nix
    ./launcher.nix
    ./location.nix
    ./network.nix
    ./notifications.nix
    ./osd.nix
    ./screenrecorder.nix
    ./sessionmenu.nix
    ./systemmonitor.nix
    ./ui.nix
    ./wallpaper.nix
  ];

  # expose an enable toggle for battery widgets.
  options.noctalia.battery.enable = lib.mkEnableOption "Enable the battery service & widgets.";

  # enable the Noctalia shell and wire up its package.
  config.programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    # use the flake-provided Noctalia build.
    package = inputs.noctalia.packages.${system}.default;

    # keep template generation under explicit control.
    settings.colorschemes.generateTemplatesForPredefined = false;
  };
}
