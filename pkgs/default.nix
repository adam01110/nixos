{
  inputs,
  lib,
  pkgs,
}: let
  inherit (builtins) listToAttrs;
  inherit (lib) removeSuffix;
  inherit (pkgs) callPackage;
  flakeLib = import ../libs {inherit inputs lib;};
  inherit (flakeLib) nixFilesInDir;

  packageFiles = nixFilesInDir {
    dir = ./.;
    excludeNames = ["default.nix"];
    excludePrefixes = ["scripts/"];
  };

  mkPackage = file: let
    name = removeSuffix ".nix" (baseNameOf file);
  in {
    inherit name;
    value = callPackage file {inherit inputs lib;};
  };
in
  listToAttrs (map mkPackage packageFiles)
