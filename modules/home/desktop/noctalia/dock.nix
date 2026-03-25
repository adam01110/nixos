_:
# Dock appearance and placement rules for application launcher.
{
  programs.noctalia-shell.settings.dock = {
    enabled = false;
    colorizeIcons = false;
    displayMode = "auto_hide";
    floatingRatio = 0.5;
    onlySameOutput = true;
    size = 0.3;
    backgroundOpacity = 0.95;
  };
}
