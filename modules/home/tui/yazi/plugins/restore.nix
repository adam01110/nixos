{pkgs, ...}: {
  # Register the restore plugin source.
  programs.yazi.plugins.restore = pkgs.yaziPlugins.restore;

  # Bind restore actions.
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = ["u"];
      run = "plugin restore";
      desc = "Restore last deleted files/folders";
    }
  ];
}
