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
      # keep-sorted start block=yes
      (mkEntries "image" "gimp.desktop" [
        # keep-sorted start
        "jp2"
        "openraster"
        "vnd.adobe.photoshop"
        "vnd.wap.wbmp"
        "vnd.zbrush.pcx"
        "wmf"
        "x-icns"
        "x-ilbm"
        "x-jp2-codestream"
        "x-sgi"
        "x-sun-raster"
        "x-xbitmap"
        "x-xcf"
        "x-xwindowdump"
        # keep-sorted end
      ])
      ++ (mkEntries "application" "gimp.desktop" [
        # keep-sorted start
        "fits"
        "x-navi-animation"
        # keep-sorted end
      ])
      # keep-sorted end
    );
}
