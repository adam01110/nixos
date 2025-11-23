{ ... }:

# notification bubble styling and durations.
{
  programs.noctalia-shell.settings.notifications = {
    backgroundOpacity = 0.95;
    criticalUrgencyDuration = 15;
    enableKeyboardLayoutToast = false;
    enabled = true;
    location = "top_right";
    lowUrgencyDuration = 3;
    normalUrgencyDuration = 8;
    overlayLayer = true;
    respectExpireTimeout = false;
  };
}
