{
  config,
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.nur.repos.adam0.bibata-modern-cursors-gruvbox-dark-hyprcursor ];
  home.sessionVariables.HYPRCURSOR_THEME = config.stylix.cursor.name;
}
