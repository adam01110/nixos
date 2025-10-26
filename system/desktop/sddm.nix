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
    GetExe'
    ;

  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
  };
in
{
  environment.systemPackages = [
    pkgs.kdePackages.layer-shell-qt
    pkgs.kdePackages.kwin
    sddm-theme
  ];

  qt.enable = true;

  services.displayManager.sddm = {
    enable = true;

    extraPackages = sddm-theme.propagatedBuildInputs;

    theme = sddm-theme.pname;

    wayland = {
      enable = true;
      compositor = "kwin";
      compositorCommand = concatStringsSep " " [
        "${GetExe' pkgs.kdePackages.kwin "kwin_wayland"}"
        "--drm"
        "--no-global-shortcuts"
        "--no-kactivities"
        "--no-lockscreen"
        "--locale1"
        "--inputmethod qtvirtualkeyboard"
      ];
    };

    settings.General.GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell,QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
  };
}
