{pkgs, ...}:

# Register md-table-formatter plugin.
let
  mdTableFormatter = pkgs.nur.repos.adam0.opencodePlugins.md-table-formatter;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${mdTableFormatter}"];
}
