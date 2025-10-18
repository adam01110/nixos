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
    ./bluetooth.nix
    ./fwupd.nix
    ./geoclue.nix
    ./gnome-keyring.nix
    ./locate.nix
    ./network.nix
    ./other.nix
    ./pipewire.nix
    ./printing.nix
    ./sddm.nix
    ./ssh.nix
    ./timesyncd.nix
    ./timezone.nix
    ./zram.nix
  ];
}
