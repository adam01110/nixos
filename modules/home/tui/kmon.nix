{
  # keep-sorted start
  lib,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (lib) getExe;
  inherit (pkgs) kmon;
in {
  home = {
    packages = [kmon];
    shellAliases.kmon = "${getExe kmon} -u";
  };
}
