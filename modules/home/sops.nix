{osConfig, ...}:
# Reuse the system’s sops settings in home manager.
{
  sops = {
    inherit (osConfig.sops) defaultSopsFile;
    inherit (osConfig.sops) defaultSopsFormat;
    inherit (osConfig.sops) validateSopsFiles;

    age = {
      inherit (osConfig.sops.age) sshKeyPaths;
      inherit (osConfig.sops.age) keyFile;
      inherit (osConfig.sops.age) generateKey;
    };
  };
}
