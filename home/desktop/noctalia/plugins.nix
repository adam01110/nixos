{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  inherit (builtins) toJSON;
  inherit (lib) genAttrs;
  inherit (config.lib.file) mkOutOfStoreSymlink;

  inherit (vars) gitUsername;

  videosDir = config.xdg.userDirs.videos;
in {
  programs.noctalia-shell.plugins = let
    noctaliaPluginsUrl = "https://github.com/noctalia-dev/noctalia-plugins";
  in {
    version = 1;

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
      ]
      mkPlugin;

    pluginSettings = {
      privacy-indicator.hideInactive = true;

      screen-recorder = {
        directory = "${videosDir}/Recordings";
        videoCodec = "hevc";
        copyToClipboard = true;
      };
    };
  };

  # the noctalia github feed plugin settings
  sops = {
    secrets."noctalia_github_token" = {};

    templates."noctalia_github_config".content = toJSON {
      username = gitUsername;
      token = config.sops.placeholder."noctalia_github_token";
      refreshInterval = 2000;
      maxEvents = 64;
    };
  };

  xdg.configFile."noctalia/plugins/github-feed/settings.json".source = mkOutOfStoreSymlink config.sops.templates."noctalia_github_config".path;

  # packages for screen-recorder.
  home.packages = [pkgs.gpu-screen-recorder];
}
