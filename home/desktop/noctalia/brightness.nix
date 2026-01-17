_:
# brightness slider tuning for noctalia shell.
{
  programs.noctalia-shell.settings.brightness = {
    enableDdcSupport = true;
    enforceMinimum = false;
  };
}
