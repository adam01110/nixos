{inputs}: let
  flakeLib = import ../libs {
    inherit inputs;
    inherit (inputs.nixpkgs) lib;
  };
  inherit (flakeLib) attrsByPath;
in
  attrsByPath inputs [
    # keep-sorted start
    "millennium.overlays.default"
    "nix-cachyos-kernel.overlays.pinned"
    # ZED
    "zed-extensions.overlays.default"
    # keep-sorted end
  ]
