{
  config,
  lib,
  pkgs,
  ...
}:

let
  dataHome = config.xdg.dataHome;
in
{
  programs.bat = {
    enable = true;

    extraPackages = [ pkgs.bat-extras.batman ];
  };

  home.sessionVariables.BAT_CACHE_PATH = "${dataHome}/bat";
}
