{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  imports = [
    ./profiles.nix
    ./settings.nix
  ];

  programs.zen-browser.enable = true;
}
