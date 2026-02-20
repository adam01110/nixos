{pkgs, ...}:
# Register cc-safety-net plugin.
let
  inherit (pkgs.nur.repos.adam0.opencodePlugins) changelog;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${changelog}"];
}
