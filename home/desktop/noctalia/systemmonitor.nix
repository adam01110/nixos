{ ... }:

# set polling for the system monitor.
{
  programs.noctalia-shell.settings.systemMonitor =
    let
      # reuse a shared 4s interval for slower sensors.
      generalInterval = 4000;
    in
    {
      cpuPollingInterval = 1000;
      tempPollingInterval = generalInterval;
      memPollingInterval = generalInterval;
      diskPollingInterval = generalInterval;
      networkPollingInterval = generalInterval;
    };
}
