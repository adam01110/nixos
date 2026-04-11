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
          "giphy-search"
          "github-feed"
          "kaomoji-provider"
          "keybind-cheatsheet"
          "privacy-indicator"
          "screen-recorder"
          "unicode-picker"
          "web-search"
          # keep-sorted end
          # ZED
          "zed-provider"
        ]
        mkPlugin;
    };

    # keep-sorted start block=yes newline_separated=yes
    # Provide runtime tools used by bundled plugins.
    packageOverrides.extraPackages = attrValues {
      inherit
        (pkgs)
        # keep-sorted start
        # screen-recorder
        gpu-screen-recorder
        # ZED
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

  # Render github-feed settings from sops.
  sops = {
    secrets = {
      # keep-sorted start
      "noctalia/giphy_key" = {};
      "noctalia/github_token" = {};
      # keep-sorted end
    };

    templates = let
      sopsVal = config.sops.placeholder;
    in {
      # keep-sorted start block=yes newline_separated=yes
      "noctalia-giphy-config".content = toJSON {
        # keep-sorted start
        api_key = sopsVal."noctalia/giphy_key";
        rating = "r";
        # keep-sorted end
      };

      "noctalia-github-config".content = toJSON {
        # keep-sorted start
        defaultTab = 1;
        enableSystemNotifications = true;
        maxEvents = 64;
        refreshInterval = 2000;
        token = sopsVal."noctalia/github_token";
        username = gitUsername;
        # keep-sorted end
      };
      # keep-sorted end
    };
  };

  xdg.configFile = {
    # keep-sorted start
    "noctalia/plugins/giphy-search/settings.json".source = mkOutOfStoreSymlink config.sops.templates."noctalia-giphy-config".path;
    "noctalia/plugins/github-feed/settings.json".source = mkOutOfStoreSymlink config.sops.templates."noctalia-github-config".path;
    # keep-sorted end
  };
  # keep-sorted end
}
