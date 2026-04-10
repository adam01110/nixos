{flakeLib, ...}: let
  inherit (flakeLib) stylixDisabledTargets;
in {
  stylix.targets = stylixDisabledTargets [
    # keep-sorted start
    "blender"
    "gnome"
    "kde"
    "nixcord"
    "obsidian"
    "vencord"
    "vesktop"
    # keep-sorted end
  ];
}
