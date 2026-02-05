{
  config,
  pkgs,
  lib,
  ...
}:
# Set the hyprcursor theme.
let
  inherit (lib) mkForce;
in {
  # Install the selected hyprcursor theme package.
  home.packages = [pkgs.nur.repos.adam0.bibata-modern-cursors-gruvbox-dark-hyprcursor];
  # Export hyprcursor theme name via environment variable.
  home.sessionVariables.HYPRCURSOR_THEME = mkForce "${config.stylix.cursor.name}-hyprcursor";
}
