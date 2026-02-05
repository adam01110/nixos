_:
# Default handlers for audio mime types.
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
    listToAttrs (mkEntries "audio" "org.gnome.Decibels.desktop" [
      "x-ape"
      "flac"
      "x-vorbis+ogg"
      "mp2"
      "x-m4b"
      "x-aiff"
      "mp4"
      "x-opus+ogg"
      "mpeg"
      "x-speex"
      "x-wavpack"
      "aac"
      "vnd.wave"
    ]);
}
