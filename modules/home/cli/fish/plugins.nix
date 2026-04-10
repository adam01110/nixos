{pkgs, ...}: let
  inherit (builtins) attrValues;
in {
  # keep-sorted start block=yes newline_separated=yes
  # Extra packages required by FzFish.
  home.packages = attrValues {
    inherit
      (pkgs)
      # FzFish
      # keep-sorted start
      hexyl
      procs
      timg
      trash-cli
      # keep-sorted end
      ;
  };

  programs.fish = {
    plugins = let
      mkPlugin = source: pkg: {
        name = pkg;
        inherit (source.${pkg}) src;
      };
    in
      (map (mkPlugin pkgs.fishPlugins) [
        # keep-sorted start
        "autopair"
        "done"
        "fish-you-should-use"
        "fishbang"
        # keep-sorted end
      ])
      ++ [(mkPlugin pkgs.nur.repos.adam0.fishPlugins "fzfish")];
  };
  # keep-sorted end
}
