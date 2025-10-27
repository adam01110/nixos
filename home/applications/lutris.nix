{
  config,
  lib,
  pkgs,
  ...
}:

{
  config.programs.lutris = {
    enable = true;

    #steamPackage = pkgs.steam-millennium;

    extraPackages =
      let
        protonCachyos =
          if pkgs.stdenv.hostPlatform.avx512Support or false then
            pkgs.proton-cachyos_x86_64_v4
          else if pkgs.stdenv.hostPlatform.avx2Support or false then
            pkgs.proton-cachyos_x86_64_v3
          else if pkgs.stdenv.hostPlatform.sse4_2Support or false then
            pkgs.proton-cachyos_x86_64_v2
          else
            pkgs.proton-cachyos;
      in
      [
        pkgs.umu-launcher
        protonCachyos
      ];

    protonPackages = [ pkgs.proton-ge-bin ];
  };
}
