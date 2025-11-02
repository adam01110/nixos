{
  pkgs,
  ...
}:

{
  programs.steam = {
    enable = true;
    #package = pkgs.steam-millennium;

    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    protontricks.enable = true;

    extraCompatPackages =
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
        protonCachyos
        pkgs.proton-ge-custom
      ];

    fontPackages = [ pkgs.noto-fonts-cjk-sans ];
  };
}
