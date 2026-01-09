{
  config,
  lib,
  ...
}:
# expose a gpu toggle for system monitor widgets.
let
  inherit (lib) mkEnableOption;
in {
  options.noctalia.enableGpu = mkEnableOption "Enable dGPU monitoring and GPU temperature widgets.";

  # set polling for the system monitor.
  config.programs.noctalia-shell.settings.systemMonitor = let
    # reuse a shared 4s interval for slower sensors.
    generalInterval = 4000;
  in {
    cpuPollingInterval = 1000;
    tempPollingInterval = generalInterval;
    memPollingInterval = generalInterval;
    diskPollingInterval = generalInterval;
    networkPollingInterval = generalInterval;
    enableDgpuMonitoring = config.noctalia.enableGpu;
  };
}
