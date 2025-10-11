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
    ./gpg.nix
    ./home.nix
    ./mpd.nix
  ];
}
