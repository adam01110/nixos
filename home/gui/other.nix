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
      aseprite
      bleachbit
      bitwarden-desktop
      decibels
      gimp
      gnome-calculator
      helvum
      loupe
      mcpelauncher-ui-qt
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
