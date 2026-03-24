{inputs}: let
  inherit
    (inputs.nixpkgs.lib)
    getAttrFromPath
    splitString
    ;
in
  # Upstream overlay inputs used by this config.
  map (path: getAttrFromPath (splitString "." path) inputs) [
    "nix-cachyos-kernel.overlays.pinned"
    "neovim-nightly-overlay.overlays.default"
    "zed-extensions.overlays.default"
    "millennium.overlays.default"
  ]
