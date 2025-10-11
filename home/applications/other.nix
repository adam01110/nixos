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
      bleachbit
      devtoolbox
      euphonica
      helvum
      mangojuice
      mcpelauncher-ui-qt
      obsidian
      picard
      upscayl
      warehouse
      youtube-music
      komikku
    ]
    ++ (with kdePackages; [
      kcalc
      ark
      dolphin
      koko
    ])
    ++ (with nur.repos.Ev357; [
      helium
    ]);

  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "com.github.marhkb.Pods"
  ];
}
