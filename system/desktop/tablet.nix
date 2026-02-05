_: {
  # Enable opentabletdriver.
  hardware.opentabletdriver.enable = true;

  # Required by opentabletdriver.
  hardware.uinput.enable = true;
  boot.kernelModules = ["uinput"];
}
