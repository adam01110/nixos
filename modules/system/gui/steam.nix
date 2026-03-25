{pkgs, ...}:
# Steam with proton ge, and sensible defaults.
{
  programs.steam = {
    enable = true;

    # Use millennium.
    package = pkgs.millennium-steam;

    # Open necessary ports for remote play and on-LAN transfers.
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    protontricks.enable = true;

    # Include custom proton builds.
    extraCompatPackages = [pkgs.proton-ge-bin];

    fontPackages = [pkgs.noto-fonts-cjk-sans];
  };
}
