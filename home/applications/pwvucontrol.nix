{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.pwvucontrol ];

  dconf.settings = {
    "/com/saivert/pwvucontrol".enable-overamplification = true;
  };
}
