{
  config,
  lib,
  vars,
  equibopStylix,
  ...
}:
# collect equibop plugins and expose options.
let
  inherit
    (lib)
    mkEnableOption
    foldl'
    ;
  inherit (vars) countryCode;

  # short alias for camera enable option.
  cfgCamera = config.equibop.camera.enable;

  # arguments passed into each plugin module.
  pluginArgs = {
    inherit cfgCamera;
    stylix = equibopStylix;
    userCountry = countryCode;
  };

  # files that define plugin chunks to merge.
  pluginFiles = [
    ./plugins/_core.nix
    ./plugins/_communication.nix
    ./plugins/_interface.nix
    ./plugins/_media.nix
    ./plugins/_social.nix
    ./plugins/_integrations.nix
  ];

  # merge plugin modules into a single attribute set.
  mergedPlugins = foldl' (acc: file: acc // (import file pluginArgs)) {} pluginFiles;
in {
  # user option to toggle camera features in plugins.
  options.equibop.camera.enable = mkEnableOption "Enable camera functionality for Equibop plugins.";
  # attach merged plugin config to equinix.
  config.programs.nixcord.extraConfig.plugins = mergedPlugins;
}
