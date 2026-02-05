{config, ...}: let
  picturesDir = config.xdg.userDirs.pictures;
in {
  # Wallpaper directory and rotation settings.
  programs.noctalia-shell.settings.wallpaper = {
    directory = "${picturesDir}/Wallpapers";
    overviewEnabled = true;
    panelPosition = "center";
    randomEnabled = true;
    randomIntervalSec = 7200;
    setWallpaperOnAllMonitors = true;
  };
}
