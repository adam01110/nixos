{
  # keep-sorted start
  config,
  lib,
  pkgs,
  vars,
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
  inherit (vars) username;

  cfgPodman = config.optServices.podman;
in {
  options.optServices.podman = {
    enable = mkEnableOption "Enable podman services.";
    autoPrune.enable = mkEnableOption "Enable podman auto-prune.";
  };

  config = mkIf cfgPodman.enable {
    # keep-sorted start block=yes newline_separated=yes
    environment.systemPackages = [pkgs.podman-compose];

    # Add user to the podman group.
    users.users.${username}.extraGroups = ["podman"];

    # Disable the podman compose warning about external command execution.
    virtualisation.containers.containersConf.settings.engine.compose_warning_logs = false;

    virtualisation.podman = {
      # Enable podman service and tooling.
      enable = true;
      # Expose docker-compatible socket for tooling that expects dockerd.
      dockerSocket.enable = true;

      # Clean up unused images/containers regularly.
      autoPrune = mkIf cfgPodman.autoPrune.enable {
        enable = true;

        flags = [
          # keep-sorted start
          "--all"
          "--force"
          # keep-sorted end
        ];
      };
    };
    # keep-sorted end
  };
}
