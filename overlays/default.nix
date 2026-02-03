{
  inputs,
  lib,
}:
# overlays loaded from this directory.
let
  inherit
    (builtins)
    filter
    functionArgs
    hasAttr
    ;
  inherit (lib) filterAttrs;

  importTree = inputs.import-tree.withLib lib;
  upstreamOverlays = import ./inputs.nix {inherit inputs;};

  overlayArgs = {
    inherit
      inputs
      lib
      ;
  };

  overlayFiles = importTree.pipeTo (files: filter isOverlayFile files) ./.;
  isOverlayFile = path: let
    baseName = baseNameOf path;
  in
    baseName != "default.nix" && baseName != "inputs.nix";

  mkOverlay = file: let
    overlayFn = import file;
  in
    overlayFn (filterArgs overlayFn overlayArgs);
  filterArgs = fn: args:
    filterAttrs (name: _: hasAttr name (functionArgs fn)) args;

  externalPkgsOverlay = mkOverlay ./external-pkgs.nix;
in
  upstreamOverlays ++ [externalPkgsOverlay] ++ map mkOverlay overlayFiles
