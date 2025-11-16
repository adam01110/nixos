{
  # hardware profile for qemu/kvm virtual machines.
  lib,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  # kernel modules appropriate for generic vms.
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "sr_mod"
    "virtio_blk"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  # default to x86_64 linux ABI inside VM guests.
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
