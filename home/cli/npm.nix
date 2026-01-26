{config, ...}:
# configure npm cli to use XDG base directories for globals and logs.
let
  inherit
    (config.xdg)
    dataHome
    configHome
    stateHome
    cacheHome
    ;
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
