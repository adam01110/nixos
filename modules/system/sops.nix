{self, ...}: {
  sops = {
    # Keep the shared secret inventory in the repository copy.
    defaultSopsFile = "${self}/secrets/secrets.yaml";
    defaultSopsFormat = "yaml";

    # Skip validation when secrets are unavailable at eval time.
    validateSopsFiles = false;

    # Use a pre-provisioned age key file on disk.
    age = {
      sshKeyPaths = [];
      generateKey = false;
      keyFile = "/var/lib/sops-nix/key.txt";
    };
  };
}
