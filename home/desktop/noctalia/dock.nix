{ ... }:

# dock appearance and placement rules.
{
  programs.noctalia-shell.settings.dock = {
    backgroundOpacity = 0.9;
    colorizeIcons = false;
    displayMode = "auto_hide";
    enabled = true;
    floatingRatio = 0.5;
    onlySameOutput = true;
    radiusRatio = 0.5;
    size = 0.5;
  };
}
