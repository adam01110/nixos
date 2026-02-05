{pkgs, ...}:
# thumbnail support for images.
let
  inherit (builtins) attrValues;
in {
  services.tumbler.enable = true;

  # install extra thumbnailers for common media formats.
  environment.systemPackages = attrValues {
    inherit
      (pkgs)
      webp-pixbuf-loader
      ffmpegthumbnailer
      ;
  };
}
