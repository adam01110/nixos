{ pkgs, ... }:

# configure thunar with core plugins for archives and removable media.
let
  inherit (builtins) attrValues;
in
{
  programs.thunar = {
    enable = true;

    plugins = attrValues {
      inherit (pkgs.xfce)
        thunar-archive-plugin
        thunar-volman
        ;
    };
  };
}
