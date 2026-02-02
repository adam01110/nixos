{
  # flake entrypoint for this nixos + home manager setup.
  # - declares all external inputs (channels, overlays, and modules)
  # - defines common modules/args shared by hosts
  # - exposes `nixosconfigurations` for each machine.
  description = "Adam0's nixos configuration.";

  # inputs: upstream channels, overlays, and extra flakes used by this config.
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel?ref=release";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    disko.url = "github:nix-community/disko?ref=latest";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote?ref=v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell?ref=v4.2.5";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake?ref=beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-userstyles = {
      url = "github:adam01110/nix-userstyles";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    oxicord = {
      url = "github:linuxmobile/oxicord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents.url = "github:numtide/llm-agents.nix";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zed-extensions.url = "github:DuskSystems/nix-zed-extensions";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    determinate.url = "github:DeterminateSystems/nix-src";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    tuigreet = {
      url = "github:notashelf/tuigreet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # outputs: expose host configurations and pass through common arguments.
  outputs = {
    self,
    nixpkgs,
    nur,
    disko,
    home-manager,
    stylix,
    lanzaboote,
    sops-nix,
    systems,
    treefmt-nix,
    ...
  } @ inputs: let
    # variables.
    vars = import ./vars.nix;

    # modules shared by every host.
    commonModules = [
      nur.modules.nixos.default
      disko.nixosModules.disko
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
      lanzaboote.nixosModules.lanzaboote
      sops-nix.nixosModules.sops
      ./system
    ];

    # helper for building host configurations.
    mkHost = {
      system,
      hostPath,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs =
          {
            # arguments shared by every host.
            inherit
              self
              inputs
              system
              vars
              ;
          }
          // {
            inherit system;
          };
        modules = commonModules ++ [hostPath];
      };

    # small helper to iterate over each system.
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

    # eval the treefmt modules from ./treefmt.nix.
    treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
  in {
    # host machines defined by directory under ./host/*
    nixosConfigurations = {
      desktop = mkHost {
        system = "x86_64-linux";
        hostPath = ./hosts/desktop;
      };

      laptop = mkHost {
        system = "x86_64-linux";
        hostPath = ./hosts/laptop;
      };

      vm = mkHost {
        system = "x86_64-linux";
        hostPath = ./hosts/vm;
      };
    };

    formatter = eachSystem (pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper);
    checks = eachSystem (pkgs: {
      formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
    });
  };
}
