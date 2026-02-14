{pkgs, ...}: {
  # Register the smart-enter plugin source.
  programs.yazi.plugins.smart-enter = pkgs.yaziPlugins.smart-enter;

  # Use smart-enter bindings in manager mode.
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = "p";
      run = "plugin smart-paste";
      desc = "Paste into the hovered directory or CWD";
    }
    {
      on = "<Enter>";
      run = "plugin smart-enter";
      desc = "Enter the child directory, or open the file";
    }
    {
      on = "l";
      run = "plugin smart-enter";
      desc = "Enter the child directory, or open the file";
    }
    {
      on = "<right>";
      run = "plugin smart-enter";
      desc = "Enter the child directory, or open the file";
    }
    {
      on = "L";
      run = "plugin smart-enter";
      desc = "Enter the child directory, or open the file";
    }
  ];
}
