{
  config,
  ...
}:

# enable and export xdg user directory paths.
let
  dataHome = config.xdg.dataHome;
  configHome = config.xdg.configHome;
  cacheHome = config.xdg.stateHome;
  stateHome = config.xdg.stateHome;

  desktopDir = config.xdg.userDirs.desktop;
  documentsDir = config.xdg.userDirs.document;
  downloadDir = config.xdg.userDirs.download;
  musicDir = config.xdg.userDirs.music;
  picturesDir = config.xdg.userDirs.pictures;
  publicShareDir = config.xdg.userDirs.publicShare;
  templatesDir = config.xdg.userDirs.templates;
  videosDir = config.xdg.userDirs.videos;
in
{
  xdg.userDirs.enable = true;

  home.sessionVariables = {
    XDG_CONFIG_HOME = "${configHome}";
    XDG_CACHE_HOME = "${cacheHome}";
    XDG_DATA_HOME = "${dataHome}";
    XDG_STATE_HOME = "${stateHome}";

    XDG_DESKTOP_DIR = "${desktopDir}";
    XDG_DOCUMENTS_DIR = "${documentsDir}";
    XDG_DOWNLOAD_DIR = "${downloadDir}";
    XDG_MUSIC_DIR = "${musicDir}";
    XDG_PICTURES_DIR = "${picturesDir}";
    XDG_PUBLICSHARE_DIR = "${publicShareDir}";
    XDG_TEMPLATES_DIR = "${templatesDir}";
    XDG_VIDEOS_DIR = "${videosDir}";
  };
}
