{
  lib,
  osConfig,
  pkgs,
  ...
}:
# Performance mode hooks for noctalia shell.
let
  inherit (lib) getExe;
  inherit (pkgs) callPackage;
in {
  programs.noctalia-shell.settings.hooks = let
    performantMode = callPackage ../hyprland/scripts/_performant-mode.nix {inherit osConfig;};
  in {
    enabled = true;

    performanceModeDisabled = "${getExe performantMode} --no-notify";
    performanceModeEnabled = "${getExe performantMode} --no-notify";
  };
}
