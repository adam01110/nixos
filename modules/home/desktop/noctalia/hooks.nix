{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (lib) getExe;
  inherit (pkgs) callPackage;
in {
  programs.noctalia-shell.settings.hooks = let
    performantMode = getExe (callPackage ../../../../pkgs/scripts/performant-mode.nix {});
  in {
    enabled = true;

    # keep-sorted start
    performanceModeDisabled = performantMode;
    performanceModeEnabled = performantMode;
    # keep-sorted end
  };
}
