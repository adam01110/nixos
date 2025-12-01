{
  pkgs,
  ...
}:

# configure pipewire volume control.
{
  # install pwvucontrol.
  home.packages = [ pkgs.pwvucontrol ];

  # allow overamplification via dconf.
  dconf.settings."com/saivert/pwvucontrol".enable-overamplification = true;
}
