_:
# Configure fzf.
{
  programs.fzf = let
    enableShellIntegration = false;
  in {
    enable = true;

    enableBashIntegration = enableShellIntegration;
    enableFishIntegration = enableShellIntegration;
    enableZshIntegration = enableShellIntegration;

    # Change prompt default to look better.
    defaultOptions = [
      "--border sharp"
      "--prompt '➜ '"
    ];
  };
}
