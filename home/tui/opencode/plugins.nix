{...}: let
  inherit (builtins) toJSON;
in {
  programs.opencode.settings.plugin = [
    "@simonwjackson/opencode-direnv"
    "@mohak34/opencode-notifier@latest"
  ];

  xdg.configFile."opencode/opencode-notifier.json".text = toJSON {sound = false;};
}
