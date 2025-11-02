{
  lib,
  ...
}:

let
  inherit (lib) foldl';

  moduleArgs = { };

  applicationFiles = [
    ./applications/protocols.nix
    ./applications/misc.nix
    ./applications/files.nix
    ./applications/audio.nix
    ./applications/video.nix
    ./applications/archives.nix
    ./applications/document-viewers.nix
    ./applications/document-editors.nix
    ./applications/code.nix
    ./applications/image-viewers.nix
    ./applications/image-editors.nix
  ];

  defaultApplications = foldl' (acc: file: acc // (import file moduleArgs)) { } applicationFiles;
in
{
  xdg.mimeApps.defaultApplications = defaultApplications;
}
