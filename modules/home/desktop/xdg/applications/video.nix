_:
# Default handlers for video mime types.
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
      (mkEntries "video" "org.gnome.Showtime.desktop" [
        "x-nsv"
        "webm"
        "mp2t"
        "quicktime"
        "x-anim"
        "mpeg"
        "x-ogm+ogg"
        "vnd.rn-realvideo"
        "3gpp2"
        "3gpp"
        "mp4"
        "dv"
        "x-theora+ogg"
        "x-flic"
        "vnd.avi"
        "x-flv"
        "x-matroska"
        "vnd.vivo"
        "ogg"
        "vnd.mpegurl"
      ])
      ++ (mkEntries "application" "org.gnome.Showtime.desktop" [
        "vnd.ms-asf"
      ])
    );
}
