{...}:
# on-screen display placement and timeout.
{
  programs.noctalia-shell.settings.osd = {
    autoHideMs = 2000;
    enabled = true;
    location = "top_right";
    overlayLayer = true;
  };
}
