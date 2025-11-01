{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

let
  inherit (vars) username;
in
{
  programs.onlyoffice = {
    enable = true;

    settings = {
      inherit username;
      uitheme = "theme-night";
      uiscaling = 100;
      usegpu = true;
      titlebar = "system";
    };
  };
}
