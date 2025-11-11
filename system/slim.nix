{
  lib,
  ...
}:

# trim down default packages and documentation to keep install small.
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
