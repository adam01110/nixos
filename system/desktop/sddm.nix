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
      compositorCommand =
        let
          kwin = getExe' pkgs.kdePackages.kwin "kwin_wayland";
        in
        concatStringsSep " " [
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
