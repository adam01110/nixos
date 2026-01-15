{vars, ...}:
# desktop host profile: hardware, home manager imports, and optional services.
let
  inherit (vars) username;
in {
  # system version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  networking.hostName = "desktop";

  # import desktop-specific hardware configuration.
  imports = [./hardware.nix];
  home-manager.users.${username}.imports = [./home.nix];

  # primary nvme disk for disko partitioning.
  disko.selectedDisk = "/dev/nvme0n1";

  # desktop-specific optional services.
  optServices = {
    podman.enable = true;
    timezone = "Europe/Amsterdam";
  };

  # enable specialized hardware support.
  hardware = {
    wooting.enable = true;
    roccat.enable = true;
  };

  # enable amd rocm support for gpu.
  nixpkgs.config.rocmSupport = true;
}
