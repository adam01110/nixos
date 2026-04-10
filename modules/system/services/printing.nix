{pkgs, ...}:
# Enable cups printing service.
let
  inherit (builtins) attrValues;
in {
  services.printing = {
    enable = true;
    # Allow network clients to reach cups.
    openFirewall = true;

    # Disable the web interface.
    webInterface = false;

    # Printer drivers packages.
    drivers = attrValues {
      inherit
        (pkgs)
        # keep-sorted start
        foomatic-db-ppds
        foomatic-db-ppds-withNonfreeDb
        gutenprint
        gutenprint-bin
        splix
        # keep-sorted end
        ;
    };

    # Enable network printer discovery and share local queues by default.
    browsing = true;
    defaultShared = true;
  };

  # Enable some fonts for ghostscript.
  fonts.enableGhostscriptFonts = true;
}
