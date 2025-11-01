{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./profiles.nix
    ./settings.nix
  ];

  programs.zen-browser.enable = true;
}
