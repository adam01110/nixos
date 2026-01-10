{...}: {
  programs.opencode.settings = {
    model = "minimax/minimax-m2.1";

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
