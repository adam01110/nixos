{
  config,
  lib,
  pkgs,
  ...
}:

let
  protonCachyos =
    if pkgs.stdenv.hostPlatform.avx512Support or false then
      pkgs.proton-cachyos_x86_64_v4
    else if pkgs.stdenv.hostPlatform.avx2Support or false then
      pkgs.proton-cachyos_x86_64_v3
    else
      pkgs.proton-cachyos_x86_64_v2;
in
{
  config.programs.lutris = {
    enable = true;

    #steamPackage = pkgs.steam-millennium;

    extraPackages = [
      pkgs.umu-launcher
      protonCachyos
    ];

    protonPackages = [ pkgs.proton-ge-bin ];
  };
}
