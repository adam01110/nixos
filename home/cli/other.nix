{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      tokei
      speedtest-go
      ;
  };

  programs.ripgrep.enable = true;
}
