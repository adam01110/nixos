{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.lutris = {
    enable = true;

    steamPackage = pkgs.steam-millennium;

    extraPackages = with pkgs; [ umu-launcher ];
    protonPackages = with pkgs; [
      proton-cachyos_x86_64_v3
      proton-ge-bin
    ];
  };
}
