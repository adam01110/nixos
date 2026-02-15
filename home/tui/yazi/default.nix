{pkgs, ...}:
# Yazi tui file manager.
let
  inherit (builtins) attrValues;
in {
  # Add runtime helpers for yazi plugins.
  programs.yazi = {
    enable = true;

    package = pkgs.yazi.override {
      extraPackages = attrValues {
        inherit
          (pkgs)
          mediainfo
          wl-clipboard
          glow
          trash-cli
          ;
      };
    };

    initLua = ./init.lua;

    shellWrapperName = "y";
  };
}
