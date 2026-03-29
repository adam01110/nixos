{
  lib,
  pkgs,
  ...
}:
# Wrap the cpond command with preferred defaults.
let
  inherit (lib) makeBinPath;
  inherit (pkgs) symlinkJoin;

  inherit (pkgs.nur.repos.adam0) cpond;
in {
  # Install a wrapped cpond command with the preferred defaults.
  home.packages = [
    (symlinkJoin {
      name = "cpond-wrapped";
      paths = [cpond];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/cpond \
          --prefix PATH : ${makeBinPath [cpond]} \
          --add-flags "-b -c 16"
      '';
    })
  ];
}
