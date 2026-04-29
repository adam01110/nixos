{
  # keep-sorted start
  inputs,
  self,
  # keep-sorted end
  ...
}: let
  flakeLib = import "${self}/libs" {
    inherit inputs;
    inherit (inputs.nixpkgs) lib;
  };
  inherit (flakeLib) attrsByPath importTree;
  vars = import "${self}/vars.nix";

  # Shared module stack for every host configuration.
  commonModules =
    attrsByPath inputs [
      # keep-sorted start
      "disko.nixosModules.disko"
      "home-manager.nixosModules.home-manager"
      "lanzaboote.nixosModules.lanzaboote"
      "nur.modules.nixos.default"
      "sops-nix.nixosModules.sops"
      "stylix.nixosModules.stylix"
      # keep-sorted end
    ]
    ++ [(importTree "${self}/modules/system")];

  # Helper to build a host with shared args and modules.
  mkHost = name: system:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit
          # keep-sorted start
          flakeLib
          inputs
          self
          vars
          # keep-sorted end
          ;
      };

      modules = commonModules ++ [(importTree "${self}/modules/hosts/${name}")];
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
  flake.nixosConfigurations = inputs.nixpkgs.lib.genAttrs (builtins.attrNames hosts) (
    name: mkHost name hosts.${name}
  );
}
