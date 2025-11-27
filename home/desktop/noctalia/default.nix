{
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

{
  imports = [
    ./audio.nix
    ./bar.nix
    ./brightness.nix
    ./calendar.nix
    ./controlcenter.nix
    ./dock.nix
    ./general.nix
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

  options.noctalia.battery.enable = lib.mkEnableOption "Enable the battery service & widgets.";

  config.programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    package = inputs.noctalia.packages.${system}.default;

    settings.colorschemes.generateTemplatesForPredefined = false;
  };
}
