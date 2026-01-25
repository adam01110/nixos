{pkgs, ...}:
# install additional utilities.
let
  inherit (builtins) attrValues;
in {
  # bundle general-purpose cli tools.
  home.packages = attrValues {
    inherit
      (pkgs)
      gitfetch
      pokemon-colorscripts
      speedtest-go
      sshfs
      tokei
      ;
  };

  programs = {
    # enable ripgrep for fast recursive search.
    ripgrep.enable = true;

    # enable the nix-index-database integration with comma.
    nix-index-database.comma.enable = true;

    # enable nix-index for finding packages that provide commands.
    nix-index.enable = true;
  };
}
