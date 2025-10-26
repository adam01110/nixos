{
  config,
  lib,
  pkgs,
  inputs,
  system,
  ...
}:

{
  environment.systemPackages = [ inputs.noctalia.packages.${system}.default ];

  services.noctalia-shell = {
    enable = true;
    target = true;
  };
}
