{
  inputs,
  self,
  ...
}:
# Nixos host definitions for flake-parts.
let
  inherit
    (inputs.nixpkgs.lib)
    # keep-sorted start
    getAttrFromPath
    splitString
    # keep-sorted end
    ;
  vars = import ../vars.nix;

  import-tree = inputs.import-tree.withLib inputs.nixpkgs.lib;

  # Shared module stack for every host configuration.
  commonModules =
    (map (path: getAttrFromPath (splitString "." path) inputs) [
      # keep-sorted start
      "disko.nixosModules.disko"
      "home-manager.nixosModules.home-manager"
      "lanzaboote.nixosModules.lanzaboote"
      "nur.modules.nixos.default"
      "sops-nix.nixosModules.sops"
      "stylix.nixosModules.stylix"
      # keep-sorted end
    ])
    ++ [(import-tree ../modules/system)];

  # Helper to build a host with shared args and modules.
  mkHost = name: system:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit
          # keep-sorted start
          inputs
          self
          vars
          # keep-sorted end
          ;
      };

      modules =
        commonModules
        ++ [(import-tree (../modules/hosts + "/${name}"))];
    };

  # Host map used to derive nixosConfigurations.
  hosts = {
    # keep-sorted start
    desktop = "x86_64-linux";
    laptop = "x86_64-linux";
    vm = "x86_64-linux";
    # keep-sorted end
  };
in {
  flake.nixosConfigurations =
    inputs.nixpkgs.lib.genAttrs (builtins.attrNames hosts)
    (name: mkHost name hosts.${name});
}
