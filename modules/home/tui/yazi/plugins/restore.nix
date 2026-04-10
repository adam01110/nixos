{pkgs, ...}: {
  programs.yazi = {
    # keep-sorted start block=yes newline_separated=yes
    # Bind restore actions.
    keymap.mgr.prepend_keymap = [
      {
        on = ["u"];
        run = "plugin restore";
        desc = "Restore last deleted files/folders";
      }
    ];

    # Register the restore plugin source.
    plugins.restore = pkgs.yaziPlugins.restore;
    # keep-sorted end
  };
}
