{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./other.nix
    ./steam.nix
  ];
}
