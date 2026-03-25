_:
# Default handlers for image viewing formats including raws.
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
    listToAttrs (
      (mkEntries "image" "org.gnome.Loupe.desktop" [
        "png"
        "x-kodak-dcr"
        "x-pentax-pef"
        "x-portable-graymap"
        "vnd.microsoft.icon"
        "bmp"
        "svg+xml"
        "x-portable-anymap"
        "x-exr"
        "x-kodak-k25"
        "heif"
        "x-tga"
        "x-sony-srf"
        "x-canon-cr2"
        "qoi"
        "jxl"
        "svg+xml-compressed"
        "x-kodak-kdc"
        "webp"
        "x-sony-sr2"
        "x-portable-pixmap"
        "tiff"
        "gif"
        "x-dds"
        "avif"
        "x-sony-arw"
        "x-portable-bitmap"
        "x-adobe-dng"
        "jpeg"
        "x-nikon-nef"
      ])
      ++ (mkEntries "video" "org.gnome.Loupe.desktop" [
        "x-mjpeg"
      ])
    );
}
