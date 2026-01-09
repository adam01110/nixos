{
  config,
  lib,
  ...
}:
# optional openssh server, toggled per host.
let
  inherit
    (lib)
    mkEnableOption
    mkIf
    ;
in {
  options.optServices.ssh.enable = mkEnableOption "Enable Ssh services.";

  config = mkIf config.optServices.ssh.enable {
    services.openssh = {
      enable = true;
      settings = {
        # block root login over ssh.
        PermitRootLogin = "no";

        # allow password authentication for users.
        PasswordAuthentication = true;
      };
    };
  };
}
