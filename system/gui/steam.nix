{
  # steam with proton ge, and sensible defaults.
  pkgs,
  ...
}: {
  programs.steam = {
    enable = true;

    # open necessary ports for remote play and on-LAN transfers.
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;

    protontricks.enable = true;

    # include custom proton builds.
    extraCompatPackages = [pkgs.proton-ge-bin];

    fontPackages = [pkgs.noto-fonts-cjk-sans];
  };
}
