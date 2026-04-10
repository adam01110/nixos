{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}:
# Install `kmon` and expose preferred defaults.
let
  inherit (lib) getExe;
  inherit (pkgs) kmon;
in {
  home = {
    packages = [kmon];
    shellAliases.kmon = "${getExe kmon} -u";
  };
}
