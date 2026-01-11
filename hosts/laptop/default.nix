{vars, ...}:
# laptop host profile: hardware, home manager imports, battery-friendly defaults, and optional services.
let
  inherit (vars) username;
in {
  # system version for state compatibility - do not modify.
  system.stateVersion = "25.05";

  networking.hostName = "laptop";

  # import laptop-specific hardware configuration.
  imports = [./hardware.nix];
  home-manager.users.${username}.imports = [./home.nix];

  # primary nvme disk for disko partitioning.
  disko.selectedDisk = "/dev/nvme0n1";

  # laptop-specific optional services.
  optServices = {
    bluetooth.enable = true;
    logind.lidSwitch.enable = true;
    tlp.enable = true;
    timezone = "automatic-timezoned";
    wifi.enable = true;
    virtManager.enable = true;
  };

  # enable rcu lazy mode for better battery life.
  optTweaks.rcuLazy.enable = true;

  # advanced power management for laptop battery optimization.
  services.tlp.settings = {
    # cpu performance profiles: maximize performance on ac, conserve battery on bat.
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

    # cpu frequency limits: allow full range on ac, cap at 30% on battery.
    CPU_MIN_PERF_ON_AC = 0;
    CPU_MAX_PERF_ON_AC = 100;
    CPU_MIN_PERF_ON_BAT = 0;
    CPU_MAX_PERF_ON_BAT = 30;

    # disable cpu boost because it makes noise FOR SOME REASON ?!.
    CPU_BOOST_ON_AC = 0;

    # platform power profiles: balanced on ac, low power on battery.
    PLATFORM_PROFILE_ON_AC = "balanced";
    PLATFORM_PROFILE_ON_BAT = "low-power";

    # sleep modes.
    MEM_SLEEP_ON_AC = "s2idle";
    MEM_SLEEP_ON_BAT = "s2idle";

    # storage device for power management.
    DISK_DEVICES = "nvme-Samsung_SSD_980_PRO_500GB_S5GYNX0W331360B";

    # intel gpu frequency limits: high performance on ac, reduced on battery.
    INTEL_GPU_MIN_FREQ_ON_AC = 100;
    INTEL_GPU_MIN_FREQ_ON_BAT = 100;
    INTEL_GPU_MAX_FREQ_ON_AC = 1300;
    INTEL_GPU_MAX_FREQ_ON_BAT = 450;
    INTEL_GPU_BOOST_FREQ_ON_AC = 1300;
    INTEL_GPU_BOOST_FREQ_ON_BAT = 700;

    # disable unused amd gpu features since this is intel graphics.
    RADEON_DPM_PERF_LEVEL_ON_AC = "";
    RADEON_DPM_PERF_LEVEL_ON_BAT = "";
    AMDGPU_ABM_LEVEL_ON_AC = "";
    AMDGPU_ABM_LEVEL_ON_BAT = "";
    PCIE_ASPM_ON_AC = "";
  };

  # enable laptop hardware support.
  hardware.roccat.enable = true;
}
