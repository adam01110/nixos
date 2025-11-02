{
  pkgs,
  vars,
  ...
}:

let
  inherit (vars) username;
in
{
  networking.hostName = "laptop";

  imports = [ ./hardware.nix ];
  home-manager.users.${username}.imports = [ ./home.nix ];

  disko.selectedDisk = "/dev/nvme0n1";

  optServices = {
    bluetooth.enable = true;
    fwupd.enable = true;
    printing.enable = true;
    timezone = "automatic-timezoned";
    wifi.enable = true;
  };

  services.tlp = {
    enable = true;

    settings = {
      TLP_ENABLE = 1;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;
      CPU_BOOST_ON_AC = 0;
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      MEM_SLEEP_ON_AC = "s2idle";
      MEM_SLEEP_ON_BAT = "deep";
      DISK_DEVICES = "nvme-Samsung_SSD_980_PRO_500GB_S5GYNX0W331360B";
      INTEL_GPU_MIN_FREQ_ON_AC = 100;
      INTEL_GPU_MIN_FREQ_ON_BAT = 100;
      INTEL_GPU_MAX_FREQ_ON_AC = 1300;
      INTEL_GPU_MAX_FREQ_ON_BAT = 450;
      INTEL_GPU_BOOST_FREQ_ON_AC = 1300;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 700;
      RADEON_DPM_PERF_LEVEL_ON_AC = "";
      RADEON_DPM_PERF_LEVEL_ON_BAT = "";
      AMDGPU_ABM_LEVEL_ON_AC = "";
      AMDGPU_ABM_LEVEL_ON_BAT = "";
      PCIE_ASPM_ON_AC = "";
    };
  };

  home.packages = [ pkgs.powertop ];

  hardware.roccat.enable = true;
}
