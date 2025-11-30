{
  lib,
  pkgs,
  ...
}:

# install wiremix.
let
  inherit (lib) getExe;

  pkg = pkgs.wiremix;
in
{
  home.packages = [ pkg ];

  # create desktop entry to allow launching via launcher.
  xdg.desktopEntries.wiremix = {
    name = "Wiremix";
    genericName = "Pipewire Volume Control";
    icon = "multimedia-volume-control";
    exec = getExe pkg;
    terminal = true;
    categories = [
      "Audio"
      "System"
      "Settings"
      "Mixer"
    ];
  };
}
