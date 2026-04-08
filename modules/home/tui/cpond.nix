{
  lib,
  pkgs,
  ...
}:
# Install `cpond` and expose preferred defaults.
let
  inherit (lib) getExe;
  inherit (pkgs.nur.repos.adam0) cpond;
in {
  home = {
    packages = [cpond];
    shellAliases.cpond = "${getExe cpond} -b -c 16";
  };
}
