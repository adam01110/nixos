{pkgs, ...}:
# Register plugins that do not have dedicated module files.
let
  inherit (builtins) listToAttrs;
  inherit (pkgs.lib.attrsets) nameValuePair;
in {
  programs.yazi.plugins = let
    mkPlugin = source: name: nameValuePair name source.${name};

    # Plugins from nixpkgs.
    nixpkgsPlugins = [
      "full-border"
      "git"
      "starship"
    ];

    # Plugins from xyenon's nur.
    xyenonPlugins = ["types"];
  in
    listToAttrs (
      (map (mkPlugin pkgs.yaziPlugins) nixpkgsPlugins)
      ++ (map (mkPlugin pkgs.nur.repos.xyenon.yaziPlugins.yazi-rs) xyenonPlugins)
    );
}
