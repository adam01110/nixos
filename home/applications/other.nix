{
  pkgs,
  ...
}:

# desktop application and flatpak packages.
{
  # install applications from nixpkgs and nur.
  home.packages =
    with pkgs;
    [
      bleachbit
      bitwarden-desktop
      decibels
      fragments
      gimp
      gnome-calculator
      helvum
      komikku
      loupe
      mcpelauncher-ui-qt
      newsflash
      nucleus
      obsidian
      protonvpn-gui
      showtime
      upscayl
      warehouse
      wootility
    ]
    ++ (with kdePackages; [
      ark
      dolphin
    ])
    ++ (with nur.repos; [
      forkprince.helium-nightly
      ymstnt.beeper
    ]);

  # install applications via flatpak.
  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "me.iepure.devtoolbox"
  ];
}
