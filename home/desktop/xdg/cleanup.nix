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
  # consolidate tool state under xdg paths to keep $HOME clean.
  home.sessionVariables = {
    # history.
    LESSHISTFILE = "${stateHome}/less/history";
    HISTFILE = "${stateHome}/bash/history";

    FFMPEG_DATADIR = "${configHome}/ffmpeg";

    # rust toolchain metadata directories.
    CARGO_HOME = "${dataHome}/cargo";
    RUSTUP_HOME = "${dataHome}/rustup";
    BUN_INSTALL = "${dataHome}/bun";

    # gaming.
    RENPY_PATH_TO_SAVES = "${dataHome}/renpy";
    RENPY_MULTIPERSISTENT = "${dataHome}/renpy_shared";
    WINEPREFIX = "${dataHome}/wineprefixes/default";
  };
}
