{flakeLib, ...}:
# Default handlers for archive and compressed formats.
let
  inherit
    (flakeLib)
    # keep-sorted start
    mimeAppDefaults
    mimeAppEntries
    # keep-sorted end
    ;
in {
  xdg.mimeApps.defaultApplications = mimeAppDefaults (mimeAppEntries "application" "org.gnome.FileRoller.desktop" [
    # keep-sorted start
    "gzip"
    "vnd.debian.binary-package"
    "vnd.efi.iso"
    "vnd.ms-cab-compressed"
    "vnd.rar"
    "x-7z-compressed"
    "x-ace"
    "x-alz"
    "x-apple-diskimage"
    "x-archive"
    "x-arj"
    "x-bzip1"
    "x-bzip1-compressed-tar"
    "x-bzip2"
    "x-bzip2-compressed-tar"
    "x-bzip3"
    "x-bzip3-compressed-tar"
    "x-compress"
    "x-compressed-tar"
    "x-cpio"
    "x-lha"
    "x-lhz"
    "x-lrzip"
    "x-lrzip-compressed-tar"
    "x-lz4"
    "x-lz4-compressed-tar"
    "x-lzip"
    "x-lzip-compressed-tar"
    "x-lzma"
    "x-lzma-compressed-tar"
    "x-lzop"
    "x-ms-wim"
    "x-msdownload"
    "x-rpm"
    "x-source-rpm"
    "x-stuffit"
    "x-tar"
    "x-tarz"
    "x-tzo"
    "x-xar"
    "x-xz"
    "x-xz-compressed-tar"
    "x-zoo"
    "x-zstd-compressed-tar"
    "zip"
    "zstd"
    # keep-sorted end
  ]);
}
