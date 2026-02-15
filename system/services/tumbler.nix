{pkgs, ...}:
# Thumbnail support for images.
let
  inherit (builtins) attrValues;
in {
  services.tumbler.enable = true;

  # Install extra thumbnailers for common media formats.
  environment.systemPackages = attrValues {
    inherit
      (pkgs)
      webp-pixbuf-loader
      ffmpegthumbnailer
      gnome-epub-thumbnailer
      poppler
      icoextract
      ;
  };
}
