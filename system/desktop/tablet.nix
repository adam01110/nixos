_: {
  # enable opentabletdriver.
  hardware.opentabletdriver.enable = true;

  # required by opentabletdriver.
  hardware.uinput.enable = true;
  boot.kernelModules = ["uinput"];
}
