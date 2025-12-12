{ ... }:

# enable cups printing service.
{
  services.printing = {
    enable = true;
    openFirewall = true;
  };

  # enable some fonts for ghostscript.
  fonts.enableGhostscriptFonts = true;
}
