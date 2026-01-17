{config, ...}:
# configure npm cli to use XDG base directories for globals and logs.
let
  inherit (config.xdg) dataHome;
  inherit (config.xdg) configHome;
  inherit (config.xdg) stateHome;
  inherit (config.xdg) cacheHome;
in {
  programs.npm = {
    enable = true;
    package = null;

    # route npm paths to XDG paths instead of ~/.npm.
    settings = {
      prefix = "${dataHome}/npm";
      cache = "${cacheHome}/npm";
      init-module = "${configHome}/npm/config/npm-init.js";
      logs-dir = "${stateHome}/npm/logs";
    };
  };
}
