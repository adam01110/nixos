{
  # keep-sorted start
  config,
  lib,
  # keep-sorted end
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
    # keep-sorted start
    cpuPollingInterval = 1000;
    diskPollingInterval = generalInterval;
    memPollingInterval = generalInterval;
    networkPollingInterval = generalInterval;
    # keep-sorted end

    # keep-sorted start block=yes
    enableDgpuMonitoring = config.noctalia.enableGpu;
    externalMonitor = let
      # keep-sorted start
      btop = getExe config.programs.btop.package;
      terminalCommand = getExe config.xdg.terminal-exec.package;
      # keep-sorted end
    in "${terminalCommand} --title=Btop ${btop}";
    # keep-sorted end
  };
}
