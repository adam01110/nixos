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
          vim
          sops
          ;
      };

      # Default editor vars to vim when unset.
      shellHook = let
        editor = "vim";
      in ''
        : ''${EDITOR:=${editor}}
        : ''${VISUAL:=${editor}}
      '';
    };
  };
}
