{pkgs, ...}: {
  # Register the mount plugin source.
  programs.yazi.plugins.mount = pkgs.yaziPlugins.mount;

  # Bind the mount manager in manager mode.
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = "M";
      run = "plugin mount";
      desc = "Manage mount, unmount, and eject actions";
    }
  ];
}
