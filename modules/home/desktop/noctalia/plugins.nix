{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  inherit
    (builtins)
    toJSON
    attrValues
    ;
  inherit (lib) genAttrs;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (vars) gitUsername;

  inherit (config.xdg) configHome;
  videosDir = config.xdg.userDirs.videos;
in {
  programs.noctalia-shell = {
    plugins = let
      noctaliaPluginsUrl = "https://github.com/noctalia-dev/noctalia-plugins";
    in {
      version = 2;

      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = noctaliaPluginsUrl;
        }
      ];

      states = let
        mkPlugin = _name: {
          enabled = true;
          sourceUrl = noctaliaPluginsUrl;
        };
      in
        genAttrs [
          "screen-recorder"
          "kaomoji-provider"
          "unicode-picker"
          "github-feed"
          "privacy-indicator"
          "keybind-cheatsheet"
          "file-search"
          "web-search"
          "zed-provider"
        ]
        mkPlugin;
    };

    pluginSettings = {
      screen-recorder = {
        directory = "${videosDir}/Recordings";
        videoCodec = "hevc";
        copyToClipboard = true;
      };

      keybind-cheatsheet = {
        hyprlandConfigPath = "${configHome}/hypr/keybinds.conf";
        columnCount = 4;
      };

      file-search.maxResults = 200;

      web-search = {
        search_engine = "Brave";
        max_results = 5;
      };
    };

    settings.plugins.autoUpdate = true;

    # Package for screen-recorder plugin.
    packageOverrides.extraPackages = attrValues {
      inherit
        (pkgs)
        # screen-recorder
        gpu-screen-recorder
        # zed-provider
        sqlite
        ;
    };
  };

  # The noctalia github feed plugin settings.
  sops = {
    secrets."noctalia/github_token" = {};

    templates."noctalia-github-config".content = toJSON {
      username = gitUsername;
      token = config.sops.placeholder."noctalia/github_token";
      refreshInterval = 2000;
      maxEvents = 64;
      enableSystemNotifications = true;
      defaultTab = 1;
    };
  };

  xdg.configFile."noctalia/plugins/github-feed/settings.json".source = mkOutOfStoreSymlink config.sops.templates."noctalia-github-config".path;
}
