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
      # keep-sorted start
      "aac"
      "flac"
      "mp2"
      "mp4"
      "mpeg"
      "vnd.wave"
      "x-aiff"
      "x-ape"
      "x-m4b"
      "x-opus+ogg"
      "x-speex"
      "x-vorbis+ogg"
      "x-wavpack"
      # keep-sorted end
    ]);
}
