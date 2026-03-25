{
  config,
  modulesPath,
  ...
}:
# Hardware profile for the laptop.
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Kernel modules for laptop hardware support.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  # Enable intel virtualization support.
  boot.kernelModules = ["kvm-intel"];

  # Enable intel microcode updates when firmware is available.
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
