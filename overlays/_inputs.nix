{
  # keep-sorted start
  inputs,
  self,
  # keep-sorted end
}: let
  flakeLib = import "${self}/libs" {
    inherit inputs;
    inherit (inputs.nixpkgs) lib;
  };
  inherit (flakeLib) attrsByPath;
in
  attrsByPath inputs [
    # keep-sorted start
    "millennium.overlays.default"
    "nix-cachyos-kernel.overlays.pinned"
    # keep-sorted end
  ]
