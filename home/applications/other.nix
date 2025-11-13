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
      helvum
      mcpelauncher-ui-qt
      newsflash
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
    "io.github.plrigaux.sysd-manager"
    "io.github.radiolamp.mangojuice"
    "info.febvre.Komikku"
    "me.iepure.devtoolbox"
    "md.obsidian.Obsidian"
    "org.gimp.GIMP"
    "org.gnome.Calculator"
    "org.gnome.Decibels"
    "org.gnome.Loupe"
    "page.codeberg.lo_vely.Nucleus"
  ];
}
