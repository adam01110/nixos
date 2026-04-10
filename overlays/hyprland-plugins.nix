{inputs, ...}: final: prev: let
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
