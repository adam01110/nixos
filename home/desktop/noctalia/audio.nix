{
  config,
  ...
}:

# noctalia audio widget tuning and volume behavior.
{
  programs.noctalia-shell.settings.audio = {
    cavaFrameRate = 60;
    externalMixer =
      let
        terminalCommand = config.programs.noctalia-shell.settings.appLauncher.terminalCommand;
        wiremix = config.xdg.desktopEntries.wiremix.exec;
      in
      "${terminalCommand} ${wiremix}";
    visualizerQuality = "low";
    visualizerType = "mirrored";
    volumeOverdrive = true;
    volumeStep = 5;
  };
}
