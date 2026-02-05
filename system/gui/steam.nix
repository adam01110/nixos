{pkgs, ...}:
# steam with proton ge, and sensible defaults.
{
  programs.steam = {
    enable = true;

    # use millennium.
    package = pkgs.millennium-steam;

    # open necessary ports for remote play and on-LAN transfers.
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    protontricks.enable = true;

    # include custom proton builds.
    extraCompatPackages = [pkgs.proton-ge-bin];

    fontPackages = [pkgs.noto-fonts-cjk-sans];
  };
}
