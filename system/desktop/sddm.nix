{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib)
    concatStringsSep
    getExe'
    ;

  kwin = getExe' pkgs.kdePackages.kwin "kwin_wayland";
in
{
  environment.systemPackages = [
    pkgs.kdePackages.layer-shell-qt
    pkgs.kdePackages.kwin
  ];

  qt.enable = true;

  services.displayManager.sddm = {
    enable = true;

    wayland = {
      enable = true;
      compositor = "kwin";
      compositorCommand = concatStringsSep " " [
        "${kwin}"
        "--drm"
        "--no-global-shortcuts"
        "--no-kactivities"
        "--no-lockscreen"
        "--locale1"
      ];
    };
  };
}
