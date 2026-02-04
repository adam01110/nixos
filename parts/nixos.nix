{
  inputs,
  self,
  ...
}:
# nixos host definitions for flake-parts.
let
  vars = import ../vars.nix;

  commonModules = with inputs; [
    nur.modules.nixos.default
    disko.nixosModules.disko
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    lanzaboote.nixosModules.lanzaboote
    sops-nix.nixosModules.sops
    (import-tree ../system)
  ];

  mkHost = {
    system,
    hostPath,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit
          self
          inputs
          vars
          ;
      };
      modules = commonModules ++ [hostPath];
    };
in {
  flake.nixosConfigurations = {
    desktop = mkHost {
      system = "x86_64-linux";
      hostPath = ../hosts/desktop;
    };

    laptop = mkHost {
      system = "x86_64-linux";
      hostPath = ../hosts/laptop;
    };

    vm = mkHost {
      system = "x86_64-linux";
      hostPath = ../hosts/vm;
    };
  };
}
