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
    # History.
    LESSHISTFILE = "${stateHome}/less/history";
    HISTFILE = "${stateHome}/bash/history";

    # Keep ffmpeg config under xdg config home.
    FFMPEG_DATADIR = "${configHome}/ffmpeg";

    # Rust toolchains.
    CARGO_HOME = "${dataHome}/cargo";
    RUSTUP_HOME = "${dataHome}/rustup";

    # Javascript toolchains.
    BUN_INSTALL = "${dataHome}/bun";
    NODE_REPL_HISTORY = "${dataHome}/node_repl_history";

    # Java toolschains.
    GRADLE_USER_HOME = "${dataHome}/gradle";
    MAVEN_OPTS = "-Dmaven.repo.local=${dataHome}/maven/repository";
    MAVEN_ARGS = "--settings ${configHome}/maven/settings.xml";

    # Gaming.
    RENPY_PATH_TO_SAVES = "${dataHome}/renpy";
    RENPY_MULTIPERSISTENT = "${dataHome}/renpy_shared";
    WINEPREFIX = "${dataHome}/wineprefixes/default";
  };

  # Keep renpy saves under xdg data and expose legacy path.
  home.file.".renpy".source = mkOutOfStoreSymlink "${dataHome}/renpy";
}
