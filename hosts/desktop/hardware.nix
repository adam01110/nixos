{
  config,
  modulesPath,
  ...
}:
# hardware profile for the desktop machine.
{
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  # kernel modules for desktop hardware support.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "uas"
    "usbhid"
    "sd_mod"
  ];
  # enable intel virtualization support.
  boot.kernelModules = ["kvm-intel"];

  # enable intel microcode updates when firmware is available.
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
