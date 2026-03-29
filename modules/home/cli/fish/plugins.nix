{pkgs, ...}:
# Install fish plugins and their supporting tools.
let
  inherit (builtins) attrValues;
in {
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
      ++ [(mkPlugin pkgs.nur.repos.adam0.fishPlugins "fzfish")];
  };

  # Extra packages required by FzFish.
  home.packages = attrValues {
    inherit
      (pkgs)
      # FzFish
      timg
      hexyl
      procs
      trash-cli
      ;
  };
}
