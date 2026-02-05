{vars, ...}:
# Configure github cli.
let
  inherit (vars) gitUsername;
in {
  programs.gh = {
    enable = true;

    # Use ssh protocol and set user.
    settings.git_protocol = "ssh";
    hosts."github.com".user = gitUsername;
  };
}
