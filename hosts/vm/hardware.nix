{
  modulesPath,
  system,
  ...
}:
# hardware profile for qemu/kvm virtual machines.
{
  imports = [(modulesPath + "/profiles/qemu-guest.nix")];

  # kernel modules appropriate for generic vms.
  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "sr_mod"
    "virtio_blk"
  ];
  boot.kernelModules = ["kvm-intel"];

  nixpkgs.hostPlatform = system;
}
