{pkgs, ...}:
# Register openslimedit plugin.
let
  inherit (pkgs.nur.repos.adam0.opencodePlugins) openslimedit;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${openslimedit}"];
}
