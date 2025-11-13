{
  pkgs,
  ...
}:

# install additional utilities.
let
  inherit (builtins) attrValues;
in
{
  home.packages = attrValues {
    inherit (pkgs)
      gitfetch
      speedtest-go
      tokei
      ;
  };

  programs = {
    ripgrep.enable = true;
    nix-index.enable = true;
  };
}
