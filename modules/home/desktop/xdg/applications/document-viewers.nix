_:
# Default handlers for document and ebook viewing.
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
      ++ (mkEntries "application" "zaread.desktop" [
        "vnd.oasis.opendocument.text"
        "vnd.oasis.opendocument.text-flat-xml"
        "vnd.oasis.opendocument.text-template"
        "vnd.oasis.opendocument.spreadsheet"
        "vnd.oasis.opendocument.spreadsheet-flat-xml"
        "vnd.oasis.opendocument.spreadsheet-template"
        "vnd.oasis.opendocument.presentation"
        "vnd.oasis.opendocument.presentation-flat-xml"
        "vnd.oasis.opendocument.presentation-template"
        "vnd.oasis.opendocument.graphics"
        "vnd.openxmlformats-officedocument.wordprocessingml.document"
        "vnd.openxmlformats-officedocument.wordprocessingml.template"
        "vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "vnd.openxmlformats-officedocument.spreadsheetml.template"
        "vnd.openxmlformats-officedocument.presentationml.presentation"
        "vnd.openxmlformats-officedocument.presentationml.slideshow"
        "vnd.openxmlformats-officedocument.presentationml.template"
        "msword"
        "msword-template"
        "rtf"
        "vnd.ms-excel"
        "vnd.ms-excel.sheet.binary.macroEnabled.12"
        "vnd.ms-excel.sheet.macroEnabled.12"
        "vnd.ms-excel.template.macroEnabled.12"
        "vnd.ms-powerpoint"
        "vnd.ms-powerpoint.presentation.macroEnabled.12"
        "vnd.ms-powerpoint.slideshow.macroEnabled.12"
        "vnd.ms-powerpoint.template.macroEnabled.12"
        "vnd.ms-word.document.macroEnabled.12"
        "vnd.ms-word.template.macroEnabled.12"
        "vnd.sun.xml.calc"
        "vnd.sun.xml.impress"
        "vnd.sun.xml.writer"
        "vnd.sun.xml.writer.template"
        "vnd.ms-visio.drawing.macroEnabled.main+xml"
        "vnd.ms-visio.drawing.main+xml"
        "vnd.ms-visio.stencil.macroEnabled.main+xml"
        "vnd.ms-visio.stencil.main+xml"
        "vnd.ms-visio.template.macroEnabled.main+xml"
        "vnd.ms-visio.template.main+xml"
        "x-hwp"
        "vnd.apple.keynote"
        "vnd.apple.numbers"
        "vnd.apple.pages"
        "x-mobipocket-ebook"
      ])
      ++ (mkEntries "text" "zaread.desktop" [
        "csv"
        "markdown"
        "x-markdown"
        "x-typst"
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
