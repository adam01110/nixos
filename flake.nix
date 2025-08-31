{
  description = "Adam's nixos configuration.";

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
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    ghostty.url = "github:ghostty-org/ghostty";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium.url = "github:SteamClientHomebrew/Millennium";

    nix-flatpak.url = "github:gmodena/nix-flatpak/";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
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
      split-monitor-workspaces,
      ghostty,
      lanzaboote,
      nix-flatpak,
      nur,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      username = "adam";
      timezone = "Europe/Amsterdam";

      commonModules = [
        disko.nixosModules.disko
        chaotic.nixosModules.default
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        lanzaboote.nixosModules.lanzaboote
        nur.modules.nixos.default
        ./system
      ];

      commonArgs = {
        inherit
          self
          inputs
          system
          username
          timezone
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
