_:
# Notification bubble styling and durations.
{
  programs.noctalia-shell.settings.notifications = {
    enableKeyboardLayoutToast = false;
    lowUrgencyDuration = 2;
    normalUrgencyDuration = 4;
    criticalUrgencyDuration = 8;
    respectExpireTimeout = false;
  };
}
