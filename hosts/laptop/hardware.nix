{
  config,
  modulesPath,
  system,
  ...
}:
# hardware profile for the laptop.
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # kernel modules for laptop hardware support.
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  # enable intel virtualization support.
  boot.kernelModules = ["kvm-intel"];

  nixpkgs.hostPlatform = system;

  # enable intel microcode updates when firmware is available.
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
