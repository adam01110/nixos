{pkgs, ...}:
# thumbnail support for images.
let
  inherit (builtins) attrValues;
in {
  services.tumbler.enable = true;

  environment.systemPackages = attrValues {
    inherit
      (pkgs)
      webp-pixbuf-loader
      ffmpegthumbnailer
      ;
  };
}
