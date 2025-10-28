{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    ;
in
{
  options.optServices.ssh.enable = mkEnableOption "Enable Ssh services.";

  config =
    let
      cfgSsh = config.optServices.ssh.enable;
    in
    mkIf cfgSsh {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = true;
        };
      };
    };
}
