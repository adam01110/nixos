_: final: _prev:
let
  # Patch zed-editor literals to match nixpkgs main until unstable catches up.
  patchedPackage = builtins.toFile "zed-editor-package.nix" (
    builtins.replaceStrings
      [
        "version = \"0.225.12\";"
        "hash = \"sha256-rVJ+NNsnhoXr6y2j2VFrXQVrgbXQY/a6l2Khs36SvDU=\";"
        "cargoHash = \"sha256-i6BZPAKCgomWA/c923/tB9uWtXGr5VXIqmGCYtUUBLM=\";"
      ]
      [
        "version = \"0.225.13\";"
        "hash = \"sha256-ozuycL8dnBtgyYYjsz9C+CDtZQzbXWWZVOkxbOs7hho=\";"
        "cargoHash = \"sha256-G5U0APQNNEe2qpshqX4QpQGbqIAHllatbbsaVAhDoG0=\";"
      ]
      (builtins.readFile "${final.path}/pkgs/by-name/ze/zed-editor/package.nix")
  );
in
{
  zed-editor = final.callPackage patchedPackage { };
}
