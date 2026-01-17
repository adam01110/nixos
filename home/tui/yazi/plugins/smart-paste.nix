_: {
  # use smart-paste bindings in manager mode.
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = "p";
      run = "plugin smart-paste";
      desc = "Paste into the hovered directory or CWD";
    }
  ];
}
