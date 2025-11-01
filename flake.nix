{
  description = "Adam0's nixos configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/";

    disko.url = "github:nix-community/disko/latest";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell?ref=v2.20.0";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        quickshell.follows = "quickshell";
      };
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dolphin-overlay = {
      url = "github:rumboon/dolphin-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    equinix = {
      url = "github:not-a-cowfr/equinix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #millennium.url = "git+https://github.com/SteamClientHomebrew/Millennium";
  };

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
      system = "x86_64-linux";
      vars = import ./vars.nix;

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
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = commonModules ++ [ ./host/desktop ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = commonModules ++ [ ./host/laptop ];
        };
        vm = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = commonArgs;
          modules = commonModules ++ [ ./host/vm ];
        };
      };
    };
}
