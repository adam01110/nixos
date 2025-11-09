{
  lib,
  ...
}:

let
  inherit (lib) mkForce;
in
{
  documentation = {
    doc.enable = mkForce false;
    info.enable = mkForce false;
  };

  environment.defaultPackages = mkForce [ ];

  services = {
    orca.enable = mkForce false;
    speechd.enable = mkForce false;
  };
}
