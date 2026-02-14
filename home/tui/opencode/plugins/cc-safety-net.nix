{pkgs, ...}:

# Register cc-safety-net plugin.
let
  ccSafetyNet = pkgs.nur.repos.adam0.opencodePlugins.cc-safety-net;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${ccSafetyNet}"];
}
