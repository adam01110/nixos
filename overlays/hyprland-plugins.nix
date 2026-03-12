{inputs, ...}: final: prev:
# Override selected Hyprland plugins from flake inputs.
let
  inherit (final.stdenv.hostPlatform) system;
in {
  hyprlandPlugins =
    prev.hyprlandPlugins
    // {
      inherit (inputs.hyprsplit.packages.${system}) hyprsplit;
      inherit (inputs.hyprland-plugins.packages.${system}) hyprfocus;
    };
}
