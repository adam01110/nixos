{
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) attrValues;
  inherit (lib) makeBinPath;
  inherit (pkgs) symlinkJoin;
in {
  # Configure ripgrep-all with wrapper-provided adapter dependencies.
  programs.ripgrep-all = {
    # Wrap rga for custom adapters.
    package = symlinkJoin {
      name = "ripgrep-all-wrapped";
      paths = [pkgs.ripgrep-all];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/rga \
          --prefix PATH : ${makeBinPath (attrValues {
          inherit
            (pkgs)
            csvkit
            gron
            qq
            ;
        })}
      '';
    };
  };
}
