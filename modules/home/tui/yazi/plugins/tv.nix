{pkgs, ...}: {
  # Register the tv plugin source.
  programs.yazi.plugins.tv = pkgs.nur.repos.adam0.yaziPlugins.tv;

  # Replace Yazi's builtin jump pickers with television.
  programs.yazi.keymap.mgr.prepend_keymap = [
    {
      on = ["z"];
      run = "plugin tv";
      desc = "Jump to a file via television";
    }
    {
      on = ["Z"];
      run = "plugin tv dirs";
      desc = "Jump to a directory via television";
    }
  ];
}
