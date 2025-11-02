{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) mkForce;
in
{
  home.packages = [ pkgs.nur.repos.adam0.bibata-modern-cursors-gruvbox-dark-hyprcursor ];
  home.sessionVariables.HYPRCURSOR_THEME = mkForce "${config.stylix.cursor.name}-hyprcursor";
}
