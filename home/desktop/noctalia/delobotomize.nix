{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkIf
    mkMerge
    mkOption
    optional
    optionals
    types
    ;

  cfg = config.programs.noctalia-shell;
in {
  options = {
    # keep app2unit available for launcher systemd integration.
    programs.noctalia-shell.app2unit.package = mkOption {
      type = types.package;
      default = pkgs.app2unit;
      description = "The app2unit package to use when appLauncher. when useApp2Unit is enabled.";
    };

    # keep gui settings writes outside the nix store.
    programs.noctalia-shell.systemd.mutableRuntimeSettings = mkOption {
      type = types.bool;
      default = true;
      description = "Whether noctalia-shell creates a gui-settings.json to store setting changes made within the GUI at runtime.";
    };

    # keep a base package for local patches.
    programs.noctalia-shell.packageBase = mkOption {
      type = types.nullOr types.package;
      default = null;
      description = "Base package used before applying local patches.";
    };
  };

  config = mkMerge [
    {
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
    }
    (mkIf (cfg.packageBase != null) {
      # restore gui-settings fallback behavior removed upstream.
      programs.noctalia-shell.package = cfg.packageBase.overrideAttrs (old: {
        patches = (old.patches or []) ++ [./patches/noctalia-settings-fallback.patch];
      });
    })
  ];
}
