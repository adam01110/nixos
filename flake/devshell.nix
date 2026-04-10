_:
# Dev shell for vim and sops tooling.
{
  perSystem = {pkgs, ...}: let
    inherit (builtins) attrValues;
    inherit (pkgs) mkShell;
  in {
    devShells.default = mkShell {
      packages = attrValues {
        inherit
          (pkgs)
          # keep-sorted start
          sops
          tokei
          # keep-sorted end
          ;
      };
    };
  };
}
