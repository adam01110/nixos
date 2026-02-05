{config, ...}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;

  inherit
    (config.xdg)
    dataHome
    configHome
    stateHome
    ;
in {
  # GET OUT OF MY $HOME!
  home.sessionVariables = {
    # history.
    LESSHISTFILE = "${stateHome}/less/history";
    HISTFILE = "${stateHome}/bash/history";

    # keep ffmpeg config under xdg config home.
    FFMPEG_DATADIR = "${configHome}/ffmpeg";

    # rust toolchains.
    CARGO_HOME = "${dataHome}/cargo";
    RUSTUP_HOME = "${dataHome}/rustup";

    # javascript toolchains.
    BUN_INSTALL = "${dataHome}/bun";
    NODE_REPL_HISTORY = "${dataHome}/node_repl_history";

    # java toolschains.
    GRADLE_USER_HOME = "${dataHome}/gradle";
    MAVEN_OPTS = "-Dmaven.repo.local=${dataHome}/maven/repository";
    MAVEN_ARGS = "--settings ${configHome}/maven/settings.xml";

    # gaming.
    RENPY_PATH_TO_SAVES = "${dataHome}/renpy";
    RENPY_MULTIPERSISTENT = "${dataHome}/renpy_shared";
    WINEPREFIX = "${dataHome}/wineprefixes/default";
  };

  # keep renpy saves under xdg data and expose legacy path.
  home.file.".renpy".source = mkOutOfStoreSymlink "${dataHome}/renpy";
}
