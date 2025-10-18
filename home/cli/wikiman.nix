{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ wikiman ];

  xdg.configFile."wikiman/wikiman.conf".text = ''
    man_lang = en
  '';
}
