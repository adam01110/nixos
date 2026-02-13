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
    performantMode = getExe (callPackage ../hyprland/scripts/_performant-mode.nix {inherit osConfig;});
  in {
    enabled = true;

    performanceModeDisabled = performantMode;
    performanceModeEnabled = performantMode;
  };
}
