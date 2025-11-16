{
  config,
  ...
}:

let
  picturesDir = config.xdg.userDirs.pictures;
in
{
  # wallpaper directory and rotation settings.
  programs.noctalia-shell.settings.wallpaper = {
    directory = "${picturesDir}/Wallpapers";
    enableMultiMonitorDirectories = false;
    enabled = true;
    overviewEnabled = true;
    panelPosition = "center";
    randomEnabled = true;
    randomIntervalSec = 14400;
    recursiveSearch = false;
    setWallpaperOnAllMonitors = true;
    transitionDuration = 1500;
    transitionEdgeSmoothness = 0.05;
    transitionType = "random";
    useWallhaven = false;
  };
}
