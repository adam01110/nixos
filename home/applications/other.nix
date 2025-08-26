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
      mangojuice
    ]
    ++ (with kdePackages; [
      kcalc
      gwenview
    ]);

  services.flatpak.packages = [ "com.github.tchx84.Flatseal " ];
}
