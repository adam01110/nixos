{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkAfter
    mkForce
    mkOption
    optionals
    types
    ;

  system = pkgs.stdenv.hostPlatform.system;

  cfg = config.programs.noctalia-shell;
  basePackage =
    if cfg.packageOverrides.package != null
    then cfg.packageOverrides.package
    else inputs.noctalia.packages.${system}.default;
  overrideArgs = removeAttrs cfg.packageOverrides ["package"];
in {
  options = {
    programs.noctalia-shell = {
      # Keep app2unit available for launcher systemd integration.
      app2unit.package = mkOption {
        type = types.package;
        default = pkgs.app2unit;
        description = "The app2unit package to use when appLauncher. useApp2Unit is enabled.";
      };

      # Keep gui settings writes outside the nix store.
      systemd.mutableRuntimeSettings = mkOption {
        type = types.bool;
        default = true;
        description = "Whether noctalia-shell creates a gui-settings.json to store setting changes made within the GUI at runtime.";
      };

      # Keep a base package and overrides for local patches.
      packageOverrides = mkOption {
        type = types.submodule {
          options.package = mkOption {
            type = types.nullOr types.package;
            default = null;
            description = "Optional base package used before applying local patches.";
          };

          # Add runtime tools directly to the wrapped shell package path.
          options.extraPackages = mkOption {
            type = types.listOf types.package;
            default = [];
            description = "Additional runtime packages prepended to the shell wrapper PATH.";
          };

          freeformType = types.attrs;
        };
        default = {};
        description = "Override arguments applied to the base package.";
      };
    };
  };

  config = {
    # Keep app2unit in the shell wrapper path when the launcher expects it.
    programs.noctalia-shell.packageOverrides.extraPackages = mkAfter (let
      useApp2Unit = config.programs.noctalia-shell.settings.appLauncher.useApp2Unit or false;
      app2UnitPackage = config.programs.noctalia-shell.app2unit.package;
    in
      optionals useApp2Unit [app2UnitPackage]);

    # Let the gui save settings to a fallback file.
    systemd.user.services.noctalia-shell.Service.Environment = let
      cfgEnv = config.programs.noctalia-shell.systemd;
    in
      optionals
      (cfgEnv.enable && cfgEnv.mutableRuntimeSettings)
      ["NOCTALIA_SETTINGS_FALLBACK=%h/.config/noctalia/gui-settings.json"];

    # Restore gui-settings fallback behavior removed upstream.
    programs.noctalia-shell.package = mkForce ((basePackage.override overrideArgs).overrideAttrs (old: {
      patches = (old.patches or []) ++ [./patches/noctalia-settings-fallback.patch];
    }));
  };
}
