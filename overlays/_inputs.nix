{inputs}: let
  inherit
    (inputs.nixpkgs.lib)
    getAttrFromPath
    splitString
    ;
in
  # Upstream overlay inputs used by this config.
  map (path: getAttrFromPath (splitString "." path) inputs) [
    # keep-sorted start
    "millennium.overlays.default"
    "nix-cachyos-kernel.overlays.pinned"
    "zed-extensions.overlays.default"
    # keep-sorted end
  ]
