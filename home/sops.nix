{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:

{
  sops = {
    defaultSopsFile = osConfig.sops.defaultSopsFile;
    defaultSopsFormat = osConfig.sops.defaultSopsFormat;
    validateSopsFiles = osConfig.sops.validateSopsFiles;

    age = {
      sshKeyPaths = osConfig.sops.age.sshKeyPaths;
      keyFile = osConfig.sops.age.keyFile;
      generateKey = osConfig.sops.age.generateKey;
    };
  };
}
