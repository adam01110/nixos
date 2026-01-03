{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (builtins)
    attrNames
    toJSON
    ;
  inherit (lib)
    mkEnableOption
    mkOption
    mkMerge
    genAttrs
    filterAttrs
    mapAttrs'
    ;
  inherit (lib.types)
    attrsOf
    anything
    submodule
    ;
  inherit (pkgs) fetchFromGitHub;

  cfg = config.noctalia.plugins;
  enabledPlugins = filterAttrs (_: plugin: plugin.enable) cfg;
  enabledNames = attrNames enabledPlugins;
  enabledSettings = lib.mapAttrs (_: plugin: plugin.settings) enabledPlugins;
in
{
  options.noctalia.plugins = mkOption {
    type = attrsOf (
      submodule (
        { name, ... }:
        {
          options = {
            enable = mkEnableOption "Enable the ${name} plugin.";

            settings = mkOption {
              type = attrsOf anything;
              default = { };
              description = "Settings for the ${name} plugin.";
            };
          };
        }
      )
    );
    default = { };
    description = "Noctalia plugins keyed by plugin name.";
  };

  config = {
    # keep the plugin settings file in sync with the enabled list.
    home.file = mkMerge [
      {
        ".config/noctalia/plugins" = {
          recursive = true;
          source = fetchFromGitHub {
            owner = "noctalia-dev";
            repo = "noctalia-plugins";
            rev = "8ef7e1762e3d5a48ce71716e503ecc9ffd1738e7";
            hash = "sha256-AM9y11GCGbufapubXAQlD6f2bN8f8MA/jtnPjyhlOJU=";
            sparseCheckout = enabledNames;
          };
        };

        ".config/noctalia/plugins.json".text = toJSON {
          sources = [
            {
              name = "Official Noctalia Plugins";
              url = "https://github.com/noctalia-dev/noctalia-plugins";
            }
          ];
          states = genAttrs enabledNames (_: {
            enabled = true;
          });
        };
      }
      (mapAttrs' (name: settings: {
        name = ".config/noctalia/plugins/${name}/settings.json";
        value.text = toJSON settings;
      }) enabledSettings)
    ];

    noctalia.plugins."privacy-indicator" = {
      enable = true;
      settings.hideInactive = true;
    };
  };
}
