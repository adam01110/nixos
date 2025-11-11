{
  config,
  lib,
  pkgs,
  ...
}:

# build starship config by merging smaller segment files.
let
  inherit (lib) foldl' recursiveUpdate;

  segmentArgs = {
    inherit config lib pkgs;
  };

  # segment files grouped by feature area.
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

  # fold all segments into a single attribute set.
  starshipSettings = foldl' (
    acc: file: recursiveUpdate acc (import file segmentArgs)
  ) { } segmentFiles;
in
{
  programs.starship = {
    enable = true;
    settings = starshipSettings;
  };
}
