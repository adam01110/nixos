_:
# Brightness slider tuning for noctalia shell.
{
  programs.noctalia-shell.settings.brightness = {
    # keep-sorted start
    enableDdcSupport = true;
    enforceMinimum = false;
    # keep-sorted end
  };
}
