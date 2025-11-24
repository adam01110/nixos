{
  config,
  pkgs,
  vars,
  ...
}:

# git configuration with sops-managed email and libsecret credentials.
let
  inherit (vars)
    username
    gitUsername
    gitPublicSshkey
    gitSigningkey
    ;
in
{
  sops = {
    secrets = {
      # per-user git email address stored in sops.
      "git/email" = { };

      # place the decrypted private key at a stable path used by ssh.
      "git/private_ssh_key".path = "/home/${username}/.ssh/git";
    };

    # small include that injects the sops email into git config.
    templates."git-config".content = ''
      [user]
        email = ${config.sops.placeholder."git/email"}
    '';
  };

  # publish the public key alongside the private key path.
  home.file.".ssh/git.pub".text = gitPublicSshkey;

  programs = {
    git =
      let
        # use git full so the libsecret credential helper is available.
        gitPackage = pkgs.gitFull;
      in
      {
        enable = true;
        package = gitPackage;

        settings = {
          # identity.
          user = {
            name = gitUsername;
            signingkey = gitSigningkey;
          };

          # enable gpg signing.
          commit.gpgsign = true;
          tag.gpgSign = true;

          # store https credentials via the desktop keyring (libsecret).
          credential.helper = "${gitPackage}/libexec/git-core/git-credential-libsecret";
        };

        # include the sops-generated snippet to set the email.
        includes = [ { path = config.sops.templates."git-config".path; } ];
      };

    # delta pager for nicer diffs.
    delta = {
      enable = true;
      enableGitIntegration = true;

      options = {
        true-color = "always";
        line-numbers = true;

        # hyperlink file paths to jump to locations in zed.
        hyperlinks = true;
        # ZED
        hyperlinks-file-link-format = "zed://file{path}:{line}";
      };
    };
  };
}
