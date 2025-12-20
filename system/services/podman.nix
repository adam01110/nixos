{
  pkgs,
  vars,
  ...
}:

let
  inherit (vars) username;
in
{
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
  users.users.${username}.extraGroups = [ "podman" ];

  environment.systemPackages = [ pkgs.podman-compose ];
}
