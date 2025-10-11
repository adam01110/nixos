{
  config,
  lib,
  pkgs,
  username,
  ...
}:

{
  programs.nh = {
    enable = true;
    flake = "/home/${username}/Nixos";

    clean = {
      enable = true;
      extraArgs = "--keep-since 2d --keep 4";
    };
  };
}
