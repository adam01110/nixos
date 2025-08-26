{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./czkawka.nix
    ./ghostty.nix
    ./lutris.nix
    ./onlyoffice.nix
    ./other.nix
    ./sober.nix
    ./zed.nix
    ./zen.nix
  ];
}
