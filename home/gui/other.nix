{
  osConfig,
  lib,
  pkgs,
  ...
}:
# Gui application and gui flatpak packages.
let
  inherit (builtins) attrValues;
  inherit (lib) optional;
in {
  # Install applications from nixpkgs and nur.
  home.packages =
    attrValues {
      inherit
        (pkgs)
        aseprite
        bleachbit
        bitwarden-desktop
        decibels
        gimp
        gnome-calculator
        helvum
        loupe
        obsidian
        protonvpn-gui
        showtime
        upscayl
        warehouse
        heroic
        devtoolbox
        krita
        ;

      inherit
        (pkgs.nur.repos.forkprince)
        helium-nightly
        beeper-nightly
        ;
    }
    ++ optional osConfig.hardware.wooting.enable pkgs.wootility;

  # Install applications via flatpak.
  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "io.mrarm.mcpelauncher"
  ];
}
