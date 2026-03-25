{config, ...}:
# Configure atuin shell history.
let
  inherit (config.xdg) cacheHome;
in {
  programs.atuin = let
    logLevel = "error";
  in {
    enable = true;
    forceOverwriteSettings = true;

    daemon = {
      enable = true;
      inherit logLevel;
    };

    settings = {
      update_check = false;
      search-mode = "daemon-fuzzy";

      style = "full";
      invert = true;
      show_help = false;
      inline_height = 24;
      show_tabs = false;

      dir = "${cacheHome}/atuin/logs";
      level = logLevel;

      history_filter = [
        ''(^|[[:space:]])(export[[:space:]]+)?[A-Z_][A-Z0-9_]*(_TOKEN|_SECRET|_PASSWORD|_PASSWD|_API_KEY|_ACCESS_KEY|_SECRET_ACCESS_KEY)(="[^"]+"|=[^[:space:]]+)''
        ''(^|[[:space:]])--?(token|secret|password|passwd|api[-_]?key|access[-_]?key|client[-_]?secret)(=|[[:space:]]+)''
        ''(sk-[A-Za-z0-9_-]{20,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|glpat-[A-Za-z0-9_-]{20,}|AKIA[0-9A-Z]{16})''
      ];

      # TODO(adam0): set sync address when ready.
      # sync_address = "";
      sync_frequency = 600;
    };
  };
}
