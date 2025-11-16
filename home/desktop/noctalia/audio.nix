{ ... }:

# noctalia audio widget tuning and volume behavior.
{
  programs.noctalia-shell.settings.audio = {
    cavaFrameRate = 60;
    visualizerQuality = "low";
    visualizerType = "mirrored";
    volumeOverdrive = true;
    volumeStep = 5;
  };
}
