{pkgs, ...}:
# Register plugins from a single name list.
let
  inherit (builtins) getAttr;

  pluginSet = pkgs.nur.repos.adam0.opencodePlugins;
  pluginNames = [
    "unmoji"
    "cc-safety-net"
    "openslimedit"
    "dynamic-context-pruning"
    "changelog"
  ];
in {
  programs.opencode.settings.plugin = map (name: "file://${getAttr name pluginSet}") pluginNames;
}
