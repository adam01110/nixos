{
  lib,
  pkgs,
  ...
}:
# Add custom adapters for additional file formats.
let
  inherit
    (lib)
    getExe
    getExe'
    ;
  inherit (pkgs) callPackage;
in {
  programs.ripgrep-all.custom_adapters = [
    # Extract text from XLSX spreadsheets with in2csv.
    {
      name = "xlsx";
      version = 1;
      description = "Uses in2csv to extract text from XLSX files";
      extensions = ["xlsx"];
      mimetypes = ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"];
      binary = getExe' pkgs.csvkit "in2csv";
      args = ["\${input_virtual_path}"];
      disabled_by_default = false;
      match_only_by_mime = false;
    }
    # Convert PPTX presentations with the local markdown adapter.
    {
      name = "pptx";
      version = 1;
      description = "Uses an adapter wrapper to convert PPTX files to markdown";
      extensions = ["pptx"];
      mimetypes = ["application/vnd.openxmlformats-officedocument.presentationml.presentation"];
      binary = getExe (callPackage ./scripts/_pptx2md-adapter.nix {});
      args = ["--disable-image" "--disable-wmf" "-"];
      disabled_by_default = false;
      match_only_by_mime = false;
    }
    # Extract plain text from DjVu files with a local wrapper.
    {
      name = "djvu";
      version = 1;
      description = "Uses djvused to extract plain text from DJVU files";
      extensions = ["djvu"];
      mimetypes = ["image/vnd.djvu"];
      binary = getExe (callPackage ./scripts/_djvutorga-adapter.nix {});
      disabled_by_default = false;
      match_only_by_mime = false;
    }
  ];
}
