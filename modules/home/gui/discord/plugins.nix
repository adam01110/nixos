{
  config,
  lib,
  vars,
  equibopStylix,
  ...
}:
# Collect equibop plugins and expose options.
let
  inherit
    (lib)
    mkEnableOption
    foldl'
    ;
  inherit (vars) countryCode;

  # Short alias for camera enable option.
  cfgCamera = config.equibop.camera.enable;

  # Arguments passed into each plugin module.
  pluginArgs = {
    inherit cfgCamera;
    stylix = equibopStylix;
    userCountry = countryCode;
  };

  # Files that define plugin chunks to merge.
  pluginFiles = [
    ./plugins/_core.nix
    ./plugins/_communication.nix
    ./plugins/_interface.nix
    ./plugins/_media.nix
    ./plugins/_social.nix
    ./plugins/_integrations.nix
  ];

  # Merge plugin modules into a single attribute set.
  mergedPlugins = foldl' (acc: file: acc // (import file pluginArgs)) {} pluginFiles;
in {
  # User option to toggle camera features in plugins.
  options.equibop.camera.enable = mkEnableOption "Enable camera functionality for Equibop plugins.";
  # Attach merged plugin config to equinix.
  config.programs.nixcord.extraConfig.plugins = mergedPlugins;
}
