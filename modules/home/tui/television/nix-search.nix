{
  osConfig,
  inputs,
  lib,
  pkgs,
  vars,
  ...
}:
# Configure nix-search-tv with builtin indexes and flake-specific option sources.
# This is completely fucking ai generated and does not work correctly at all, but atleast its a POC of which i can work of in the future.
let
  system = pkgs.stdenv.hostPlatform.system;
  stateVersion = osConfig.system.stateVersion;

  helpers = rec {
    keepStorePath = value: toString value;

    filterOptionsJson = name: input: prefixes: json:
      if json == null
      then null
      else
        keepStorePath (
          pkgs.runCommandLocal "nix-search-tv-${name}-options" {
            nativeBuildInputs = [pkgs.jq];
            prefixesJson = builtins.toJSON prefixes;
          } ''
            mkdir -p "$out"
            jq \
              --arg prefix ${lib.escapeShellArg (keepStorePath input)} \
              --argjson prefixes "$prefixesJson" \
              'with_entries(select(
                (.key as $key |
                  any(.value.declarations[]?; startswith($prefix))
                  or any($prefixes[]?; $key | startswith(.))
                )
              ))' \
              ${lib.escapeShellArg json} > "$out/options.json"
          ''
        )
        + "/options.json";

    docsJsonFile = name: path:
      keepStorePath path
      + (
        {
          home-manager-flake = "/share/doc/home-manager/options.json";
          nixcord = "/share/doc/nixos/options.json";
          nvf = "/share/doc/nvf/options.json";
        }.${
          name
        } or ""
      );

    legacyDocsJsonFile = name: path:
      keepStorePath path
      + (
        {
          spicetify-nix = "/share/doc/nixos/options.json";
        }.${
          name
        } or ""
      );

    tryInputPath = path: let
      result = builtins.tryEval (lib.getAttrFromPath path inputs);
    in
      if result.success
      then keepStorePath result.value
      else null;

    docsJson = name: let
      path = tryInputPath [name "packages" system "docs-json"];
    in
      if path == null
      then null
      else docsJsonFile name path;

    legacyDocsJson = name: let
      path = tryInputPath [name "legacyPackages" system "docs" "optionsJSON"];
    in
      if path == null
      then null
      else legacyDocsJsonFile name path;
    tryOptionsJson = options: let
      json = builtins.tryEval (
        (
          pkgs.nixosOptionsDoc {
            inherit options;
            warningsAreErrors = false;
          }
        ).optionsJSON
      );
    in
      if json.success
      then keepStorePath json.value + "/share/doc/nixos/options.json"
      else null;
  };

  homeManager = let
    hmLib = import "${inputs.home-manager}/modules/lib/stdlib-extended.nix" lib;
    hmModules = import "${inputs.home-manager}/modules/modules.nix" {
      lib = hmLib;
      inherit pkgs;
      check = false;
    };
    baseModule.home = {
      username = "doc";
      homeDirectory = "/home/doc";
      inherit stateVersion;
    };
  in {
    optionsJson = name: input: prefixes: module:
      helpers.filterOptionsJson name input prefixes (
        helpers.tryOptionsJson (
          (hmLib.evalModules {
            modules = [baseModule module] ++ hmModules;
            class = "homeManager";
            specialArgs = {
              modulesPath = "${inputs.home-manager}/modules";
              inherit
                inputs
                vars
                ;
              osConfig.services.flatpak.enable = false;
            };
          }).options
        )
      );
  };

  nixos = {
    optionsJson = name: input: prefixes: module:
      helpers.filterOptionsJson name input prefixes (
        helpers.tryOptionsJson (
          (
            import "${pkgs.path}/nixos/lib/eval-config.nix" {
              inherit system;
              modules = [
                {
                  system.stateVersion = stateVersion;
                }
                module
              ];
              specialArgs = {
                inherit
                  inputs
                  vars
                  ;
              };
            }
          ).options
        )
      );
  };

  stylix = let
    noPkgs = {
      inherit (pkgs) _type;
      formats = builtins.mapAttrs (_: fmt: args: {inherit (fmt args) type;}) pkgs.formats;
    };

    evalDocs = module:
      lib.evalModules {
        modules = ["${inputs.stylix}/doc/eval_compat.nix"] ++ lib.toList module;
        specialArgs = {
          pkgs = noPkgs;
          config = noConfig;
        };
      };

    noConfig = let
      configuration = evalDocs {
        options.lib = lib.mkOption {
          type = lib.types.attrsOf lib.types.attrs;
          description = "";
          default = {};
          visible = false;
        };
        imports = ["${inputs.stylix}/stylix/target.nix"];
      };
    in {
      lib.stylix = {
        inherit
          (configuration.config.lib.stylix)
          mkEnableIf
          mkEnableTarget
          mkEnableTargetWith
          mkEnableWallpaper
          ;
      };
    };
  in {
    optionsJson = name: input: prefixes: module:
      helpers.filterOptionsJson name input prefixes (helpers.tryOptionsJson ((evalDocs module).options));
  };

  docInputs = {
    builtin = {
      home-manager-flake = "home-manager";
      nixcord = "nixcord";
      nvf = "nvf";
    };

    legacy = {
      spicetify-nix = "spicetify-nix";
    };

    homeManager = {
      nix-flatpak = {
        input = inputs.nix-flatpak;
        prefixes = [];
        module = inputs.nix-flatpak.homeManagerModules.nix-flatpak;
      };
      nix-index-database = {
        input = inputs.nix-index-database;
        prefixes = [];
        module = inputs.nix-index-database.homeModules.nix-index;
      };
      noctalia = {
        input = inputs.noctalia;
        prefixes = [];
        module = inputs.noctalia.homeModules.default;
      };
      overzicht = {
        input = inputs.overzicht;
        prefixes = ["programs.overzicht."];
        module = inputs.overzicht.homeModules.default;
      };
      sops-nix-home-manager = {
        input = inputs.sops-nix;
        prefixes = [];
        module = inputs.sops-nix.homeManagerModules.sops;
      };
      zed-extensions = {
        input = inputs.zed-extensions;
        prefixes = [
          "programs.zed-editor."
          "programs.zed-editor-extensions."
        ];
        module = inputs.zed-extensions.homeManagerModules.default;
      };
      zen-browser = {
        input = inputs.zen-browser;
        prefixes = ["programs.zen-browser."];
        module = inputs.zen-browser.homeModules.beta;
      };
    };

    nixos = {
      disko = {
        input = inputs.disko;
        prefixes = [];
        module = inputs.disko.nixosModules.disko;
      };
      home-manager-nixos = {
        input = inputs.home-manager;
        prefixes = [];
        module = inputs.home-manager.nixosModules.home-manager;
      };
      lanzaboote = {
        input = inputs.lanzaboote;
        prefixes = [];
        module = inputs.lanzaboote.nixosModules.lanzaboote;
      };
      sops-nix = {
        input = inputs.sops-nix;
        prefixes = [];
        module = inputs.sops-nix.nixosModules.sops;
      };
    };

    custom = {
      stylix-nixos = {
        input = inputs.stylix;
        json = stylix.optionsJson "stylix-nixos" inputs.stylix [] inputs.stylix.nixosModules.stylix;
      };
    };
  };

  optionsFile = let
    generatedSources = [
      (lib.mapAttrs (_: helpers.docsJson) docInputs.builtin)
      (lib.mapAttrs (_: helpers.legacyDocsJson) docInputs.legacy)
      (lib.mapAttrs (name: value: homeManager.optionsJson name value.input value.prefixes value.module) docInputs.homeManager)
      (lib.mapAttrs (name: value: nixos.optionsJson name value.input value.prefixes value.module) docInputs.nixos)
      (lib.mapAttrs (_: value: value.json) docInputs.custom)
    ];
  in
    lib.filterAttrs (_: value: value != null) (lib.foldl' (acc: attrs: acc // attrs) {} generatedSources);
in {
  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;

    settings = {
      indexes = [
        "nixpkgs"
        "nixos"
        "home-manager"
        "noogle"
        "darwin"
      ];

      experimental.options_file = optionsFile;
    };
  };
}
