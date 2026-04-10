{pkgs, ...}: let
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
    nix-index-database.comma.enable = true;

    nix-index.enable = true;

    ripgrep.enable = true;
    # keep-sorted end
  };
  # keep-sorted end
}
