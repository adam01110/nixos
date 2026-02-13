{
  pkgs,
  lib,
  ...
}: let
  inherit (builtins) attrValues;
  inherit
    (lib)
    getExe
    getExe'
    makeBinPath
    ;
  inherit (pkgs) symlinkJoin;
in {
  # Configure ripgrep-all with wrapper-provided adapter dependencies.
  programs.ripgrep-all = {
    # Wrap rga for custom adapters.
    package = symlinkJoin {
      name = "ripgrep-all-wrapped";
      paths = [pkgs.ripgrep-all];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/rga \
          --prefix PATH : ${makeBinPath (attrValues {
          inherit
            (pkgs)
            csvkit
            gron
            qq
            ;
        })}
      '';
    };

    # Add custom adapters for additional file formats.
    custom_adapters = [
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
        binary = getExe (pkgs.callPackage ./scripts/_pptx2md-adapter.nix {});
        args = ["--disable-image" "--disable-wmf" "-"];
        disabled_by_default = false;
        match_only_by_mime = false;
      }
      # Convert JSON into line-oriented assignments for grep.
      {
        name = "json";
        version = 1;
        description = "Transform JSON into discrete JS assignments";
        extensions = ["json"];
        mimetypes = ["application/json"];
        binary = getExe pkgs.gron;
        disabled_by_default = false;
        match_only_by_mime = false;
      }
      # Convert TOML into gron-style assignments through qq.
      {
        name = "toml";
        version = 1;
        description = "Transform Markup files into greppable assignments";
        extensions = ["toml"];
        mimetypes = ["application/toml"];
        binary = getExe pkgs.nur.repos.adam0.qq-jfryy;
        args = ["--monochrome-output" "--output" "gron" "--input" "toml"];
        disabled_by_default = false;
        match_only_by_mime = false;
      }
      # Convert XML into gron-style assignments through qq.
      {
        name = "xml";
        version = 1;
        description = "Transform Markup files into greppable assignments";
        extensions = ["xml"];
        mimetypes = ["application/xml" "text/xml"];
        binary = getExe pkgs.nur.repos.adam0.qq-jfryy;
        args = ["--monochrome-output" "--output" "gron" "--input" "xml"];
        disabled_by_default = false;
        match_only_by_mime = false;
      }
      # Convert YAML into gron-style assignments through qq.
      {
        name = "yaml";
        version = 1;
        description = "Transform Markup files into greppable assignments";
        extensions = ["yml" "yaml"];
        mimetypes = ["application/yaml" "text/yaml"];
        binary = getExe pkgs.nur.repos.adam0.qq-jfryy;
        args = ["--monochrome-output" "--output" "gron" "--input" "yaml"];
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
        binary = getExe (pkgs.callPackage ./scripts/_djvutorga-adapter.nix {});
        disabled_by_default = false;
        match_only_by_mime = false;
      }
    ];
  };
}
