_:
# Default handlers for image editing formats.
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
      (mkEntries "image" "gimp.desktop" [
        "vnd.adobe.photoshop"
        "openraster"
        "jp2"
        "x-xbitmap"
        "x-xcf"
        "x-sgi"
        "x-ilbm"
        "x-xwindowdump"
        "x-icns"
        "wmf"
        "x-sun-raster"
        "vnd.zbrush.pcx"
        "vnd.wap.wbmp"
        "x-jp2-codestream"
      ])
      ++ (mkEntries "application" "gimp.desktop" [
        "x-navi-animation"
        "fits"
      ])
    );
}
