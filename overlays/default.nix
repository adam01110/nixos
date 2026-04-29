{
  # keep-sorted start
  inputs,
  lib,
  self,
  # keep-sorted end
}: let
  flakeLib = import "${self}/libs" {
    inherit
      # keep-sorted start
      inputs
      lib
      # keep-sorted end
      ;
  };
  inherit (flakeLib) nixFilesInDir;
  upstreamOverlays = import ./_inputs.nix {
    inherit
      # keep-sorted start
      inputs
      self
      # keep-sorted end
      ;
  };

  overlayArgs = {
    inherit
      # keep-sorted start
      inputs
      lib
      self
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
