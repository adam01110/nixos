{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ speedtest-go ];

  programs = {
    bat.enable = true;
    ripgrep.enable = true;
  };
}
