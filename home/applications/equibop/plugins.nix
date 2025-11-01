{
  config,
  lib,
  vars,
  equibopStylix,
  ...
}:

let
  inherit (lib) foldl' mkEnableOption;
  inherit (vars) userCountry;

  cfgCamera = config.equibop.camera.enable;

  pluginArgs = {
    inherit cfgCamera userCountry;
    stylix = equibopStylix;
  };

  pluginFiles = [
    ./plugins/core.nix
    ./plugins/communication.nix
    ./plugins/interface.nix
    ./plugins/media.nix
    ./plugins/social.nix
    ./plugins/integrations.nix
  ];

  mergedPlugins = foldl' (acc: file: acc // (import file pluginArgs)) { } pluginFiles;
in
{
  options.equibop.camera.enable = mkEnableOption "Enable camera functionality for Equibop plugins.";

  programs.equinix.config.plugins = mergedPlugins;
}
