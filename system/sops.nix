{
  config,
  lib,
  pkgs,
  ...
}:

{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;

    gnupg = {
      home = "/var/lib/sops";
      sshKeyPaths = [ ];
    };
  };
}
