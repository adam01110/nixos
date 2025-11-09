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

    extraCompatPackages = [ pkgs.proton-ge-custom ];

    fontPackages = [ pkgs.noto-fonts-cjk-sans ];
  };
}
