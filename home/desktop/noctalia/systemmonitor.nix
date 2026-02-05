{
  config,
  lib,
  ...
}:
# Expose a gpu toggle for system monitor widgets.
let
  inherit (lib) mkEnableOption getExe;
in {
  options.noctalia.enableGpu = mkEnableOption "Enable dGPU monitoring and GPU temperature widgets.";

  # Set polling for the system monitor.
  config.programs.noctalia-shell.settings.systemMonitor = let
    # Reuse a shared 4s interval for slower sensors.
    generalInterval = 4000;
  in {
    cpuPollingInterval = 1000;
    tempPollingInterval = generalInterval;
    memPollingInterval = generalInterval;
    diskPollingInterval = generalInterval;
    networkPollingInterval = generalInterval;
    enableDgpuMonitoring = config.noctalia.enableGpu;
    externalMonitor = let
      terminalCommand = getExe config.xdg.terminal-exec.package;
      btop = getExe config.programs.btop.package;
    in "${terminalCommand} --title=Btop ${btop}";
  };
}
