{pkgs, ...}: let
  inherit (builtins) listToAttrs;
  inherit (pkgs.lib.attrsets) nameValuePair;
in {
  imports = [
    ./plugins/faster-piper.nix
    ./plugins/mediainfo.nix
    ./plugins/relative-motions.nix
    ./plugins/smart-enter.nix
    ./plugins/smart-paste.nix
    ./plugins/ucp.nix
  ];

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
