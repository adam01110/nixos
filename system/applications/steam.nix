{
  config,
  lib,
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

    extraCompatPackages = builtins.attrValues {
      inherit (pkgs)
        proton-cachyos_x86_64_v3
        proton-ge-bin
        ;
    };

    fontPackages = [ pkgs.noto-fonts-cjk-sans ];
  };
}
