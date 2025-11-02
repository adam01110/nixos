{ ... }:

{
  programs.atuin = {
    enable = true;

    daemon = {
      # TODO
      #enable = true;
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

      # TODO
      #sync_address = "";
      sync_frequency = 600;
    };
  };
}
