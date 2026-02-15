{pkgs, ...}: {
  # Register the preview-git plugin source.
  programs.yazi.plugins.preview-git = pkgs.nur.repos.adam0.yaziPlugins.preview-git;

  # Previewers that render content for preview-git.
  programs.yazi.settings.plugin.prepend_previewers = [
    {
      url = "**/.git/";
      run = "preview-git";
    }
  ];
}
