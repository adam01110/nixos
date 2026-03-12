{
  lib,
  pkgs,
  ...
}:
# Add custom adapters for additional file formats with gron.
let
  inherit (lib) getExe;

  gron = getExe pkgs.gron;
  qq = getExe pkgs.nur.repos.adam0.qq-jfryy;
in {
  programs.ripgrep-all.custom_adapters = [
    # Convert JSON into line-oriented assignments for grep.
    {
      name = "json";
      version = 1;
      description = "Transform JSON into discrete JS assignments";
      extensions = ["json"];
      mimetypes = ["application/json" "text/json"];
      binary = gron;
      disabled_by_default = false;
      match_only_by_mime = false;
    }

    # Convert TOML into gron-style assignments through qq.
    {
      name = "toml";
      version = 1;
      description = "Transform Markup files into greppable assignments";
      extensions = ["toml"];
      mimetypes = ["application/toml" "text/toml"];
      binary = qq;
      args = ["--monochrome-output" "--output" "${gron}" "--input" "toml"];
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
      binary = qq;
      args = ["--monochrome-output" "--output" "${gron}" "--input" "xml"];
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
      binary = qq;
      args = ["--monochrome-output" "--output" "${gron}" "--input" "yaml"];
      disabled_by_default = false;
      match_only_by_mime = false;
    }
    # Convert JSONC into gron-style assignments through qq.
    {
      name = "jsonc";
      version = 1;
      description = "Transform Markup files into greppable assignments";
      extensions = ["jsonc"];
      mimetypes = ["application/jsonc" "text/jsonc"];
      binary = qq;
      args = ["--monochrome-output" "--output" "${gron}" "--input" "jsonc"];
      disabled_by_default = false;
      match_only_by_mime = false;
    }
  ];
}
