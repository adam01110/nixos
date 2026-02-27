{pkgs, ...}:
# Add some plugins to the fish shell.
{
  programs.fish = {
    # Enable plugins.
    plugins = let
      mkPlugin = pkg: {
        name = "${pkg}";
        inherit (pkgs.fishPlugins.${pkg}) src;
      };
    in
      map mkPlugin [
        "autopair"
        "done"
        "fishbang"
        "fifc"
      ];
  };
}
