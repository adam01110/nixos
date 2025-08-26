{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./applications
    ./cli
    ./desktop
    ./home.nix
  ];
}
