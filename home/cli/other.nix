{
  pkgs,
  ...
}:

{
  home.packages = builtins.attrValues {
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
