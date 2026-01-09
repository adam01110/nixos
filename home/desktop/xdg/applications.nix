{...}: {
  # group per-category defaults via module imports.
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

  xdg.mimeApps.enable = true;
}
