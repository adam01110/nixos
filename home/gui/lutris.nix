{
  osConfig,
  pkgs,
  ...
}:
# Configure lutris and integrate with steam packages.
let
  bluetoothEnabled = osConfig.optServices.bluetooth.enable;
  inherit (osConfig.programs) steam;
in {
  config.programs.lutris = {
    enable = true;

    package = pkgs.lutris.override {
      inherit bluetoothEnabled;
      steamSupport = true;
    };

    # Add umu launcher for proton outside of steam.
    extraPackages = [pkgs.umu-launcher] ++ steam.extraPackages;

    # Proton and the package of steam form the system steam module.
    steamPackage = steam.package;
    protonPackages = steam.extraCompatPackages;
  };
}
