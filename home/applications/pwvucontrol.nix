{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ pwvucontrol ];

  dconf.settings."/com/saivert/pwvucontrol".enable-overamplification = true;
}
