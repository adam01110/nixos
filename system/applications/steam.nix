{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.steam = {
    enable = true;
    package = pkgs.steam-millennium;

    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    protontricks.enable = true;

    extraCompatPackages = with pkgs; [
      proton-cachyos_x86_64_v3
      proton-ge-bin
    ];

    fontPackages = with pkgs; [ noto-fonts-cjk-sans ];
  };
}
