{pkgs, ...}:
# Register unmoji plugin.
let
  unmoji = pkgs.nur.repos.adam0.opencodePlugins.unmoji;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${unmoji}"];
}
