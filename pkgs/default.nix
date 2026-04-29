# SPDX-License-Identifier: AGPL-3.0-or-later
{
  # keep-sorted start
  inputs,
  lib,
  pkgs,
  self,
  # keep-sorted end
}: let
  inherit (builtins) listToAttrs;
  inherit (lib) removeSuffix;
  inherit (pkgs) callPackage;
  flakeLib = import "${self}/libs" {
    inherit
      # keep-sorted start
      inputs
      lib
      # keep-sorted end
      ;
  };
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
