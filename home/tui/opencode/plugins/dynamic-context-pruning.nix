{pkgs, ...}:

# Register dynamic-context-pruning plugin.
let
  dynamicContextPruning = pkgs.nur.repos.adam0.opencodePlugins.dynamic-context-pruning;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${dynamicContextPruning}"];
}
