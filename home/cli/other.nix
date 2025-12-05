{
  osConfig,
  lib,
  pkgs,
  ...
}:

# install additional utilities.
let
  inherit (builtins) attrValues;
  inherit (lib) optional;

  cfgBluetooth = osConfig.optServices.bluetooth.enable;
  cfgWifi = osConfig.optServices.wifi.enable;
in
{
  # enable the nix-index-database integration with comma.
  programs.nix-index-database.comma.enable = true;

  # bundle general-purpose cli tools.
  home.packages =
    attrValues {
      inherit (pkgs)
        gitfetch
        speedtest-go
        sshfs
        tokei
        ;
    }
    # wifi helpers: captures logs and connection info.
    ++ optional cfgWifi pkgs.impala

    # bluetooth tui for quick device toggles.
    ++ optional cfgBluetooth pkgs.bluetui;

  programs = {
    # enable ripgrep for fast recursive search.
    ripgrep.enable = true;

    # enable nix-index for finding packages that provide commands.
    nix-index.enable = true;
  };
}
