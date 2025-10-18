{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ nur.repos.adam0.bibata-cursors-gruvbox-hyprcursor ];
  home.sessionVariables.HYPRCURSOR_THEME = config.stylix.cursor.name;
}
