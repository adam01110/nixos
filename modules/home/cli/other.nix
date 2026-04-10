{pkgs, ...}:
# Install additional utilities.
let
  inherit (builtins) attrValues;
in {
  # keep-sorted start block=yes newline_separated=yes
  # Bundle general-purpose cli tools.
  home.packages = attrValues {
    inherit
      (pkgs)
      # keep-sorted start
      gitfetch
      onefetch
      speedtest-go
      sshfs
      # keep-sorted end
      ;
  };

  programs = {
    # keep-sorted start newline_separated=yes
    # Enable the nix-index-database integration with comma.
    nix-index-database.comma.enable = true;

    # Enable nix-index for finding packages that provide commands.
    nix-index.enable = true;

    # Enable ripgrep for fast recursive search.
    ripgrep.enable = true;
    # keep-sorted end
  };
  # keep-sorted end
}
