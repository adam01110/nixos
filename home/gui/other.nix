{
  pkgs,
  ...
}:

# desktop application and flatpak packages.
let
  inherit (builtins) attrValues;
in
{
  # install applications from nixpkgs and nur.
  home.packages = attrValues {
    inherit (pkgs)
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
      ;

    inherit (pkgs.kdePackages)
      ark
      dolphin
      ;

    inherit (pkgs.nur.repos.forkprince) helium-nightly;
    inherit (pkgs.nur.repos.ymstnt) beeper;
  };

  # install applications via flatpak.
  services.flatpak.packages = [
    "com.github.tchx84.Flatseal"
    "io.mrarm.mcpelauncher"
    "me.iepure.devtoolbox"
  ];
}
