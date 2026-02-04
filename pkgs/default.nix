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
    listToAttrs
    ;
  inherit
    (lib)
    removeSuffix
    ;

  importTree = inputs.import-tree.withLib lib;

  packageFiles = importTree.pipeTo (files: filter isPackageFile files) ./.;
  isPackageFile = path: baseNameOf path != "default.nix";

  mkPackage = file: let
    name = removeSuffix ".nix" (baseNameOf file);
  in {
    inherit name;
    value = pkgs.callPackage file {inherit inputs lib;};
  };
in
  listToAttrs (map mkPackage packageFiles)
