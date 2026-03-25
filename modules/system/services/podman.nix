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
  options.optServices.podman = {
    enable = mkEnableOption "Enable podman services.";

    autoPrune.enable = mkEnableOption "Enable podman auto-prune.";
  };

  config = mkIf cfgPodman.enable {
    virtualisation.podman = {
      # Enable podman service and tooling.
      enable = true;

      # Expose docker-compatible socket for tooling that expects dockerd.
      dockerSocket.enable = true;

      # Clean up unused images/containers regularly.
      autoPrune = mkIf cfgPodman.autoPrune.enable {
        enable = true;

        flags = [
          "--all"
          "--force"
        ];
      };
    };

    # Disable the podman compose warning about external command execution.
    virtualisation.containers.containersConf.settings.engine.compose_warning_logs = false;

    # Add user to the podman group.
    users.users.${username}.extraGroups = ["podman"];

    environment.systemPackages = [pkgs.podman-compose];
  };
}
