{
  config,
  lib,
  vars,
  equibopStylix,
  ...
}:

let
  inherit (lib) foldl' mkEnableOption;
  inherit (vars) countryCode;

  cfgCamera = config.equibop.camera.enable;

  pluginArgs = {
    inherit cfgCamera;
    stylix = equibopStylix;
    userCountry = countryCode;
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
  config.programs.equinix.extraConfig.plugins = mergedPlugins;
}
