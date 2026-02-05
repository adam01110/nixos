{pkgs, ...}:
# yazi plugin from nixpkgs and nur.
let
  inherit (builtins) listToAttrs;
  inherit (pkgs.lib.attrsets) nameValuePair;
in {
  programs.yazi = {
    plugins = let
      mkPlugin = source: name: nameValuePair name source.${name};

      # plugins from nixpkgs.
      nixpkgsPlugins = [
        "full-border"
        "git"
        "mediainfo"
        "smart-enter"
        "smart-paste"
        "starship"
        "relative-motions"
      ];
      # plugins from adam0's nur set.
      adam0Plugins = [
        "faster-piper"
        "ucp"
      ];
      # plugins from xyenon's nur set.
      xyenonPlugins = [
        "types"
      ];
    in
      listToAttrs (
        (map (mkPlugin pkgs.yaziPlugins) nixpkgsPlugins)
        ++ (map (mkPlugin pkgs.nur.repos.adam0.yaziPlugins) adam0Plugins)
        ++ (map (mkPlugin pkgs.nur.repos.xyenon.yaziPlugins.yazi-rs) xyenonPlugins)
      );
  };
}
