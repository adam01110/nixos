_:
# configure atuin shell history manager.
{
  programs.atuin = {
    enable = true;

    daemon = {
      # TODO(adam0): decide when to enable the daemon.
      # enable = true;
      logLevel = "error";
    };

    settings = {
      auto_sync = false;
      update_check = false;

      style = "full";
      invert = true;
      show_help = false;
      inline_height = 24;
      show_tabs = false;

      # TODO(adam0): set sync address when ready.
      #sync_address = "";
      sync_frequency = 600;
    };
  };
}
