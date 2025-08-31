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
    ./git.nix
    ./home.nix
  ];
}
