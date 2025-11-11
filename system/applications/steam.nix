{
  # steam with millennium, proton ge, and sensible defaults.
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

    # include custom proton builds.
    extraCompatPackages = [ pkgs.proton-ge-custom ];

    fontPackages = [ pkgs.noto-fonts-cjk-sans ];
  };
}
