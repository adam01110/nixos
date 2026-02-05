{config, ...}:
# Noctalia audio widget tuning and volume behavior.
{
  programs.noctalia-shell.settings.audio = {
    cavaFrameRate = 60;
    externalMixer = config.xdg.desktopEntries.wiremix.exec;
    visualizerType = "mirrored";
    volumeOverdrive = true;
  };
}
