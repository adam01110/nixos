{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (lib) mkForce;
in {
  # Install and export the Hyprcursor theme selected by Stylix.
  home = {
    # keep-sorted start block=yes newline_separated=yes
    # Install the selected hyprcursor theme package.
    packages = [pkgs.nur.repos.adam0.bibata-modern-cursors-gruvbox-dark-hyprcursor];

    # Export hyprcursor theme name via environment variable.
    sessionVariables.HYPRCURSOR_THEME = mkForce "${config.stylix.cursor.name}-hyprcursor";
    # keep-sorted end
  };
}
