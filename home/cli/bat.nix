{
  config,
  pkgs,
  ...
}:
# configure bat and related extras.
let
  inherit (config.xdg) dataHome;
in {
  # enable bat with manuals.
  programs.bat = {
    enable = true;

    extraPackages = [pkgs.bat-extras.batman];
  };

  # set cache path for bat.
  home.sessionVariables.BAT_CACHE_PATH = "${dataHome}/bat";
}
