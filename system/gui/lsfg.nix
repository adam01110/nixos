{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  # add lossless scaling linux packages.
  environment.systemPackages = attrValues {
    inherit
      (pkgs)
      lsfg-vk
      lsfg-vk-ui
      ;
  };
}
