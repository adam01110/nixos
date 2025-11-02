{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    concatStringsSep
    getExe'
    ;
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
        "${getExe' pkgs.kdePackages.kwin "kwin_wayland"}"
        "--drm"
        "--no-global-shortcuts"
        "--no-kactivities"
        "--no-lockscreen"
        "--locale1"
      ];
    };
  };
}
