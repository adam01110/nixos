{
  config,
  lib,
  pkgs,
  ...
}:

{
  avahi = {
    enable = true;

    nssmdns4 = true;
    nssmdns6 = true;
  };
}
