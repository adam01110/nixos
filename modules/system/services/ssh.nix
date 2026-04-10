{
  # keep-sorted start
  config,
  lib,
  # keep-sorted end
  ...
}: let
  inherit
    (lib)
    # keep-sorted start
    mkEnableOption
    mkIf
    # keep-sorted end
    ;
in {
  options.optServices.ssh.enable = mkEnableOption "Enable Ssh services.";

  config = mkIf config.optServices.ssh.enable {
    services.openssh = {
      enable = true;
      settings = {
        # Block root login over ssh.
        PermitRootLogin = "no";

        # Allow password authentication.
        PasswordAuthentication = true;
      };
    };
  };
}
