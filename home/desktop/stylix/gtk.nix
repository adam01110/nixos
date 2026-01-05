{ ... }:

# remove all rounded corners from gtk apps.
{
  stylix.targets.gtk.extraCss = ''
    * { border-radius: 0px; }
    *::before { border-radius: 0px; }
    *::after { border-radius: 0px; }
  '';
}
