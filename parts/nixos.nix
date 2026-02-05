{
  inputs,
  self,
  ...
}:
# nixos host definitions for flake-parts.
let
  vars = import ../vars.nix;
  import-tree = inputs.import-tree.withLib inputs.nixpkgs.lib;

  # shared module stack for every host configuration.
  commonModules = with inputs; [
    nur.modules.nixos.default
    disko.nixosModules.disko
    home-manager.nixosModules.home-manager
    stylix.nixosModules.stylix
    lanzaboote.nixosModules.lanzaboote
    sops-nix.nixosModules.sops
    (import-tree ../system)
  ];

  # helper to build a host with shared args and modules.
  mkHost = name: system:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit
          self
          inputs
          vars
          ;
      };

      modules =
        commonModules
        ++ [
          (import-tree (../hosts + "/${name}"))
        ];
    };

  # host map used to derive nixosConfigurations.
  hosts = {
    desktop = "x86_64-linux";
    laptop = "x86_64-linux";
    vm = "x86_64-linux";
  };
in {
  flake.nixosConfigurations =
    inputs.nixpkgs.lib.genAttrs (builtins.attrNames hosts)
    (name: mkHost name hosts.${name});
}
