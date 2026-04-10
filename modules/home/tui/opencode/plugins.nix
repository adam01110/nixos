_: {
  programs.opencode.plugins = {
    # keep-sorted start
    cc-safety-net.enable = true;
    changelog.enable = true;
    dynamic-context-pruning.enable = true;
    ignore.enable = true;
    lazy-mcp.enable = true;
    openslimedit.enable = true;
    unmoji.enable = true;
    # keep-sorted end

    # keep-sorted start block=yes newline_separated=yes
    auto-resume = {
      enable = true;

      settings = {
        # keep-sorted start
        loopMaxContinues = 4;
        maxRetries = 4;
        # keep-sorted end
      };
    };

    notifier = {
      enable = true;
      settings.sound = false;
    };
    # keep-sorted end
  };
}
