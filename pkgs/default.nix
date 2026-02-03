{
  inputs,
  lib,
  pkgs,
}:
# custom packages exported to pkgs.
let
  inherit
    (builtins)
    filter
    functionArgs
    hasAttr
    listToAttrs
    ;
  inherit
    (lib)
    filterAttrs
    removeSuffix
    ;

  importTree = inputs.import-tree.withLib lib;

  packageArgs = {
    inherit
      inputs
      lib
      pkgs
      ;
  };

  packageFiles = importTree.pipeTo (files: filter isPackageFile files) ./.;
  isPackageFile = path: baseNameOf path != "default.nix";

  mkPackage = file: let
    packageFn = import file;
    name = removeSuffix ".nix" (baseNameOf file);
    args = filterArgs packageFn packageArgs;
  in {
    inherit name;
    value = pkgs.callPackage packageFn args;
  };

  filterArgs = fn: args:
    filterAttrs (key: _: hasAttr key (functionArgs fn)) args;
in
  listToAttrs (map mkPackage packageFiles)
