{
  # flake entrypoint for this nixos + home manager setup.
  # - declares all external inputs (channels, overlays, and modules)
  # - defines common modules/args shared by hosts
  # - exposes `nixosconfigurations` for each machine.
  description = "Adam0's nixos configuration.";

  # inputs: upstream channels, overlays, and extra flakes used by this config.
  inputs = {
    # core nixpkgs channel.
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # extra packages, overlays, and modules.
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel?ref=release";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flatpak module for home manager.
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # disk partitioning.
    disko.url = "github:nix-community/disko?ref=latest";

    # home manager for user-level configuration.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # stylix theming.
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secure boot support.
    lanzaboote = {
      url = "github:nix-community/lanzaboote?ref=v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops integration.
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland compositor and plugins.
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprsplit = {
      url = "github:shezdy/hyprsplit";
      inputs.hyprland.follows = "hyprland";
    };

    # noctalia shell.
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell?ref=v4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # prebuilt database for nix-index/comma tooling.
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen browser flake.
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake?ref=beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # discord/equibop flake.
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # packages and home manager modules for ai tools.
    llm-agents.url = "github:numtide/llm-agents.nix";
    mcp-servers-nix.url = "github:natsukium/mcp-servers-nix";

    # spicetify flake.
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zed extensions flake.
    zed-extensions.url = "github:DuskSystems/nix-zed-extensions";

    # userstyles for zen browser flake.
    nix-userstyles = {
      url = "github:adam01110/nix-userstyles";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # treefmt.
    treefmt-nix.url = "github:numtide/treefmt-nix";
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

    # Small tool to iterate over each systems
    eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

    # Eval the treefmt modules from ./treefmt.nix
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
    # for `nix flake check`
    checks = eachSystem (pkgs: {
      formatting = treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
    });
  };
}
