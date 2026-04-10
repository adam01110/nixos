{lib, ...}: let
  inherit (lib) mkForce;
in {
  # keep-sorted start block=yes newline_separated=yes
  # Keep the opencode background transparent to match stylix.
  programs.opencode.themes.stylix.theme.background = {
    # keep-sorted start
    dark = mkForce "none";
    light = mkForce "none";
    # keep-sorted end
  };

  stylix.targets.opencode.enable = true;
  # keep-sorted end
}
