{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  home.preferXdgDirectories = true;

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  home.sessionVariables = {
    RUSTICL_ENABLE = "radeonsi";
  };
}
