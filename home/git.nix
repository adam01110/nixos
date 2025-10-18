{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  gitPackage = pkgs.gitFull;

  gitUsername = config.sops.secrets."git/username".path;
  gitEmail = config.sops.secrets."git/email".path;
in
{
  sops.secrets = {
    "git/username" = { };
    "git/email" = { };

    "git/private_ssh_key".path = "/home/${username}/.ssh/git";
    "git/public_ssh_key".path = "/home/${username}/.ssh/git.pub";
  };

  programs.git = {
    enable = true;

    package = gitPackage;

    delta = {
      enable = true;

      options = {
        true-color = "always";
        line-numbers = true;
        side-by-side = true;

        hyperlinks = true;
        hyperlinks-file-link-format = "zed://file{path}:{line}";
      };
    };

    extraConfig.credential.helper = "${gitPackage}/libexec/git-core/git-credential-libsecret";

    userName = gitUsername;
    userEmail = gitEmail;
  };
}
