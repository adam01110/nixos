{config, ...}: let
  picturesDir = config.xdg.userDirs.pictures;
in {
  # Wallpaper directory and rotation settings.
  programs.noctalia-shell.settings.wallpaper = {
    directory = "${picturesDir}/Wallpapers";
    overviewEnabled = true;
    panelPosition = "center";
    randomIntervalSec = 7200;
    setWallpaperOnAllMonitors = true;
    transitionType = "stripes";
    skipStartupTransition = true;
    showHiddenFiles = true;
    hideWallpaperFilenames = true;
  };
}
