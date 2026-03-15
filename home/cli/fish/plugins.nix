{pkgs, ...}:
# Add some plugins to the fish shell.
{
  programs.fish = {
    # Enable plugins.
    plugins = let
      mkPlugin = source: pkg: {
        name = pkg;
        inherit (source.${pkg}) src;
      };
    in
      (map (mkPlugin pkgs.fishPlugins) [
        "autopair"
        "done"
        "fishbang"
        "fish-you-should-use"
      ])
      ++ [(mkPlugin pkgs.nur.repos.adam0.fishPlugins "fifc")];
  };
}
