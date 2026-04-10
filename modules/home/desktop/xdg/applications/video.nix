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
      # keep-sorted start block=yes
      (mkEntries "video" "org.gnome.Showtime.desktop" [
        # keep-sorted start
        "3gpp"
        "3gpp2"
        "dv"
        "mp2t"
        "mp4"
        "mpeg"
        "ogg"
        "quicktime"
        "vnd.avi"
        "vnd.mpegurl"
        "vnd.rn-realvideo"
        "vnd.vivo"
        "webm"
        "x-anim"
        "x-flic"
        "x-flv"
        "x-matroska"
        "x-nsv"
        "x-ogm+ogg"
        "x-theora+ogg"
        # keep-sorted end
      ])
      ++ (mkEntries "application" "org.gnome.Showtime.desktop" [
        "vnd.ms-asf"
      ])
      # keep-sorted end
    );
}
