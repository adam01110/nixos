{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
# TODO: everything
let
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
  };
in
{
  environment.systemPackages = [
    pkgs.layer-shell-qt
    pkgs.kdePackages.kwin
    sddm-theme
  ];

  qt.enable = true;

  services.displayManager.sddm = {
    enable = true;

    package = pkgs.kdePackages.sddm;
    extraPackages = sddm-theme.propagatedBuildInputs;

    theme = sddm-theme.pname;
    settings = {
      General = {
        DisplayServer = "wayland";
        GreeterEnvironment = "QT_WAYLAND_SHELL_INTEGRATION=layer-shell,QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
      };
    };

    Wayland.CompositorCommand = "kwin_wayland --drm --no-lockscreen --no-global-shortcuts --locale1 --inputmethod qtvirtualkeyboard";
  };
}
