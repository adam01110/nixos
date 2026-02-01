{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  # pull in per-feature Noctalia modules.
  imports = [
    ./audio.nix
    ./bar.nix
    ./brightness.nix
    ./calendar.nix
    ./controlcenter.nix
    ./delobotomize.nix
    ./dock.nix
    ./general.nix
    ./hooks.nix
    ./launcher.nix
    ./location.nix
    ./network.nix
    ./notifications.nix
    ./plugins.nix
    ./sessionmenu.nix
    ./systemmonitor.nix
    ./ui.nix
    ./wallpaper.nix
  ];

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
