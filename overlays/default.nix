{
  # keep-sorted start
  inputs,
  lib,
  # keep-sorted end
}: let
  flakeLib = import ../libs {inherit inputs lib;};
  inherit (flakeLib) nixFilesInDir;
  upstreamOverlays = import ./_inputs.nix {inherit inputs;};

  overlayArgs = {
    inherit
      # keep-sorted start
      inputs
      lib
      # keep-sorted end
      ;
  };

  overlayFiles = nixFilesInDir {
    dir = ./.;
    excludeNames = [
      # keep-sorted start
      "default.nix"
      "external-pkgs.nix"
      # keep-sorted end
    ];
  };

  mkOverlay = file: let
    overlayFn = import file;
  in
    overlayFn overlayArgs;

  externalPkgsOverlay = mkOverlay ./external-pkgs.nix;
in
  upstreamOverlays ++ [externalPkgsOverlay] ++ map mkOverlay overlayFiles
