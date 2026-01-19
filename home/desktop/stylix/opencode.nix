{lib, ...}: let
  inherit (lib) mkForce;
in {
  stylix.targets.opencode.enable = true;

  programs.opencode.themes.stylix.theme.background = {
    dark = mkForce "none";
    light = mkForce "none";
  };
}
