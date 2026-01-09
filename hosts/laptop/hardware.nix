{
  config,
  modulesPath,
  system,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.kernelModules = ["kvm-intel"];

  nixpkgs.hostPlatform = system;
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
}
