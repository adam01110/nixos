{lib, ...}: let
  inherit (lib) mkForce;
in {
  stylix.targets.opencode.enable = true;

  # Keep the opencode background transparent to match stylix.
  programs.opencode.themes.stylix.theme.background = {
    dark = mkForce "none";
    light = mkForce "none";
  };
}
