{inputs, ...}: final: prev:
# Override selected Hyprland plugins from flake inputs.
let
  inherit (final.stdenv.hostPlatform) system;
in {
  hyprlandPlugins =
    prev.hyprlandPlugins
    // {
      # keep-sorted start
      inherit (inputs.hyprland-plugins.packages.${system}) hyprfocus;
      inherit (inputs.hyprsplit.packages.${system}) hyprsplit;
      # keep-sorted end
    };
}
