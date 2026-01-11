{...}:
# xdg application mime type associations and default handlers.
{
  imports = [
    ./applications/archives.nix
    ./applications/protocols.nix
    ./applications/files.nix
    ./applications/audio.nix
    ./applications/video.nix
    ./applications/document-viewers.nix
    ./applications/document-editors.nix
    ./applications/code.nix
    ./applications/image-viewers.nix
    ./applications/image-editors.nix
  ];

  # enable mime application database for file type associations.
  xdg.mimeApps.enable = true;
}
