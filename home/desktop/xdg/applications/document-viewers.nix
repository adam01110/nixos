_:
# default handlers for document and ebook viewing.
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
      (mkEntries "application" "org.pwmt.zathura-pdf-mupdf.desktop" [
        "pdf"
        "epub+zip"
        "oxps"
        "vnd.ms-xpsdocument"
      ])
      ++ (mkEntries "application" "org.pwmt.zathura-cb.desktop" [
        "x-cb7"
        "vnd.comicbook+zip"
        "vnd.comicbook-rar"
        "x-cbt"
      ])
      ++ (mkEntries "application" "org.pwmt.zathura-ps.desktop" [
        "postscript"
      ])
      ++ (mkEntries "image" "org.pwmt.zathura-ps.desktop" [
        "x-eps"
      ])
      ++ (mkEntries "image" "org.pwmt.zathura-djvu.desktop" [
        "vnd.djvu"
        "vnd.djvu+multipage"
      ])
    );
}
