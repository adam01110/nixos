{
  # keep-sorted start
  config,
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
# Set the hyprcursor theme.
let
  inherit (lib) mkForce;
in {
  home = {
    # keep-sorted start block=yes newline_separated=yes
    # Install the selected hyprcursor theme package.
    packages = [pkgs.nur.repos.adam0.bibata-modern-cursors-gruvbox-dark-hyprcursor];

    # Export hyprcursor theme name via environment variable.
    sessionVariables.HYPRCURSOR_THEME = mkForce "${config.stylix.cursor.name}-hyprcursor";
    # keep-sorted end
  };
}
