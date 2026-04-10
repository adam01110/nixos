{
  # keep-sorted start
  inputs,
  lib,
  # keep-sorted end
}:
# Helpers for file discovery and import-tree traversal.
let
  inherit
    (builtins)
    # keep-sorted start
    elem
    filter
    # keep-sorted end
    ;

  importTree = inputs.import-tree.withLib lib;
in {
  inherit importTree;

  # Collect nix files from a directory while skipping selected names or prefixes.
  nixFilesInDir = {
    dir,
    excludeNames ? [],
    excludePrefixes ? [],
  }:
    importTree.pipeTo (files:
      filter (path: let
        relPath = lib.removePrefix "${toString dir}/" (toString path);
      in
        !(elem (baseNameOf path) excludeNames || lib.any (prefix: lib.hasPrefix prefix relPath) excludePrefixes))
      files)
    dir;
}
