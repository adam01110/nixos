{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ speedtest-go ];

  programs.ripgrep.enable = true;
}
