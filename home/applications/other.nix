{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages =
    with pkgs;
    [
      (bottles.overrideAttrs (old: {
        removeWarningPopup = true;
      }))
      bleachbit
      decibels
      devtoolbox
      gnome-calculator
      helvum
      komikku
      loupe
      mangojuice
      mcpelauncher-ui-qt
      newsflash
      obsidian
      onthespot
      picard
      protonplus
      showtime
      upscayl
      warehouse
      wootility
      youtube-music
    ]
    ++ (with kdePackages; [
      ark
      dolphin
    ])
    ++ (with nur.repos.Ev357; [
      helium
    ]);

  services.flatpak.packages = [
    "com.github.marhkb.Pods"
    "com.github.tchx84.Flatseal"
  ];
}
