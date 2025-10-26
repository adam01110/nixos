{
  description = "Adam0's nixos configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko/latest";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #millennium.url = "git+https://github.com/SteamClientHomebrew/Millennium";

    nix-flatpak.url = "github:gmodena/nix-flatpak/";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dolphin-overlay = {
      url = "github:rumboon/dolphin-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      chaotic,
      home-manager,
      stylix,
      hyprland,
      hyprland-plugins,
      lanzaboote,
      nix-flatpak,
      nur,
      determinate,
      noctalia,
      sops-nix,
      dolphin-overlay,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "adam0";

      commonModules = [
        disko.nixosModules.disko
        chaotic.nixosModules.default
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        lanzaboote.nixosModules.lanzaboote
        nur.modules.nixos.default
        determinate.nixosModules.default
        sops-nix.nixosModules.sops
        noctalia.nixosModules.default
        ./system
      ];

      commonArgs = {
        inherit
          self
          inputs
          system
          username
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
