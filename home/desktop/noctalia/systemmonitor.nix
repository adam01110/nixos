{
  noctaliaStylix,
  ...
}:

let
  stylixSystemMonitor = noctaliaStylix.systemMonitor;
in
{
  # stylix palette for system monitor thresholds.
  programs.noctalia-shell.settings.systemMonitor = {
    criticalColor = stylixSystemMonitor.criticalColor;
    warningColor = stylixSystemMonitor.warningColor;
  };
}
