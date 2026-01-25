_:
# default handlers for office document editing.
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
      (mkEntries "application" "onlyoffice-desktopeditors.desktop" [
        "vnd.oasis.opendocument.text"
        "vnd.apple.pages"
        "vnd.ms-word.template.macroEnabled.12"
        "vnd.sun.xml.writer"
        "vnd.ms-visio.template.main+xml"
        "vnd.ms-visio.stencil.main+xml"
        "vnd.oasis.opendocument.text-flat-xml"
        "vnd.ms-visio.drawing.macroEnabled.main+xml"
        "x-hwp"
        "vnd.ms-word.document.macroEnabled.12"
        "msword"
        "vnd.apple.keynote"
        "vnd.ms-powerpoint.presentation.macroEnabled.12"
        "vnd.oasis.opendocument.text-template"
        "rtf"
        "vnd.ms-visio.stencil.macroEnabled.main+xml"
        "vnd.oasis.opendocument.presentation"
        "vnd.ms-visio.drawing.main+xml"
        "vnd.apple.numbers"
        "vnd.oasis.opendocument.presentation-template"
        "vnd.oasis.opendocument.spreadsheet-flat-xml"
        "vnd.ms-excel"
        "msword-template"
        "vnd.openxmlformats-officedocument.wordprocessingml.document"
        "vnd.openxmlformats-officedocument.spreadsheetml.template"
        "vnd.sun.xml.impress"
        "vnd.sun.xml.writer.template"
        "vnd.openxmlformats-officedocument.presentationml.presentation"
        "vnd.oasis.opendocument.spreadsheet-template"
        "vnd.ms-powerpoint.template.macroEnabled.12"
        "vnd.openxmlformats-officedocument.presentationml.slideshow"
        "vnd.oasis.opendocument.spreadsheet"
        "vnd.ms-visio.template.macroEnabled.main+xml"
        "vnd.ms-excel.sheet.macroEnabled.12"
        "vnd.openxmlformats-officedocument.wordprocessingml.template"
        "vnd.oasis.opendocument.graphics"
        "vnd.sun.xml.calc"
        "vnd.ms-powerpoint.slideshow.macroEnabled.12"
        "vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "vnd.oasis.opendocument.presentation-flat-xml"
        "vnd.ms-excel.template.macroEnabled.12"
        "vnd.openxmlformats-officedocument.presentationml.template"
        "vnd.ms-powerpoint"
        "vnd.ms-excel.sheet.binary.macroEnabled.12"
      ])
      ++ (mkEntries "text" "onlyoffice-desktopeditors.desktop" [
        "csv"
      ])
    );
}
