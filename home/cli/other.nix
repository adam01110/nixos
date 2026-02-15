{pkgs, ...}:
# Install additional utilities.
let
  inherit (builtins) attrValues;
in {
  # Bundle general-purpose cli tools.
  home.packages = attrValues {
    inherit
      (pkgs)
      gitfetch
      speedtest-go
      sshfs
      ;
  };

  programs = {
    # Enable ripgrep for fast recursive search.
    ripgrep.enable = true;

    # Enable the nix-index-database integration with comma.
    nix-index-database.comma.enable = true;

    # Enable nix-index for finding packages that provide commands.
    nix-index.enable = true;
  };
}
