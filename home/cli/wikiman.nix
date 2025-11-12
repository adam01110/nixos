{
  pkgs,
  ...
}:

# configure wikiman.
{
  # install wikiman package.
  home.packages = [ pkgs.wikiman ];

  # write basic wikiman configuration.
  xdg.configFile."wikiman/wikiman.conf".text = ''
    man_lang = en
  '';
}
