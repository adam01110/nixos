_:
# default handlers for archive and compressed formats.
let
  inherit (builtins) listToAttrs;
in {
  xdg.mimeApps.defaultApplications = let
    mkEntries = prefix: desktop: names:
      map (name: {
        name = "${prefix}/${name}";
        value = desktop;
      })
      names;
  in
    listToAttrs (mkEntries "application" "org.gnome.FileRoller.desktop" [
      "x-compress"
      "x-rpm"
      "x-lrzip"
      "x-ace"
      "x-lzma"
      "x-arj"
      "x-lha"
      "x-archive"
      "vnd.rar"
      "x-7z-compressed"
      "vnd.ms-cab-compressed"
      "x-source-rpm"
      "x-lzma-compressed-tar"
      "x-xar"
      "x-cpio"
      "x-lzop"
      "gzip"
      "x-msdownload"
      "x-tarz"
      "x-zstd-compressed-tar"
      "x-zoo"
      "x-tzo"
      "x-stuffit"
      "x-lzip"
      "x-lhz"
      "vnd.debian.binary-package"
      "x-alz"
      "x-lzip-compressed-tar"
      "x-lz4-compressed-tar"
      "x-bzip3-compressed-tar"
      "x-compressed-tar"
      "x-bzip1"
      "x-xz-compressed-tar"
      "x-bzip2"
      "x-bzip3"
      "x-lz4"
      "x-bzip2-compressed-tar"
      "zip"
      "x-xz"
      "vnd.efi.iso"
      "x-tar"
      "x-bzip1-compressed-tar"
      "x-apple-diskimage"
      "zstd"
      "x-lrzip-compressed-tar"
      "x-ms-wim"
    ]);
}
