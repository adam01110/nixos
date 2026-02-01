{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkForce
    mkOption
    optional
    optionals
    types
    ;

  cfg = config.programs.noctalia-shell;
  basePackage =
    if cfg.packageOverrides.package != null
    then cfg.packageOverrides.package
    else inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  overrideArgs = removeAttrs cfg.packageOverrides ["package"];
in {
  options = {
    programs.noctalia-shell = {
      # keep app2unit available for launcher systemd integration.
      app2unit.package = mkOption {
        type = types.package;
        default = pkgs.app2unit;
        description = "The app2unit package to use when appLauncher. useApp2Unit is enabled.";
      };

      # keep gui settings writes outside the nix store.
      systemd.mutableRuntimeSettings = mkOption {
        type = types.bool;
        default = true;
        description = "Whether noctalia-shell creates a gui-settings.json to store setting changes made within the GUI at runtime.";
      };

      # keep a base package and overrides for local patches.
      packageOverrides = mkOption {
        type = types.submodule {
          options.package = mkOption {
            type = types.nullOr types.package;
            default = null;
            description = "Optional base package used before applying local patches.";
          };
          freeformType = types.attrs;
        };
        default = {};
        description = "Override arguments applied to the base package.";
      };
    };
  };

  config = {
    # add app2unit when the launcher expects it.
    home.packages = let
      useApp2Unit = config.programs.noctalia-shell.settings.appLauncher.useApp2Unit or false;
      app2UnitPackage = config.programs.noctalia-shell.app2unit.package;
    in
      optional useApp2Unit app2UnitPackage;

    # let the gui save settings to a fallback file.
    systemd.user.services.noctalia-shell.Service.Environment = let
      cfgEnv = config.programs.noctalia-shell.systemd;
    in
      optionals
      (cfgEnv.enable && cfgEnv.mutableRuntimeSettings)
      ["NOCTALIA_SETTINGS_FALLBACK=%h/.config/noctalia/gui-settings.json"];

    # restore gui-settings fallback behavior removed upstream.
    programs.noctalia-shell.package = mkForce ((basePackage.override overrideArgs).overrideAttrs (old: {
      patches = (old.patches or []) ++ [./patches/noctalia-settings-fallback.patch];
    }));
  };
}
