{inputs, ...}: final: prev:
# Override selected Hyprland plugins from flake inputs.
let
  inherit (final.stdenv.hostPlatform) system;
in {
  hyprlandPlugins = prev.hyprlandPlugins // {
    hyprsplit = inputs.hyprsplit.packages.${system}.hyprsplit;
    hyprfocus = inputs.hyprland-plugins.packages.${system}.hyprfocus;
  };
}
