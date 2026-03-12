_:
# Tune opencode ui and permissions defaults.
{
  programs.opencode.settings = {
    autoupdate = false;

    tui.diff_style = "stacked";

    watcher.ignore = [
      ".git/**"
      ".direnv/**"
      "node_modules/**"
      "dist/**"
      "target/**"
    ];

    agent.general.reasoningEffort = "medium";
    agent.explore.reasoningEffort = "medium";
  };
}
