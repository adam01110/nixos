{
  config,
  lib,
  pkgs,
  username,
  ...
}:

let
  gitPackage = pkgs.gitFull;
in
{
  sops = {
    secrets = {
      "git/username" = { };
      "git/email" = { };

      "git/private_ssh_key".path = "/home/${username}/.ssh/git";
      "git/public_ssh_key".path = "/home/${username}/.ssh/git.pub";
    };

    templates."git-config".content = ''
      [user]
        name = ${config.sops.placeholder."git/username"}
        email = ${config.sops.placeholder."git/email"}
    '';
  };

  programs = {
    git = {
      enable = true;

      package = gitPackage;

      settings.credential.helper = "${gitPackage}/libexec/git-core/git-credential-libsecret";
      includes = [ { path = config.sops.templates."git-config".path; } ];
    };

    delta = {
      enable = true;
      enableGitIntegration = true;

      options = {
        true-color = "always";
        line-numbers = true;
        side-by-side = true;

        hyperlinks = true;
        hyperlinks-file-link-format = "zed://file{path}:{line}";
      };
    };
  };
}
