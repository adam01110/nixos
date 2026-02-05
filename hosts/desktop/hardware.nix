{
  config,
  modulesPath,
  ...
}:
# Hardware profile for the desktop machine.
{
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  # Kernel modules for desktop hardware support.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usb_storage"
    "uas"
    "usbhid"
    "sd_mod"
  ];
  # Enable intel virtualization support.
  boot.kernelModules = ["kvm-intel"];

  # Enable intel microcode updates when firmware is available.
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
