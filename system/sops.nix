{ ... }:

{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = false;
    };
  };
}
