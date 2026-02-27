{pkgs, ...}:
# Brightness slider tuning for noctalia shell.
{
  programs.noctalia-shell.settings.brightness = {
    enableDdcSupport = true;
    enforceMinimum = false;
  };

  # Hardware control utilities for brightness and display management.
  home.packages = [pkgs.ddcutil];
}
