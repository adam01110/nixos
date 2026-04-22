_: {
  programs.opencode.plugins = {
    # keep-sorted start
    cc-safety-net.enable = true;
    changelog.enable = true;
    dynamic-context-pruning.enable = true;
    ignore.enable = true;
    lazy-mcp.enable = true;
    unmoji.enable = true;
    # keep-sorted end

    notifier = {
      enable = true;
      settings.sound = false;
    };
  };
}
