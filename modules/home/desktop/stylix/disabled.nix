{lib, ...}:
# Disable stylix integrations for selected applications.
let
  inherit (lib) genAttrs;
  disabled = targets: genAttrs targets (_: {enable = false;});
in {
  stylix.targets = disabled [
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
