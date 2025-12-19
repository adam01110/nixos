{ ... }:

# misc system applications enabled here.
{
  programs = {
    # enable seahore an application for managing encryption keys and passwords in the gnome keyring.
    seahorse.enable = true;

    # enable system-config-printer for an gui for managing printers.
    system-config-printer.enable = true;
  };
}
