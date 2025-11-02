{
  pkgs,
  ...
}:

{
  home.packages = [ pkgs.wikiman ];

  xdg.configFile."wikiman/wikiman.conf".text = ''
    man_lang = en
  '';
}
