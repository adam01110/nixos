{pkgs, ...}:
# gio/gvfs backends: trash, smb/mtp/afc, network mounts, etc.
{
  services.gvfs = {
    enable = true;

    # use minimal gvfs without the full gnome desktop.
    package = pkgs.gvfs;
  };
}
