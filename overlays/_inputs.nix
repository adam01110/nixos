{inputs}: let
  flakeLib = import ../libs {
    inherit inputs;
    inherit (inputs.nixpkgs) lib;
  };
  inherit (flakeLib) attrsByPath;
in
  # Upstream overlay inputs used by this config.
  attrsByPath inputs [
    # keep-sorted start
    "millennium.overlays.default"
    "nix-cachyos-kernel.overlays.pinned"
    "zed-extensions.overlays.default"
    # keep-sorted end
  ]
