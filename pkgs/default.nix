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

  # import-tree with lib helpers for file discovery.
  importTree = inputs.import-tree.withLib lib;

  # gather all package definition files under this directory.
  packageFiles = importTree.pipeTo (files: filter isPackageFile files) ./.;
  # ignore default.nix so it only aggregates.
  isPackageFile = path: baseNameOf path != "default.nix";

  # map file path to attr set entry.
  mkPackage = file: let
    name = removeSuffix ".nix" (baseNameOf file);
  in {
    inherit name;
    value = pkgs.callPackage file {inherit inputs lib;};
  };
in
  listToAttrs (map mkPackage packageFiles)
