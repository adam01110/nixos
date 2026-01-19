{pkgs, ...}:
# gui application and gui flatpak packages.
let
  inherit (builtins) attrValues;
in {
  # install applications from nixpkgs and nur.
  home.packages = attrValues {
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
      wootility
      heroic
      devtoolbox
      ;

    inherit (pkgs.nur.repos.forkprince) helium-nightly;
    inherit (pkgs.nur.repos.ymstnt) beeper;
  };

  # install applications via flatpak.
  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "io.mrarm.mcpelauncher"
  ];
}
