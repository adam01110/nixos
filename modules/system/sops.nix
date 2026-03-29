_:
# Sops configuration for both system and home manager modules.
{
  sops = {
    # Keep the shared secret inventory in the repository copy.
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # Skip validation when secrets are unavailable at eval time.
    validateSopsFiles = false;

    # Use a pre-provisioned age key file on disk.
    age = {
      sshKeyPaths = [];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = false;
    };
  };
}
