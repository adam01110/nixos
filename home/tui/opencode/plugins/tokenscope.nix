{pkgs, ...}:
# Register tokenscope plugin.
let
  inherit (pkgs.nur.repos.adam0.opencodePlugins) tokenscope;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${tokenscope}"];
}
