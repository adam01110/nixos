{vars, ...}: let
  inherit (vars) gitUsername;
in {
  programs.gh = {
    enable = true;

    settings.git_protocol = "ssh";
    hosts."github.com".user = gitUsername;
  };
}
