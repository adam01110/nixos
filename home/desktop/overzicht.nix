_:
# Enable overzicht and run it as a user service.
{
  programs.overzicht = {
    enable = true;
    systemd.enable = true;
  };
}
