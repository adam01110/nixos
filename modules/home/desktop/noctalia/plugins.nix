{
  # keep-sorted start
  config,
  lib,
  pkgs,
  vars,
  # keep-sorted end
  ...
}: let
  inherit
    (builtins)
    # keep-sorted start
    attrValues
    toJSON
    # keep-sorted end
    ;
  inherit (lib) genAttrs;
  inherit (config.lib.file) mkOutOfStoreSymlink;
  inherit (vars) gitUsername;

  inherit (config.xdg) configHome;
  videosDir = config.xdg.userDirs.videos;
in {
  # keep-sorted start block=yes newline_separated=yes
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
          # keep-sorted start
          "file-search"
          "github-feed"
          "kaomoji-provider"
          "keybind-cheatsheet"
          "privacy-indicator"
          "screen-recorder"
          "unicode-picker"
          "web-search"
          "zed-provider"
          # keep-sorted end
        ]
        mkPlugin;
    };

    # keep-sorted start block=yes newline_separated=yes
    # Package for screen-recorder plugin.
    packageOverrides.extraPackages = attrValues {
      inherit
        (pkgs)
        # keep-sorted start
        # screen-recorder
        gpu-screen-recorder
        # zed-provider
        sqlite
        # keep-sorted end
        ;
    };

    pluginSettings = {
      # keep-sorted start block=yes newline_separated=yes
      file-search.maxResults = 200;

      keybind-cheatsheet = {
        # keep-sorted start
        columnCount = 4;
        hyprlandConfigPath = "${configHome}/hypr/keybinds.conf";
        # keep-sorted end
      };

      screen-recorder = {
        # keep-sorted start
        copyToClipboard = true;
        directory = "${videosDir}/Recordings";
        videoCodec = "hevc";
        # keep-sorted end
      };

      web-search = {
        # keep-sorted start
        max_results = 5;
        search_engine = "Brave";
        # keep-sorted end
      };
      # keep-sorted end
    };

    settings.plugins.autoUpdate = true;
    # keep-sorted end
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
  # keep-sorted end
}
