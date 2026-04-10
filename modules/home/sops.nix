{osConfig, ...}:
# Reuse the system’s sops settings in home manager.
{
  sops = {
    # keep-sorted start
    inherit (osConfig.sops) defaultSopsFile;
    inherit (osConfig.sops) defaultSopsFormat;
    inherit (osConfig.sops) validateSopsFiles;
    # keep-sorted end

    age = {
      # keep-sorted start
      inherit (osConfig.sops.age) generateKey;
      inherit (osConfig.sops.age) keyFile;
      inherit (osConfig.sops.age) sshKeyPaths;
      # keep-sorted end
    };
  };
}
