{
  inputs,
  lib,
}:
# overlays loaded from this directory.
let
  inherit
    (builtins)
    filter
    ;

  importTree = inputs.import-tree.withLib lib;
  upstreamOverlays = import ./_inputs.nix {inherit inputs;};

  overlayArgs = {
    inherit
      inputs
      lib
      ;
  };

  overlayFiles = importTree.pipeTo (files: filter isOverlayFile files) ./.;
  isOverlayFile = path: baseNameOf path != "default.nix";

  mkOverlay = file: let
    overlayFn = import file;
  in
    overlayFn overlayArgs;

  externalPkgsOverlay = mkOverlay ./external-pkgs.nix;
in
  upstreamOverlays ++ [externalPkgsOverlay] ++ map mkOverlay overlayFiles
