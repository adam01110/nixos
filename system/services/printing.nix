{pkgs, ...}:
# enable cups printing service.
let
  inherit (builtins) attrValues;
in {
  services.printing = {
    enable = true;
    openFirewall = true;

    # disable the web interface.
    webInterface = false;

    # printer drivers packages.
    drivers = attrValues {
      inherit
        (pkgs)
        foomatic-db-ppds
        foomatic-db-ppds-withNonfreeDb
        gutenprint
        gutenprint-bin
        splix
        ;
    };

    # enable network printer discovery and share local queues by default.
    browsing = true;
    defaultShared = true;
  };

  # enable some fonts for ghostscript.
  fonts.enableGhostscriptFonts = true;
}
