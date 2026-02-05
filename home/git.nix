{
  config,
  pkgs,
  vars,
  ...
}:
# Git configuration with sops-managed email and libsecret credentials.
let
  inherit
    (vars)
    username
    gitUsername
    gitPublicSshkey
    gitSigningKey
    ;
in {
  sops = {
    secrets = {
      # Per-user git email address stored in sops.
      "git/email" = {};

      # Place the decrypted private key at a stable path used by ssh.
      "git/private_ssh_key".path = "/home/${username}/.ssh/git";
    };

    # Small include that injects the sops email into git config.
    templates."git-config".content = ''
      [user]
        email = ${config.sops.placeholder."git/email"}
    '';
  };

  # Publish the public key alongside the private key path.
  home.file.".ssh/git.pub".text = gitPublicSshkey;

  programs = {
    git = let
      # Use git full so the libsecret credential helper is available.
      gitPackage = pkgs.gitFull;
    in {
      enable = true;
      lfs.enable = true;

      package = gitPackage;

      settings = {
        # Identity.
        user = {
          name = gitUsername;
          signingkey = gitSigningKey;
        };

        # Enable gpg signing.
        commit.gpgsign = true;
        tag.gpgSign = true;

        # Store https credentials via the desktop keyring (libsecret).
        credential.helper = "${gitPackage}/libexec/git-core/git-credential-libsecret";
      };

      # Include the sops-generated snippet to set the email.
      includes = [{inherit (config.sops.templates."git-config") path;}];
    };

    # Delta pager for nicer diffs.
    delta = {
      enable = true;
      enableGitIntegration = true;

      options = {
        true-color = "always";
        line-numbers = true;

        # Hyperlink file paths to jump to locations in zed.
        hyperlinks = true;
        # ZED
        hyperlinks-file-link-format = "zed://file{path}:{line}";
      };
    };
  };
}
