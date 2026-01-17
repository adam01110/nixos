_:
# dock appearance and placement rules for application launcher.
{
  programs.noctalia-shell.settings.dock = {
    colorizeIcons = false;
    displayMode = "auto_hide";
    enabled = true;
    floatingRatio = 0.5;
    onlySameOutput = true;
    size = 0.3;
    backgroundOpacity = 0.95;
  };
}
