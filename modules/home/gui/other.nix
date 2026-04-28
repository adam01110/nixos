{
  # keep-sorted start
  lib,
  osConfig,
  pkgs,
  # keep-sorted end
  ...
}: let
  inherit (builtins) attrValues;
  inherit (lib) optional;
in {
  # keep-sorted start block=yes newline_separated=yes
  # Install applications from nixpkgs and nur.
  home.packages =
    attrValues {
      inherit
        (pkgs)
        # keep-sorted start
        aseprite
        bitwarden-desktop
        bleachbit
        crosspipe
        decibels
        gimp
        heroic
        krita
        loupe
        obsidian
        proton-vpn
        showtime
        upscayl
        warehouse
        # keep-sorted end
        ;

      inherit
        (pkgs.nur.repos.forkprince)
        # keep-sorted start
        beeper-nightly
        helium-nightly
        # keep-sorted end
        ;
    }
    ++ optional osConfig.hardware.wooting.enable pkgs.wootility;

  # Install applications via flatpak.
  services.flatpak.packages = [
    # keep-sorted start
    "com.github.tchx84.Flatseal"
    "io.mrarm.mcpelauncher"
    # keep-sorted end
  ];
  # keep-sorted end
}
