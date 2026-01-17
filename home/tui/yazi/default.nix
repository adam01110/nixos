{pkgs, ...}:
# yazi tui file manager.
let
  inherit (builtins) attrValues;
in {
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
    ./theme.nix
  ];

  # add runtime helpers for yazi plugins.
  programs.yazi = {
    enable = true;

    package = pkgs.yazi.override {
      extraPackages = attrValues {
        inherit
          (pkgs)
          mediainfo
          wl-clipboard
          glow
          ;
      };
    };

    initLua = ./init.lua;

    shellWrapperName = "y";
  };
}
