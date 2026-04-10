{
  inputs,
  lib,
  pkgs,
}:
# Custom packages exported to pkgs.
let
  inherit (builtins) listToAttrs;
  inherit (lib) removeSuffix;
  inherit (pkgs) callPackage;
  flakeLib = import ../libs {inherit inputs lib;};
  inherit (flakeLib) nixFilesInDir;

  # Gather all package definition files under this directory.
  packageFiles = nixFilesInDir {
    dir = ./.;
    excludeNames = ["default.nix"];
    excludePrefixes = ["scripts/"];
  };

  # Map file path to attr set entry.
  mkPackage = file: let
    name = removeSuffix ".nix" (baseNameOf file);
  in {
    inherit name;
    value = callPackage file {inherit inputs lib;};
  };
in
  listToAttrs (map mkPackage packageFiles)
