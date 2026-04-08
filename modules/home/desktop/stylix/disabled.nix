{lib, ...}:
# Disable stylix integrations for selected applications.
let
  inherit (lib) genAttrs;
  disabled = targets: genAttrs targets (_: {enable = false;});
in {
  stylix.targets = disabled [
    "blender"
    "gnome"
    "kde"
    "obsidian"
    "vencord"
    "vesktop"
    "nixcord"
  ];
}
