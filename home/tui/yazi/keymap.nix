_:
# Yazi manager keymap overrides.
{
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = "!";
      for = "unix";
      run = "'shell '$SHELL' --block'";
      desc = "Open $SHELL here";
    }
  ];
}
