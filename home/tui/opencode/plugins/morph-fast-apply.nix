{pkgs, ...}:
# Register morph-fast-apply plugin and instructions.
let
  morphFastApply = pkgs.nur.repos.adam0.opencodePlugins.morph-fast-apply;
in {
  # Register the plugin and its usage instructions.
  programs.opencode.settings = {
    plugin = ["file://${morphFastApply}"];
    instructions = ["${morphFastApply}/MORPH_INSTRUCTIONS.md"];
  };
}
