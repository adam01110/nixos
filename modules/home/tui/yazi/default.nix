_: {
  # Yazi tui file manager.
  programs.yazi = {
    enable = true;

    initLua = ./init.lua;

    shellWrapperName = "y";
  };
}
