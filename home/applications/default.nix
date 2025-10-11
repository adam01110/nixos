{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./zen
    ./czkawka.nix
    ./equibop.nix
    ./ghostty.nix
    ./lutris.nix
    ./onlyoffice.nix
    ./other.nix
    ./prism.nix
    ./pwvucontrol.nix
    ./sober.nix
    ./zathura.nix
    ./zed.nix
  ];
}
