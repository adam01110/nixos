_:
# Enable opencode plugins for agent behavior and notifications.
{
  programs.opencode.plugins = {
    unmoji.enable = true;
    cc-safety-net.enable = true;
    openslimedit.enable = true;
    dynamic-context-pruning.enable = true;
    changelog.enable = true;
    ignore.enable = true;
    quotes.enable = true;
    lazy-mcp.enable = true;

    notifier = {
      enable = true;
      settings.sound = false;
    };
  };
}
