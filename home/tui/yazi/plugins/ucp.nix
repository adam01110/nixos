{pkgs, ...}: {
  # Register the ucp plugin source.
  programs.yazi.plugins.ucp = pkgs.nur.repos.adam0.yaziPlugins.ucp;

  # Add ucp clipboard bindings with notifications.
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = "p";
      run = "plugin ucp paste";
      desc = "Paste";
    }
    {
      on = "y";
      run = "plugin ucp copy";
      desc = "Copy";
    }
    {
      on = "p";
      run = "plugin ucp paste notify";
      desc = "Paste";
    }
    {
      on = "y";
      run = "plugin ucp copy notify";
      desc = "Copy";
    }
  ];
}
