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

    gnupg = {
      home = osConfig.sops.gnupg.home;
      sshKeyPaths = osConfig.sops.gnupg.sshKeyPaths;
    };
  };
}
