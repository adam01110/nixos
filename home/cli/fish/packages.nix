{
  pkgs,
  ...
}:

let

  inherit (builtins) attrValues;
in
{
  # tools used by aliases, functions, and plugins.
  home.packages = attrValues {
    inherit (pkgs)
      fortune
      boxes
      file

      # tar.
      gnutar

      # zip.
      zip
      unzip

      # rar.
      rar

      # 7z.
      _7zz
      ;
  };
}
