{
  vars,
  ...
}:

# desktop host profile: hardware, home manager imports, and optional services.
let
  inherit (vars) username;
in
{
  networking.hostName = "desktop";

  # import host-specific hardware configuration.
  imports = [ ./hardware.nix ];
  home-manager.users.${username}.imports = [ ./home.nix ];

  # primary install disk for disko partitioning.
  disko.selectedDisk = "/dev/nvme0n1";

  # per-host optional services and settings.
  optServices = {
    timezone = "Europe/Amsterdam";
    virtManager.enable = true;
  };

  # extra hardware toggles.
  hardware = {
    wooting.enable = true;
    roccat.enable = true;
  };
}
