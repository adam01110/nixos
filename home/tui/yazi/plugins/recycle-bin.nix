{pkgs, ...}: {
  # Register the recycle-bin plugin source.
  programs.yazi.plugins.recycle-bin = pkgs.yaziPlugins.recycle-bin;

  # Bind key to open the recycle-bin plugin menu.
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = ["R" "b"];
      run = "plugin recycle-bin";
      desc = "Open Recycle Bin menu";
    }
  ];
}
