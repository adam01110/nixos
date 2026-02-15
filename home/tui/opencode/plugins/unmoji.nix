{pkgs, ...}:
# Register unmoji plugin.
let
  inherit (pkgs.nur.repos.adam0.opencodePlugins) unmoji;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${unmoji}"];
}
