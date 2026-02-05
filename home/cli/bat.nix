{
  config,
  pkgs,
  ...
}:
# Configure bat and extras.
let
  inherit (config.xdg) dataHome;
in {
  # Enable bat with manuals.
  programs.bat = {
    enable = true;

    extraPackages = [pkgs.bat-extras.batman];
  };

  # Set cache path for bat.
  home.sessionVariables.BAT_CACHE_PATH = "${dataHome}/bat";
}
