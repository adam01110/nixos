{
  config,
  ...
}:

let
  dataHome = config.xdg.dataHome;
  configHome = config.xdg.configHome;
  stateHome = config.xdg.stateHome;
in
{
  home.sessionVariables = {
    LESSHISTFILE = "${stateHome}/less/history";
    HISTFILE = "${stateHome}/bash/history";

    RIPGREP_CONFIG_PATH = "${configHome}/ripgrep/config";
    FFMPEG_DATADIR = "${configHome}/ffmpeg";

    CARGO_HOME = "${dataHome}/cargo";
    RUSTUP_HOME = "${dataHome}/rustup";
    BUN_INSTALL = "${dataHome}/bun";

    RENPY_PATH_TO_SAVES = "${dataHome}/renpy";
    RENPY_MULTIPERSISTENT = "${dataHome}/renpy_shared";
    WINEPREFIX = "${dataHome}/wineprefixes/default";
  };
}
