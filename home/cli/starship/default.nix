{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) foldl' recursiveUpdate;

  segmentArgs = {
    inherit config lib pkgs;
  };

  segmentFiles = [
    ./build.nix
    ./container.nix
    ./disabled.nix
    ./format.nix
    ./general.nix
    ./git.nix
    ./languages.nix
    ./runtimes.nix
  ];

  starshipSettings =
    foldl'
      (acc: file: recursiveUpdate acc (import file segmentArgs))
      { }
      segmentFiles;
in
{
  programs.starship = {
    enable = true;
    settings = starshipSettings;
  };
}
