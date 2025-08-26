{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.fd = {
    enable = true;

    hidden = true;
    extraOptions = [ "--color always" ];
  };
}
