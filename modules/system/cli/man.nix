{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  documentation = {
    man.cache.enable = true;
    dev.enable = true;
  };

  environment.systemPackages = attrValues {
    inherit
      (pkgs)
      man-pages
      man-pages-posix
      ;
  };
}
