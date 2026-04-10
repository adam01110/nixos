_:
# Per-user stylix customization layered on top of system-wide stylix theming.
{
  stylix = {
    # keep-sorted start block=yes newline_separated=yes
    # Font sizes: consistent small sizing for information density.
    fonts.sizes = {
      # keep-sorted start
      applications = 10;
      desktop = 10;
      popups = 10;
      terminal = 10;
      # keep-sorted end
    };

    # Opacity values: slightly reduced for better readability with wallpapers.
    opacity = {
      # keep-sorted start
      applications = 0.95;
      desktop = 0.95;
      popups = 0.95;
      terminal = 0.95;
      # keep-sorted end
    };
    # keep-sorted end
  };
}
