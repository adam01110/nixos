{
  noctaliaStylix,
  ...
}:

let
  stylixFonts = noctaliaStylix.fonts;
in
{
  # ui fonts and panel styling for noctalia shell.
  programs.noctalia-shell.settings.ui = {
    fontDefault = stylixFonts.default;
    fontDefaultScale = 0.9;
    fontFixed = stylixFonts.fixed;
    fontFixedScale = 0.9;
    panelBackgroundOpacity = 0.95;
    panelsAttachedToBar = false;
    settingsPanelAttachToBar = false;
    tooltipsEnabled = true;
  };
}
