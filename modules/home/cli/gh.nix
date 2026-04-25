{vars, ...}: let
  inherit (vars) gitUsername;
in {
  programs.gh = {
    enable = true;

    hosts."github.com".user = gitUsername;

    settings = {
      telemetry = "disabled";
      git_protocol = "ssh";
    };
  };

  sessionVariables.GH_TELEMETRY = false;
}
