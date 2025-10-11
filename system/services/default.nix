{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./ananicy.nix
    ./avahi.nix
    ./fwupd.nix
    ./geoclue.nix
    ./locate.nix
    ./network.nix
    ./other.nix
    ./pipewire.nix
    ./printing.nix
    ./sddm.nix
    ./ssh.nix
    ./timezone.nix
    ./zram.nix
  ];
}
