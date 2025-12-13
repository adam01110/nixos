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
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
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
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
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
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # discord/equibop flake.
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # packages and home manager modules for ai tools.
    nix-ai-tools = {
      url = "github:numtide/nix-ai-tools";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # steam homebrew flake.
    millennium.url = "git+https://github.com/SteamClientHomebrew/Millennium";

    # spicetify flake.
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # outputs: expose host configurations and pass through common arguments.
  outputs =
    {
      self,
      nixpkgs,
      nur,
      disko,
      home-manager,
      stylix,
      lanzaboote,
      sops-nix,
      ...
    }@inputs:
    let
      # the system architecture.
      system = "x86_64-linux";

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
          modules = commonModules ++ [ ./hosts/desktop ];
        };

        # laptop profile with mobile-specific options.
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = commonModules ++ [ ./hosts/laptop ];
        };

        # lightweight vm target for testing.
        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = commonModules ++ [ ./hosts/vm ];
        };
      };
    };
}
