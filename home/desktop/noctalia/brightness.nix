{ ... }:

# brightness slider tuning for noctalia shell.
{
  programs.noctalia-shell.settings.brightness = {
    brightnessStep = 5;
    enableDdcSupport = true;
    enforceMinimum = false;
  };
}
