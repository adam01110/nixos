{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (vars) username;

  cfgPodman = config.optServices.podman;
in {
  options.optServices.podman.enable = mkEnableOption "Enable podman services.";

  config = mkIf cfgPodman.enable {
    virtualisation.podman = {
      # enable podman service and tooling.
      enable = true;

      # expose docker-compatible socket for tooling that expects dockerd.
      dockerSocket.enable = true;

      # clean up unused images/containers regularly.
      autoPrune = {
        enable = true;

        flags = [
          "--all"
          "--force"
        ];
      };
    };

    # add user to the podman group.
    users.users.${username}.extraGroups = ["podman"];

    environment.systemPackages = [pkgs.podman-compose];
  };
}
