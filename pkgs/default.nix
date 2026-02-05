{
  inputs,
  lib,
  pkgs,
}:
# Custom packages exported to pkgs.
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

  # Import-tree with lib helpers for file discovery.
  importTree = inputs.import-tree.withLib lib;

  # Gather all package definition files under this directory.
  packageFiles = importTree.pipeTo (files: filter isPackageFile files) ./.;
  # Ignore default.nix so it only aggregates.
  isPackageFile = path: baseNameOf path != "default.nix";

  # Map file path to attr set entry.
  mkPackage = file: let
    name = removeSuffix ".nix" (baseNameOf file);
  in {
    inherit name;
    value = pkgs.callPackage file {inherit inputs lib;};
  };
in
  listToAttrs (map mkPackage packageFiles)
