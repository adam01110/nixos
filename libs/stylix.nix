{lib}:
# Helpers for Stylix-derived values.
let
  inherit (builtins) mapAttrs;
  inherit
    (lib)
    # keep-sorted start
    filterAttrs
    genAttrs
    hasPrefix
    # keep-sorted end
    ;
in {
  # Select the base0* palette used by nix-userstyles and similar consumers.
  stylixPalette = osConfig: filterAttrs (name: _: hasPrefix "base0" name) osConfig.lib.stylix.colors;

  # Convert a single Stylix color to a hex string with a leading `#`.
  stylixHexColor = name: osConfig: "#${osConfig.lib.stylix.colors.${name}}";

  # Convert stylix colors to hex strings with a leading `#`.
  stylixHexColors = osConfig: mapAttrs (_: value: "#${value}") osConfig.lib.stylix.colors;

  # Disable Stylix targets by name.
  stylixDisabledTargets = targets: genAttrs targets (_: {enable = false;});
}
