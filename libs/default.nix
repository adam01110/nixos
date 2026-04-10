{
  inputs,
  lib,
}: let
  inherit
    (builtins)
    # keep-sorted start
    filter
    foldl'
    functionArgs
    # keep-sorted end
    ;

  importTree = inputs.import-tree.withLib lib;

  helperArgs = {
    inherit inputs lib;
  };

  helperFiles = importTree.pipeTo (files: filter (path: baseNameOf path != "default.nix") files) ./.;

  importHelper = file: let
    helper = import file;
  in
    helper (lib.filterAttrs (name: _: builtins.hasAttr name (functionArgs helper)) helperArgs);
in
  foldl' (acc: attrs: acc // attrs) {} (map importHelper helperFiles)
