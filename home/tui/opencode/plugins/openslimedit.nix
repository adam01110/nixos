{pkgs, ...}:
# Register cc-safety-net plugin.
let
  OpenSlimedit = pkgs.nur.repos.adam0.opencodePlugins.openslimedit;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${OpenSlimedit}"];
}
