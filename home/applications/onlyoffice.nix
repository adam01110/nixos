{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  programs.onlyoffice = {
    enable = true;

    settings = {
      inherit username;
      uitheme = "theme-night";
      uiscaling = 100;
      usegpu = true;
    };
  };
}
