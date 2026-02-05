{config, ...}:
# Noctalia audio widget tuning and volume behavior.
{
  programs.noctalia-shell.settings.audio = {
    cavaFrameRate = 60;
    externalMixer = let
      inherit (config.programs.noctalia-shell.settings.appLauncher) terminalCommand;
      wiremix = config.xdg.desktopEntries.wiremix.exec;
    in "${terminalCommand} --title='Wiremix' ${wiremix}";
    visualizerType = "mirrored";
    volumeOverdrive = true;
  };
}
