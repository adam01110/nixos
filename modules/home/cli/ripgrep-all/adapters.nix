{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (builtins) attrValues;
  inherit (lib) makeBinPath;
  inherit (pkgs) symlinkJoin;
in {
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
            # keep-sorted start
            csvkit
            fastgron
            # keep-sorted end
            ;

          inherit (pkgs.nur.repos.adam0) qq-jfryy;
        })}
      '';
    };
  };
}
