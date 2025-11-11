{
  lib,
  ...
}:

# xdg default application associations consolidated from submodules.
let
  inherit (lib) foldl';

  moduleArgs = { };

  # split application categories into separate small files.
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

  # merge all category maps left-to-right.
  defaultApplications = foldl' (acc: file: acc // (import file moduleArgs)) { } applicationFiles;
in
{
  xdg.mimeApps.defaultApplications = defaultApplications;
}
