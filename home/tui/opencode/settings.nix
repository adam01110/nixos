_:
# Tune opencode ui and permissions defaults.
{
  programs.opencode.settings = {
    autoupdate = false;

    tui.diff_style = "stacked";

    permission = {
      webfetch = "ask";
      todoread = "ask";
    };

    watcher.ignore = [
      ".git/**"
      ".direnv/**"
      "node_modules/**"
      "dist/**"
      "target/**"
    ];
  };
}
