{
  config,
  lib,
  pkgs,
  vars,
  ...
}:

let
  inherit (vars) username gitUsername gitPublicSshkey;
in
{
  sops = {
    secrets = {
      "git/email" = { };
      "git/private_ssh_key".path = "/home/${username}/.ssh/git";
    };

    templates."git-config".content = ''
      [user]
        email = ${config.sops.placeholder."git/email"}
    '';
  };

  home.file.".ssh/git.pub".text = gitPublicSshkey;

  programs = {
    git =
      let
        gitPackage = pkgs.gitFull;
      in
      {
        enable = true;
        package = gitPackage;

        settings = {
          user.name = gitUsername;

          credential.helper = "${gitPackage}/libexec/git-core/git-credential-libsecret";
        };
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
