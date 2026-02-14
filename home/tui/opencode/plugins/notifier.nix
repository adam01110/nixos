{pkgs, ...}:

# Register notifier plugin and config.
let
  jsonFormat = pkgs.formats.json {};

  notifier = pkgs.nur.repos.adam0.opencodePlugins.notifier;
in {
  # Register the plugin.
  programs.opencode.settings.plugin = ["file://${notifier}"];

  # Disable sounds in the plugin.
  xdg.configFile."opencode/opencode-notifier.json".source = jsonFormat.generate "opencode-notifier.json" {
    sound = false;
  };
}
