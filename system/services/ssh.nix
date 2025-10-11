{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfgSsh = config.optServices.ssh.enable;
in
{
  options.optServices.ssh.enable = mkEnableOption "Enable Ssh services.";

  config = mkIf cfgSsh {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
  };
}
