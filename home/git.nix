{
  config,
  lib,
  pkgs,
  ...
}:

let
  gitPackage = pkgs.gitFull;
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;

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
    # TODO
  };
}
