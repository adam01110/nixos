{
  # flake entrypoint for this nixos + home manager setup.
  # - declares all external inputs (channels, overlays, and modules)
  # - defines common modules/args shared by hosts
  # - exposes `nixosconfigurations` for each machine (desktop, laptop, vm)
  description = "Adam0's nixos configuration.";

  # inputs: upstream channels, overlays, and extra flakes used by this config.
  inputs = {
    # core nixpkgs channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # extra packages, overlays, and modules.
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flatpak module for home manager.
    nix-flatpak.url = "github:gmodena/nix-flatpak/";

    # disk partitioning.
    disko.url = "github:nix-community/disko/latest";

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
      url = "github:nix-community/lanzaboote/v0.4.3";
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
      url = "github:shezdy/hyprsplit/main";
      inputs.hyprland.follows = "hyprland";
    };

    # noctalia shell.
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        quickshell.follows = "quickshell";
      };
    };

    # prebuilt database for nix-index/comma tooling.
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # dolphin file manager overlay.
    dolphin-overlay = {
      url = "github:rumboon/dolphin-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # zen browser flake.
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # modules for discord/equibop.
    equinix = {
      url = "github:not-a-cowfr/equinix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # packages and home manager modules for ai tools.
    nix-ai-tools = {
      url = "github:numtide/nix-ai-tools";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # steam homebrew.
    millennium.url = "git+https://github.com/SteamClientHomebrew/Millennium";
  };

  # outputs: expose host configurations and pass through common arguments.
  outputs =
    {
      self,
      nixpkgs,
      chaotic,
      nur,
      disko,
      home-manager,
      stylix,
      lanzaboote,
      sops-nix,
      noctalia,
      nix-index-database,
      ...
    }@inputs:
    let
      # the system architecture.
      system = "x86_64-linux";
      # variables.
      vars = import ./vars.nix;

      # modules shared by every host.
      commonModules = [
        chaotic.nixosModules.default
        nur.modules.nixos.default
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        lanzaboote.nixosModules.lanzaboote
        sops-nix.nixosModules.sops
        noctalia.nixosModules.default
        nix-index-database.nixosModules.nix-index
        ./system
      ];

      # arguments shared by every host.
      commonArgs = {
        inherit
          self
          inputs
          system
          vars
          ;
      };
    in
    {
      # host machines defined by directory under ./host/*
      nixosConfigurations = {
        # main desktop configuration.
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = commonModules ++ [ ./host/desktop ];
        };
        # laptop profile with mobile-specific options.
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = commonModules ++ [ ./host/laptop ];
        };
        # lightweight vm target for testing.
        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = commonModules ++ [ ./host/vm ];
        };
      };
    };
}
