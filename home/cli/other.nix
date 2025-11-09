{
  pkgs,
  ...
}:

let
  inherit (builtins) attrValues;
in
{
  home.packages = attrValues {
    inherit (pkgs)
      speedtest-go
      tokei
      ;
  };

  programs = {
    ripgrep.enable = true;
    nix-index.enable = true;
  };
}
