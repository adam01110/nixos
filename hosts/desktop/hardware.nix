{
  config,
  modulesPath,
  system,
  ...
}:
# hardware profile for the desktop machine..
{
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  # kernel modules the desktop machine.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "uas"
    "usbhid"
    "sd_mod"
  ];
  boot.kernelModules = ["kvm-intel"];

  nixpkgs.hostPlatform = system;
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
