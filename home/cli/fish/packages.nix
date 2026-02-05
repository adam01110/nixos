{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  # Tools used by aliases, functions, and plugins.
  home.packages = attrValues {
    inherit
      (pkgs)
      # Greeting.
      fortune
      boxes
      # Fifc.
      file
      # Tar.
      gnutar
      # Zip.
      zip
      unzip
      # Rar.
      rar
      # 7z.
      _7zz
      ;
  };
}
