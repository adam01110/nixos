{config, ...}: {
  # Keep the pre-26.05 gtk4 theme default until home.stateVersion is bumped.
  gtk.gtk4.theme = config.gtk.theme;

  stylix.targets.gtk.extraCss = ''
    * { border-radius: 0px; }
    *::before { border-radius: 0px; }
    *::after { border-radius: 0px; }
  '';
}
