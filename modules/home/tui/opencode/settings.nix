_:
# Tune opencode ui and permissions defaults.
{
  programs.opencode.settings = {
    # keep-sorted start block=yes newline_separated=yes
    autoupdate = false;

    tui = {
      scroll_acceleration.enabled = true;
      diff_style = "stacked";
    };

    watcher.ignore = [
      # keep-sorted start
      ".direnv/**"
      ".git/**"
      "dist/**"
      "node_modules/**"
      "target/**"
      # keep-sorted end
    ];
    # keep-sorted end

    # keep-sorted start
    agent.explore.reasoningEffort = "medium";
    agent.general.reasoningEffort = "medium";
    # keep-sorted end
  };
}
