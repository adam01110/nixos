{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

{
  services.noctalia-shell = {
    enable = true;
    target = true;
  };
}
